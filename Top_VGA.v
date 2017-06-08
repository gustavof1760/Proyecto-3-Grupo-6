`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15:57:14 05/22/2017 
// Design Name: 
// Module Name: Top_VGA
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
///////////////////////////////////////////////////////////////////////////////////
module Top_VGA(
	 input wire clk,reset,
     input alarma_on,
     output wire h_sync, v_sync,
     output wire [11:0] rgb,
     output [9:0] pixel_x,pixel_y,
     input [7:0] digit_HORA,digit_MIN,digit_SEG,
     input wire [7:0] digit_DD,digit_M,digit_AN,
     input wire [7:0] digit_TimerHORA,digit_TimerMIN,digit_TimerSEG,
	 input Prog_on,
	 input [3:0] Cursor
     );


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  wire [9:0] pixel_x,pixel_y;
  wire video_on , pixel_tick;
  wire [11:0] Ring_RGB,Num_RGB,Gen_RGB;
  wire [11:0] Ring_RGB_sig,Num_RGB_sig,Gen_RGB_sig;

  //Para numeros
  wire [11:0] rgb_numero_hora;
  wire [11:0] rgb_numero_fecha;
  wire [11:0] rgb_numero_timer;
  wire hora_ok,fecha_ok,temp_ok;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Instanciacion de los modulos del Top VGA
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Numeros_Hora Hora_VGA(
                 .maquina_listo(hora_ok),
                 .pixel_y(pixel_y),
                 .pixel_x(pixel_x),
                 .video_on(video_on),
                 .Prog_on(Prog_on),
                 .Cursor(Cursor),
                 .clk(clk),
                 .reset(reset),
                 .rgbtext(rgb_numero_hora),
                 .digit_HORA(digit_HORA),
                 .digit_MIN(digit_MIN),
                 .digit_SEG(digit_SEG)
                 );


Numeros_Fecha Fecha_VGA(
                .maquina_listo(fecha_ok),
                .pixel_y(pixel_y),
                .pixel_x(pixel_x),
                .video_on(video_on),
                .Prog_on(Prog_on),
                .Cursor(Cursor),
                .clk(clk),
                .reset(reset),
                .rgbtext(rgb_numero_fecha),
                .digit_DD(digit_DD),
                .digit_M(digit_M),
                .digit_AN(digit_AN)
                );



Numeros_Temporizador Temporizador_VGA(
                 .maquina_listo(temp_ok),
                 .pixel_y(pixel_y),
                 .pixel_x(pixel_x),
                 .video_on(video_on),
                 .Prog_on(Prog_on),
                 .Cursor(Cursor),
                 .clk(clk),
                 .reset(reset),
                 .rgbtext(rgb_numero_timer),
                 .digit_TimerHORA(digit_TimerHORA),
                 .digit_TimerMIN(digit_TimerMIN),
                 .digit_TimerSEG(digit_TimerSEG)
                 );


Divisor_F divisor(
           .clk(clk),
           .reset(reset),
           .SCLKclk(SCLKclk)
           );
           
           wire clk_in;
           assign clk_in = SCLKclk;


VGA_Sync Sincronizador(
                .clk_in(clk_in),
                .reset(reset),
                .h_sync(h_sync),
                .v_sync(v_sync),
                .video_on(video_on),
                .p_tick(pixel_tick),
                .pixel_x(pixel_x),
                .pixel_y(pixel_y)
                );


Ring Fin_Alarma(
         .alarma_on(alarma_on),
         .pixel_y(pixel_y),
         .pixel_x(pixel_x),
         .clk(clk),
         .reset(reset),
         .rgbtext(Ring_RGB)
         );

Generador_Cajas_Imagenes Generador_Cajas_Imagenes(
                       .pix_y(pixel_y),.pix_x(pixel_x),
                       .video_on(video_on),
                       .reset(reset),
                       .rgbtext(Gen_RGB)
                       );


MUX_RGB Mux_RGB(
            .clk(clk),
            .video_on(video_on),
            .reset(reset),
            .pix_x(pixel_x),
            .pix_y(pixel_y),
            .rgb_numero_hora(rgb_numero_hora),
            .rgb_numero_fecha(rgb_numero_fecha),
            .rgb_numero_timer(rgb_numero_timer),
            .Ring_RGB(Ring_RGB),
            .Gen_RGB(Gen_RGB),
            .rgb_screen(rgb),
            .hora_ok(hora_ok),
            .fecha_ok(fecha_ok),
            .temp_ok(temp_ok)
            );


endmodule
