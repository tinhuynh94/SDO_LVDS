/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
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

#include <stdio.h>
#include "platform.h"
#include "xbasic_types.h"
#include "xgpio.h"
#include "xparameters.h"
#include "xil_printf.h"
#include "xscugic.h"
#include "sleep.h"

#define SWITCHES_AXI_ID		XPAR_AXI_GPIO_0_DEVICE_ID
#define LEDS_AXI_ID			XPAR_AXI_GPIO_1_DEVICE_ID
#define BUTTONS_AXI_ID		XPAR_AXI_GPIO_2_DEVICE_ID
#define BUT_INTC_DEVICE_ID	XPAR_PS7_SCUGIC_0_DEVICE_ID

#define SWITCHES_CHANNEL	1
#define LEDS_CHANNEL		1
#define BUTTONS_CHANNEL		1
#define INT_PushButtons		XPAR_FABRIC_AXI_GPIO_2_IP2INTC_IRPT_INTR

#define UP		16
#define DOWN	2
#define	LEFT	4
#define	RIGHT	8
#define CENTER	1

#define MAX_DELAY_USEC	500000
#define MIN_DELAY_USEC	25000
#define STEP_DELAY_USEC 25000

#define	INTERRUPT_MASK 0xFF


XGpio sw_gpio_instance, leds_gpio_instance, buttons_gpio_instance;
XGpio *sw_gpio = &sw_gpio_instance;
XGpio *leds_gpio = &leds_gpio_instance;
XGpio *buttons_gpio = &buttons_gpio_instance;

static XScuGic intr_cntrl_Inst;	//instance of the interrupt controller
XScuGic *INTCInst = &intr_cntrl_Inst;

//*****************************************
// function declarations
void PushButtons_Intr_Handler(void *data);
//*****************************************


char running = TRUE;
char light_to_left = TRUE;
Xuint32 LED_delay_usec = 250000;

int main()
{
	int Status,looping;
	unsigned int switches_state;
	unsigned int buttons_state;
	unsigned int LEDs_state = 1;

    init_platform();

    xil_printf("\n\nRunning Exercise 5...\n");


    //************************************************
    //Initialize GPIO for slide switches 0-7
    Status = XGpio_Initialize(sw_gpio, SWITCHES_AXI_ID);
    if (Status != XST_SUCCESS){
    	xil_printf("error initializing switches gpio\n");
    }
    else{
    	xil_printf("success initializing switches gpio\n");
    }

    //Initialize GPIO for LEDs 0-7
    Status = XGpio_Initialize(leds_gpio, LEDS_AXI_ID);
	if (Status != XST_SUCCESS){
		xil_printf("error initializing leds gpio\n");
	}
	else{
		xil_printf("success initializing leds gpio\n");
	}

	//Initialize GPIO for pushbuttons 0-5
	Status = XGpio_Initialize(buttons_gpio, BUTTONS_AXI_ID);
	if (Status != XST_SUCCESS){
		xil_printf("error initializing buttons gpio\n");
	}
	else{
		xil_printf("success initializing buttons gpio\n");
	}
	//************************************************



	//************************************************
	//buttons and switches set as inputs, LEDs set as outputs
    XGpio_SetDataDirection(sw_gpio, 1, 0xFF); //0=output, 1=input
    XGpio_SetDataDirection(leds_gpio, 1, 0x00); //0=output, 1=input
	XGpio_SetDataDirection(buttons_gpio, 1, 0xFF); //0=output, 1=input
	//************************************************



	//************************************************
    //Enable interrupts for buttons
    XGpio_InterruptEnable(buttons_gpio,INTERRUPT_MASK);
    XGpio_InterruptGlobalEnable(buttons_gpio);

    XScuGic_Config *IntcConfig;
    IntcConfig = XScuGic_LookupConfig(BUT_INTC_DEVICE_ID);

    //Initialize fields of the XScuGic structure
    Status = XScuGic_CfgInitialize(INTCInst, IntcConfig, IntcConfig->CpuBaseAddress);
    if(Status != XST_SUCCESS){
    	xil_printf("error initializing interrupt controller config\n");
    	return XST_FAILURE;
    }
    else{
    	xil_printf("success initializing interrupt controller config\n");
    }

    //Sets the interrupt priority and trigger type for the specificd IRQ source.
    XScuGic_SetPriorityTriggerType(INTCInst, INT_PushButtons, 0xA8, 3);	//0=Max priority, 3=rising edge.

    // Makes the connection between the Int_Id of the interrupt source and the
	// associated handler that is to run when the interrupt is recognized. The
	// argument provided in this call as the Callbackref is used as the argument
	// for the handler when it is called.
	Status = XScuGic_Connect(INTCInst,INT_PushButtons,
							(Xil_ExceptionHandler)PushButtons_Intr_Handler, (void *)&intr_cntrl_Inst);
	if(Status != XST_SUCCESS){
			xil_printf("error connecting interrupt controller IRQ handler\n");
			return XST_FAILURE;
		}
		else{
			xil_printf("success connecting interrupt controller IRQ handler\n");
		}

	// Enables the interrupt source provided as the argument Int_Id. Any pending
	// interrupt condition for the specified Int_Id will occur after this function is
	// called.
	XScuGic_Enable(INTCInst, INT_PushButtons);

    //Initialize the interrupt controller driver so that it is ready to use./
	Xil_ExceptionInit();

	// Enable interrupt
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
								 (Xil_ExceptionHandler)XScuGic_InterruptHandler,
								 INTCInst);
	Xil_ExceptionEnable();



	xil_printf("done setting up interrupts...\n");
	//************************************************************



	//************************************************************
	//Initial tests to verify board functionality
    switches_state = XGpio_DiscreteRead(sw_gpio, SWITCHES_CHANNEL);
    xil_printf("switch settings: 0x%04X\n",switches_state);

    buttons_state = XGpio_DiscreteRead(buttons_gpio, BUTTONS_CHANNEL);
    xil_printf("button settings: 0x%04X\n",buttons_state);

    xil_printf("setting LED values to: 0x%04X\n",switches_state);
    XGpio_DiscreteWrite(leds_gpio, SWITCHES_CHANNEL, switches_state);
    xil_printf("LED values written...\n");
    //************************************************************



    // Ensure that the programmable logic has all interrupts cleared before use
    XGpio_InterruptClear(buttons_gpio,INTERRUPT_MASK);
    //************************************************************
    looping = 1;
    while(looping){

    	if (running){
    		XGpio_DiscreteWrite(leds_gpio, LEDS_CHANNEL, LEDs_state);

    		if (light_to_left){
    			if (LEDs_state < 0x80){
    				LEDs_state = LEDs_state << 1;
    			}
    			else{
    				LEDs_state = 1;
    			}
    		}
    		else{
    			if (LEDs_state > 0x01){
    				LEDs_state = LEDs_state >> 1;
    			}
    			else{
    				LEDs_state = 0x80;
    			}
    		}

    		usleep(LED_delay_usec);

    	}

    }
    //************************************************************




    xil_printf("done.\n");

   	cleanup_platform();
    return 0;
}


void PushButtons_Intr_Handler(void *data)
{
	u32 buttons;
	xil_printf("entered interrupt handler function\n");

	// 20msec delay for pushbutton debounce
	usleep(20000);

	buttons = XGpio_DiscreteRead(buttons_gpio, 1);

	switch(buttons)
	{
		case CENTER:

			//toggle variable indicating running condition
			if (running){
				running = FALSE;
				xil_printf("Running Stopped\n");
			}
			else{
				running = TRUE;
				xil_printf("Running Started\n");
			}

			break;
		case DOWN:
			LED_delay_usec += STEP_DELAY_USEC ; //increase delay time
			if (LED_delay_usec > MAX_DELAY_USEC){
				LED_delay_usec = MAX_DELAY_USEC;
			}
			xil_printf("Delay increased to %d\n",LED_delay_usec);
			break;
		case UP:
			LED_delay_usec -= STEP_DELAY_USEC; //decrease delay time
			if (LED_delay_usec < MIN_DELAY_USEC){
				LED_delay_usec = MIN_DELAY_USEC;
			}
			xil_printf("Delay decreased to %d\n",LED_delay_usec);
			break;
		case LEFT:
			if (light_to_left == FALSE){ //only make change if LEDs running to the right
				light_to_left = TRUE;
				xil_printf("run LEDs to the left\n");
			}
			break;
		case RIGHT:
			if (light_to_left == TRUE){ //only make change if LEDs running to the left
				light_to_left = FALSE;
				xil_printf("run LEDs to the right\n");
			}
			break;
	}

	// Clear pending interrupts with the provided mask. This function should be
	// called after the software has serviced the interrupts that are pending.
	// This function will assert if the hardware device has not been built with
	// interrupt capabilities.
	XGpio_InterruptClear(buttons_gpio,INTERRUPT_MASK);
}
