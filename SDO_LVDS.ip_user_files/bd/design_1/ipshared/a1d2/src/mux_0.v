// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"
// CREATED		"Thu Feb 15 19:24:30 2024"


module mux_0(data,sel,result);
    input [7:0] data;
    input [2:0] sel;
    output reg result;
    
    always @ (data or sel)
    begin
        case (sel)
            3'b000: result = data[0];
            3'b001: result = data[1];
            3'b010: result = data[2];
            3'b011: result = data[3];
            3'b100: result = data[4];
            3'b101: result = data[5];
            3'b110: result = data[6];
            3'b111: result = data[7];
        endcase
     end
endmodule
