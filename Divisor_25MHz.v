`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2017 04:48:44
// Design Name: 
// Module Name: Divisor_25MHz
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Divisor_25MHz(
   input wire clk_in,reset,     // reloj entrante de 100MHz
   output reg clk2      // nuevo reloj de 25MHz 
   );

   reg [3:0] count;

   // divisor de reloj 50MHz a 5MHz
   always@(posedge clk_in)
       begin
           if(count==4'd1)      // cuenta 2 ciclos (0-1) de reloj    
               begin
                   count<=0;      // reinicia cuenta a 0
                   clk2 <= ~clk2; // transiciona clk2 a alto o bajo
               end
           else
               begin
                   count<=count+1;  //  aumenta contador
               end
       end     


endmodule
