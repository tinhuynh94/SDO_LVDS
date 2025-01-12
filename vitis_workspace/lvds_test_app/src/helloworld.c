/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

// zed_LEDs.c

#include <stdio.h>
#include "platform.h"
#include "xgpio.h"
#include "xbasic_types.h"
#include "xparameters.h"
#include "xil_printf.h"
#include "xscugic.h"
#include "xuartps.h"
#include "xuartps_hw.h"
#include "xil_exception.h"
#include "sleep.h"
#include "xttcps.h"


//----------------------------------------
// commands that can be received from the python application
//
#define CMD_SET_FLASH_CLK_DIV 		   0x20
#define CMD_GET_FLASH_CLK_DIV 		   0x21
#define CMD_SET_ASIC_CLK_DIV           0x22
#define CMD_GET_ASIC_CLK_DIV           0x23
#define CMD_SET_LVDS_CLK_DIV           0x24
#define CMD_GET_LVDS_CLK_DIV           0x25
#define CMD_WRITE_LVDS        		   0x26
#define CMD_TOGGLE_LVDS_VPROG          0x27
#define CMD_TOGGLE_LVDS_RESET          0x28
#define CMD_TOGGLE_LVDS_DTB            0x29
//----------------------------------------


//----------------------------------------
// responses that the zedboard will send back over UART
//
#define RESPONSE_LVDS_DONE             0x80
//----------------------------------------


//----------------------------------------
// bit masks
//
#define LVDS_VPROG_MASK                0b0001
#define LVDS_RESET_MASK                0b0010
#define LVDS_BUSY_MASK                 0b0100
#define LVDS_DTB_MASK                  0b1000
//----------------------------------------


//----------------------------------------
// Macros (Inline Functions) Definitions
//
#define XAxi_ReadReg	Xil_In32
#define XAxi_WriteReg	Xil_Out32
//----------------------------------------

//----------------------------------------
// clock divider settings
//
#define DIV_1		1
#define DIV_2		2
#define DIV_4		4
#define DIV_8		8
#define DIV_16		16
#define DIV_32		32
#define DIV_64		64
#define DIV_128		128
//----------------------------------------


//----------------------------------------
// for UartPs
//
#define INTC				XScuGic
#define UARTPS_DEVICE_ID	XPAR_XUARTPS_0_DEVICE_ID
#define UART_INTC_DEVICE_ID	XPAR_SCUGIC_SINGLE_DEVICE_ID
#define UART_INT_IRQ_ID		XPAR_XUARTPS_1_INTR
#define UART_BASEADDR		XPAR_XUARTPS_0_BASEADDR
#define RX_BUFFER_SIZE	30
//----------------------------------------


//----------------------------------------
// state machine bit definitions
//
#define STATE_LED_RUNNING		0x01
#define	STATE_UPDATE_CONDITIONS	0x02
#define STATE_SERVICE_UART		0x04
//----------------------------------------


//----------------------------------------
// function declarations
static int SetupUartPs(INTC *IntcInstPtr, XUartPs *UartInstPtr,
			u16 DeviceId, u16 UartIntrId);
static int SetupUartInterruptSystem(INTC *IntcInstancePtr,
				XUartPs *UartInstancePtr,
				u16 UartIntrId);
static void UartPsISR(void *CallBackRef, u32 Event, unsigned int EventData);
static void InitGPIO(void);
static void ReadUartBytes(void);
static void send_byte_over_UART(Xuint8 byteToSend);

static void ChangeLvdsClkDivision(u8 divSetting);
static void ChangeAsicClkDivision(u8 divSetting);
static void ChangeFlashClkDivision(u8 divSetting);
//----------------------------------------


//----------------------------------------
// variables
static XScuGic interrupt_controller;	//instance of the interrupt controller

XUartPs UartPs	;						// Instance of the UART Device
// @note: why static?
static u8 UartRxData[RX_BUFFER_SIZE];		// Buffer for Receiving Data

unsigned int state = STATE_LED_RUNNING;
int Status;

u16 numUartBytesReceived;
//----------------------------------------


//----------------------------------------
volatile unsigned int *lvdsClkDivider = (volatile unsigned int *) 0x43C00000;
volatile unsigned int *lvdsTx = (volatile unsigned int *) 0x43C10000;

u8 dummyVar;
XGpio miscLvdsGpio;
#define GPIO_CHANNEL 1	// all GPIO ports defined in the PL as single channel


int main()
{
	int looping = 1;

    init_platform();
    InitGPIO();

    Status = SetupUartPs(&interrupt_controller, &UartPs,
    				UARTPS_DEVICE_ID, UART_INT_IRQ_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	lvdsTx[2] = 0x00000000; // Disable LVDS_Tx WRITE
	//ReadUartBytes();

    //###################################################################
    //-------------------------------------------------------------------
    while(looping){

    	//-------------------------------------------------------------------
		// uart received data so find command and take action
		if (state & STATE_SERVICE_UART){
			ReadUartBytes();
			state &= ~STATE_SERVICE_UART;
		}
    }
    //-------------------------------------------------------------------
    //###################################################################

   	cleanup_platform();
    return 0;
}
//------------------------------------------------------------


//------------------------------------------------------------
int SetupUartPs(INTC *IntcInstPtr, XUartPs *UartInstPtr,
			u16 DeviceId, u16 UartIntrId)
{
	int Status;
	XUartPs_Config *Config;
	u32 IntrMask;


	/*
	 * Initialize the UART driver so that it's ready to use
	 * Look up the configuration in the config table, then initialize it.
	 */
	Config = XUartPs_LookupConfig(DeviceId);
	if (NULL == Config) {
		return XST_FAILURE;
	}

	Status = XUartPs_CfgInitialize(UartInstPtr, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/* Check hardware build */
	Status = XUartPs_SelfTest(UartInstPtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Connect the UART to the interrupt subsystem such that interrupts
	 * can occur. This function is application specific.
	 */
	Status = SetupUartInterruptSystem(IntcInstPtr, UartInstPtr, UartIntrId);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Setup the handlers for the UART that will be called from the
	 * interrupt context when data has been sent and received, specify
	 * a pointer to the UART driver instance as the callback reference
	 * so the handlers are able to access the instance data
	 */
	XUartPs_SetHandler(UartInstPtr, (XUartPs_Handler)UartPsISR, UartInstPtr);

	/*
	 * Enable the interrupt of the UART so interrupts will occur, setup
	 * a local loopback so data that is sent will be received.
	 */
	IntrMask =
		XUARTPS_IXR_TOUT | XUARTPS_IXR_PARITY | XUARTPS_IXR_FRAMING |
		XUARTPS_IXR_OVER | XUARTPS_IXR_TXEMPTY | XUARTPS_IXR_RXFULL |
		XUARTPS_IXR_RXOVR;

	if (UartInstPtr->Platform == XPLAT_ZYNQ_ULTRA_MP) {
		IntrMask |= XUARTPS_IXR_RBRK;
	}

	XUartPs_SetInterruptMask(UartInstPtr, IntrMask);

	XUartPs_SetOperMode(UartInstPtr, XUARTPS_OPER_MODE_NORMAL);

	/*
	 * Set the receiver timeout. If it is not set, and the last few bytes
	 * of data do not trigger the over-water or full interrupt, the bytes
	 * will not be received. By default it is disabled.
	 *
	 * The setting of 8 will timeout after 8 x 4 = 32 character times.
	 * Increase the time out value if baud rate is high, decrease it if
	 * baud rate is low.
	 */
	XUartPs_SetRecvTimeout(UartInstPtr, 8);

	return XST_SUCCESS;
}
//------------------------------------------------------------


//------------------------------------------------------------
void UartPsISR(void *CallBackRef, u32 Event, unsigned int EventData)
{
//	xil_printf("IRQ handler!\n");

	/* All of the data has been sent */
	if (Event == XUARTPS_EVENT_SENT_DATA) {
//		xil_printf("1\n");
	}

	/* All of the data has been received */
	if (Event == XUARTPS_EVENT_RECV_DATA) {
//		xil_printf("2\n");
		state |= STATE_SERVICE_UART;
	}

	/*
	 * Data was received, but not the expected number of bytes, a
	 * timeout just indicates the data stopped for 8 character times
	 */
	if (Event == XUARTPS_EVENT_RECV_TOUT) {
//		xil_printf("3\n");
	}

	/*
	 * Data was received with an error, keep the data but determine
	 * what kind of errors occurred
	 */
	if (Event == XUARTPS_EVENT_RECV_ERROR) {
//		xil_printf("4\n");
	}

	/*
	 * Data was received with an parity or frame or break error, keep the data
	 * but determine what kind of errors occurred. Specific to Zynq Ultrascale+
	 * MP.
	 */
	if (Event == XUARTPS_EVENT_PARE_FRAME_BRKE) {
//		xil_printf("5\n");
	}

	/*
	 * Data was received with an overrun error, keep the data but determine
	 * what kind of errors occurred. Specific to Zynq Ultrascale+ MP.
	 */
	if (Event == XUARTPS_EVENT_RECV_ORERR) {
//		xil_printf("6\n");
	}
}
//------------------------------------------------------------


//------------------------------------------------------------
static int SetupUartInterruptSystem(INTC *IntcInstancePtr,
				XUartPs *UartInstancePtr,
				u16 UartIntrId)
{
	int Status;

	XScuGic_Config *IntcConfig; /* Config for interrupt controller */

	/* Initialize the interrupt controller driver */
	IntcConfig = XScuGic_LookupConfig(UART_INTC_DEVICE_ID);
	if (NULL == IntcConfig) {
		return XST_FAILURE;
	}

	Status = XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig,
					IntcConfig->CpuBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Connect the interrupt controller interrupt handler to the
	 * hardware interrupt handling logic in the processor.
	 */
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
				(Xil_ExceptionHandler) XScuGic_InterruptHandler,
				IntcInstancePtr);

	/*
	 * Connect a device driver handler that will be called when an
	 * interrupt for the device occurs, the device driver handler
	 * performs the specific interrupt processing for the device
	 */
	Status = XScuGic_Connect(IntcInstancePtr, UartIntrId,
				  (Xil_ExceptionHandler) XUartPs_InterruptHandler,
				  (void *) UartInstancePtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/* Enable the interrupt for the device */
	XScuGic_Enable(IntcInstancePtr, UartIntrId);


	/* Enable interrupts */
	 Xil_ExceptionEnable();


	return XST_SUCCESS;
}
//------------------------------------------------------------


//------------------------------------------------------------
void InitGPIO(void){
	Status = XGpio_Initialize(&miscLvdsGpio, XPAR_GPIO_0_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return;
	}

	XGpio_SetDataDirection(&miscLvdsGpio, 1, 0b1100);
			// 3rd argument: 1=input, 0=output
			// Bit 0: VPROG CTRL (output from FPGA)
			// Bit 1: RESET CTRL (output from FPGA)
			// Bit 2: BUSY (input into FPGA)
			// Bit 3: DTB (inout)

	//XGpio_DiscreteWrite(&miscLvdsGpio, GPIO_CHANNEL, 0b1111);
}
//------------------------------------------------------------


//------------------------------------------------------------
void ReadUartBytes(void){
	u8 numBytesReceived = 0;
	unsigned int commandByte;

	// loop through Uart Rx buffer and store received data
	while (XUartPs_IsReceiveData(UART_BASEADDR)){
		UartRxData[numBytesReceived++] = XUartPs_ReadReg(UART_BASEADDR,
					    					XUARTPS_FIFO_OFFSET);
	}

	// stored for debugging purposes
	numUartBytesReceived = numBytesReceived;

	//take first received byte as the command
	commandByte = (unsigned int)UartRxData[0];
	//commandByte = CMD_WRITE_LVDS;

	// Initialize variables to be used in multiple cases
	int toggle;
	u8 current, new;

	// check received byte for valid command
	switch (commandByte){
		case (CMD_WRITE_LVDS):
			//verify 2 address bytes, 1 data byte received after command byte
			if (numBytesReceived<4){
				return;
			}

			u8 sofByte = 0b01111110;
			u8 regAddr1 = (u8)UartRxData[1];
			u8 regAddr2 = (u8)UartRxData[2];
			u8 regData = (u8) UartRxData[3];
			u8 eofByte = 0b10000001;

			//lvdsTx[0] = 0xAAAAAAAA;
			//lvdsTx[1] = 0x000000AA;

			lvdsTx[0] = (sofByte << 24) | (regAddr1 << 16) |
					(regAddr2 << 8) | regData; // 32 MSBs of message to be sent
			lvdsTx[1] = eofByte & 0x000000FF; // 8 LSBs of message to be sent*/
			lvdsTx[2] = 0x00000001; // Enable LVDS_Tx WRITE
			while(lvdsTx[3] == 0){
				//xil_printf("hi\n");
				continue;
			}
			lvdsTx[2] = 0x00000000; // Disable LVDS_Tx WRITE
			send_byte_over_UART(RESPONSE_LVDS_DONE);
			//xil_printf("done\n");

		case (CMD_SET_LVDS_CLK_DIV):
			//verify clock division setting byte was received after command byte
			if (numBytesReceived<2){
				return;
			}

			// second byte received has the division setting
			ChangeLvdsClkDivision(UartRxData[1]);

			// use new variable in call to configuration function
			//setLvdsClkDivision(Flash_CLK_div_setting);
			break;

		case (CMD_TOGGLE_LVDS_VPROG):
			//verify toggle setting byte received after command byte
			if (numBytesReceived<2){
				return;
			}

			toggle = (int)UartRxData[1];
			current = XGpio_DiscreteRead(&miscLvdsGpio,1); // current settings of each of the MISC bits
			if (toggle){
				new = current | LVDS_VPROG_MASK;
			}
			else{
				new = current & ~LVDS_VPROG_MASK;
			}

			XGpio_DiscreteWrite(&miscLvdsGpio, 1, new);
			break;

		case (CMD_TOGGLE_LVDS_RESET):
			//verify toggle setting byte received after command byte
			if (numBytesReceived<2){
				return;
			}

			toggle = (int)UartRxData[1];
			current = XGpio_DiscreteRead(&miscLvdsGpio,1); // current settings of each of the MISC bits
			if (toggle){
				new = current | LVDS_RESET_MASK;
			}
			else{
				new = current & ~LVDS_RESET_MASK;
			}

			XGpio_DiscreteWrite(&miscLvdsGpio, 1, new);
			break;

		case (CMD_TOGGLE_LVDS_DTB):
			//verify toggle setting byte received after command byte
			if (numBytesReceived<2){
				return;
			}

			toggle = (int)UartRxData[1];
			current = XGpio_DiscreteRead(&miscLvdsGpio,1); // current settings of each of the MISC bits
			XGpio_SetDataDirection(&miscLvdsGpio, 1, 0b0100); // set Bit 3 (DBT) to output
			if (toggle){
				new = current | LVDS_DTB_MASK;
			}
			else{
				new = current & ~LVDS_DTB_MASK;
			}

			XGpio_DiscreteWrite(&miscLvdsGpio, 1, new);
			break;

		/*case (CMD_SET_FLASH_CLK_DIV):
			//verify clock division setting byte was received after command byte
			if (numBytesReceived<2)
			{
				return;
			}

			// second byte received has the division setting
			ChangeFlashClkDivision(UartRxData[1]);

			// use new variable in call to configuration function
			//setFlashClkDivision(Flash_CLK_div_setting);
			break;*/
	}
}
//------------------------------------------------------------


//------------------------------------------------------------
void ChangeLvdsClkDivision(u8 divSetting)
{
	switch (divSetting){
		case (DIV_1):
			lvdsClkDivider[0] = 0x00000000;
			break;
		case (DIV_2):
			lvdsClkDivider[0] = 0x00000001;
			break;
		case (DIV_4):
			lvdsClkDivider[0] = 0x00000002;
			break;
		case (DIV_8):
			lvdsClkDivider[0] = 0x00000003;
			break;
		case (DIV_16):
			lvdsClkDivider[0] = 0x00000004;
			break;
		case (DIV_32):
			lvdsClkDivider[0] = 0x00000005;
			break;
		case (DIV_64):
			lvdsClkDivider[0] = 0x00000006;
			break;
		case (DIV_128):
			lvdsClkDivider[0] = 0x00000007;
			break;
	}
}
//------------------------------------------------------------


//------------------------------------------------------------
/*void ChangeFlashClkDivision(u8 divSetting)
{
	switch (divSetting){
		case (DIV_1):
			flashClkSel[0] = 0x00000000;
			break;
		case (DIV_2):
			flashClkSel[0] = 0x00000001;
			break;
		case (DIV_4):
			flashClkSel[0] = 0x00000002;
			break;
		case (DIV_8):
			flashClkSel[0] = 0x00000003;
			break;
		case (DIV_16):
			flashClkSel[0] = 0x00000004;
			break;
		case (DIV_32):
			flashClkSel[0] = 0x00000005;
			break;
		case (DIV_64):
			flashClkSel[0] = 0x00000006;
			break;
		case (DIV_128):
			flashClkSel[0] = 0x00000007;
			break;
	}
}*/
//------------------------------------------------------------


//------------------------------------------------------------
void send_byte_over_UART(Xuint8 byteToSend)
{
	/* Wait until there is space in TX FIFO */
	 while (XUartPs_IsTransmitFull(XPAR_XUARTPS_0_BASEADDR));

	/* Write the byte into the TX FIFO */
	XUartPs_WriteReg(XPAR_XUARTPS_0_BASEADDR, XUARTPS_FIFO_OFFSET,
						byteToSend);
}
//------------------------------------------------------------
