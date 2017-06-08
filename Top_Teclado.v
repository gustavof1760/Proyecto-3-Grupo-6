`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:51:58 05/20/2017
// Design Name:
// Module Name:    Top_Teclado
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
module Top_Teclado(
  input clk,reset,
  input ps2d,ps2c, rx_en,
  output c,t,p,enter,arriba,abajo,izquierda,derecha
  );

    wire [7:0] salida;
    wire rx_done_tick;


         ps2_receptor  PS2(
             .clk(clk),.reset(reset),
             .ps2d(ps2d),.ps2c(ps2c), .rx_en(rx_en),
             .rx_done_tick(rx_done_tick),
             .salida(salida)
             );

          Tecla_Salida  Tecla(
              .clk(clk),
              .reset(reset),
              .rx_done_tick(rx_done_tick),
              .CodigoTecla_salida(salida),
              .Codigo_c(c),
              .Codigo_t(t),
              .Codigo_p(p),
              .Codigo_enter(enter),
              .Codigo_arriba(arriba),
              .Codigo_abajo(abajo),
              .Codigo_izq(izquierda),
              .Codigo_der(derecha)
              );

endmodule
