`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:51:58 05/24/2017
// Design Name:
// Module Name:    FlipFlops
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module FlipFlops(
		input clk,
		input reset,
		input BTNd,
		output BTN
		);

FFD DF1(BTNd,clk,reset,BTN1);
not(BTN1n,BTN1);
FFD DF2(BTN1n,clk,reset,BTN2);
and(BTN,BTN1,BTN2,~reset);


endmodule

module FFD (
    data, // Dato Entrada
    clk, 
    reset, // Reset input
    q // Salida FlipFlop
    );

input data, clk, reset ; //Entradas
output q; //Salida
reg q; //Variable interna

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// FlipFlop
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

always @ ( posedge clk)
        if (reset) begin
            q <= 1'b0;
        end  
        
        else begin
            q <= data;
        end

endmodule
