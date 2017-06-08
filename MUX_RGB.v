`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    22:02:32 05/22/2017
// Design Name:
// Module Name:    MUX_RGB
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
module MUX_RGB(
    input clk,
    input wire video_on,reset,
    input wire [9:0] pix_x,pix_y,
    input wire [11:0] rgb_numero_hora,rgb_numero_fecha,rgb_numero_timer,
    input wire [11:0] Ring_RGB,Gen_RGB,
    output wire [11:0] rgb_screen,
    output reg hora_ok,fecha_ok,temp_ok
    );

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      
wire digit_HORA,digit_MIN,digit_SEG;
wire digit_DD,digit_M,digit_AN;
wire digit_TimerHORA,digit_TimerMIN,digit_TimerSEG;
wire RING;
       

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Para los caracteres de los numeros

    assign digit_HORA=(64<=pix_x) && (pix_x<=95) &&(127<=pix_y) && (pix_y<=158);
    assign digit_MIN=(112<=pix_x) && (pix_x<=143) &&(127<=pix_y) && (pix_y<=158);
    assign digit_SEG=(160<=pix_x) && (pix_x<=191) &&(127<=pix_y) && (pix_y<=158);


    assign digit_DD=(272<=pix_x) && (pix_x<=303) &&(127<=pix_y) && (pix_y<=158);
    assign digit_M=(320<=pix_x) && (pix_x<=351) &&(127<=pix_y) && (pix_y<=158);
    assign digit_AN=(368<=pix_x) && (pix_x<=399) &&(127<=pix_y) && (pix_y<=158);

    assign digit_TimerHORA=(304<=pix_x) && (pix_x<=335) &&(383<=pix_y) && (pix_y<=414);
    assign digit_TimerMIN=(352<=pix_x) && (pix_x<=383) &&(383<=pix_y) && (pix_y<=414);
    assign digit_TimerSEG=(400<=pix_x) && (pix_x<=431) &&(383<=pix_y) && (pix_y<=414);


//Para la imagen del Ring

    assign RING=(491<=pix_x) && (pix_x<=604) &&(258<=pix_y) && (pix_y<=456);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
reg [11:0] rgb_screenreg;

always@(posedge clk)
    if(reset) begin
          rgb_screenreg<=0;
          fecha_ok<=0;
          hora_ok<=0;
          temp_ok<=0;
    end
    else begin
        case(video_on)
        0:  begin
            			rgb_screenreg<=0;
            end
        1:  begin
              if  (digit_HORA | digit_MIN | digit_SEG ) begin   //Numeros Hora
                    	rgb_screenreg <= rgb_numero_hora;
                      hora_ok<=1;end

              else if ( digit_DD | digit_M | digit_AN )begin  //Numeros Fecha
                      rgb_screenreg <= rgb_numero_fecha;
                      fecha_ok<=1;end

              else if ( digit_TimerHORA | digit_TimerMIN | digit_TimerSEG) begin  //Numeros Temporizador
                      rgb_screenreg <= rgb_numero_timer;
                      temp_ok<=1;end

              else if( RING )  //  Ring
                      rgb_screenreg <= Ring_RGB;

              else    //Cuadros e imagenes
                      rgb_screenreg <= Gen_RGB;
              end

          default: rgb_screenreg<=12'h000;
          endcase
    end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// SALIDA RGB
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 assign rgb_screen=rgb_screenreg;


endmodule
