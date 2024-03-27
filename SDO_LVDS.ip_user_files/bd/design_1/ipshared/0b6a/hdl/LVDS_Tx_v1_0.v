
`timescale 1 ns / 1 ps

	module LVDS_Tx_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 4
	)
	(
		// Users to add ports here
        input wire CLK_IN,
        output reg CLK_OUT,
        output reg DATA_OUT,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
	
  wire [31:0] DATA_WORD_0;
  wire [31:0] DATA_WORD_1; 
  wire [31:0] DATA_WORD_2;
  wire [31:0] DATA_WORD_3;
  
  
// Instantiation of Axi Bus Interface S00_AXI
	LVDS_Tx_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) LVDS_Tx_v1_0_S00_AXI_inst (
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready),
		
        .DATA_WORD_0     (DATA_WORD_0), 
        .DATA_WORD_1     (DATA_WORD_1),
        .DATA_WORD_2     (DATA_WORD_2),
        .DATA_WORD_3     (DATA_WORD_3)
	);

	// Add user logic here
	//
	// Implement state machine
	reg [1:0] cur_state;
    localparam IDLE = 2'b00;
    localparam WRITE = 2'b01;
    localparam DONE = 2'b10;

	// 40 bits of data needs to be split across 2 32-bit regs
    wire [39:0] data_full; // contains the full data message to be sent out
	assign data_full[39:8] = DATA_WORD_0[31:0];
	assign data_full[7:0] = DATA_WORD_1[7:0];	
	
	// Use LSB of DATA_WORD_2 / slv_reg2 as WRITE_START bit so ARM code can toggle it
	wire WRITE_START;
	assign WRITE_START = DATA_WORD_2[0];
	
	// Use LSB of DATA_WORD_3 / slv_reg3 as WRITE_DONE bit so ARM code can read it
	reg WRITE_DONE;
	assign DATA_WORD_3[0] = WRITE_DONE;	
	
	reg [5:0] counter = 6'b100111; // for counting clock cycles
	
	// Output clock only when writing
	always @ (CLK_IN) begin
	   if (cur_state == WRITE) begin
	       CLK_OUT <= CLK_IN;
	   end
	   else begin
	       CLK_OUT <= 0;
	   end
	end
	
	// Perform actions based on current state
	always @ (negedge CLK_IN or negedge s00_axi_aresetn) begin
        if ((cur_state == IDLE) || !s00_axi_aresetn) begin
            WRITE_DONE <= 1'b0;
            DATA_OUT <= 0;
            counter <= 6'b100111;
            if (WRITE_START) // When ARM code asserts WRITE_START, move to WRITE state
                cur_state <= WRITE;
        end
        else if (cur_state == WRITE) begin
            DATA_OUT <= data_full[counter];
            if (counter == 6'b000000) // If 40 bits have been sent, set move to DONE state
                cur_state <= DONE;
            else
                counter <= counter - 1'b1;
        end        
        else if (cur_state == DONE) begin // Done writing, wait for ARM code to reset WRITE_START
            DATA_OUT <= 0;
            WRITE_DONE <= 1'b1; 
            if (!WRITE_START) // When ARM code resets WRITE_START, move to IDLE state
                cur_state <= IDLE;
        end
    end
        
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    /* 
        The code in this segment is how I would have liked to implement the state machine, 
        but for some reason it gets stuck in the WRITE state (possibly timing issue?),
        so instead I rewrote it into the block directly above this. Might go back and fix in the future. 
        If you're reading this comment and have spare time, feel free to try and fix it yourself.
            -Tin H. 3/19/24
    */
	// Perform actions based on current state
	/*
	always @ (negedge CLK_IN or negedge s00_axi_aresetn) begin
        if ((cur_state == IDLE) || !s00_axi_aresetn) begin
            WRITE_DONE <= 1'b0;
            DATA_OUT <= 0;
            counter <= 6'b100111;
        end
        else if (cur_state == WRITE) begin
            DATA_OUT <= data_full[counter];
            if (counter == 6'b000000) // If 40 bits have been sent, set move to DONE state
                WRITE_DONE <= 1'b1;
            else
                counter <= counter - 1'b1;
        end        
        else if (cur_state == DONE) begin // Done writing, wait for ARM code to reset WRITE_START
            DATA_OUT <= 0;
            //WRITE_DONE <= 1'b1; // ***This version of the code only works if this line is added, but I can't figure out why***
        end
    end   
    
    // Change current state based on WRITE_START and WRITE_DONE
    always @ (CLK_IN) begin
        if (!WRITE_START)
            cur_state = IDLE;
        else if (WRITE_START && !WRITE_DONE) // If write has started but is not complete
            cur_state = WRITE;
        else if (WRITE_START && WRITE_DONE) // Write has completed, wait for ARM to reset WRITE_START
            cur_state = DONE;
    end     
    */     
    ////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// User logic ends

	endmodule
