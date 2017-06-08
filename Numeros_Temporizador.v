`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Create Date:    22:01:43 05/22/2017
// Design Name:
// Module Name:    TIMERNUMBERS

// Description:  IMPRIME LOS NUMEROS DEL TIMER

// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module Numeros_Temporizador(

      input maquina_listo,
      input [9:0] pixel_y, pixel_x,
      input wire video_on,Prog_on,
      input [3:0] Cursor,
      input clk,reset,
      output [11:0] rgbtext,
      input [7:0] digit_TimerHORA,digit_TimerMIN,digit_TimerSEG

      );

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  

wire enable; //Habilitador para el decodificador
reg Reg_enable;
reg pixelbit;
wire [2:0] lsbx;
wire [3:0] lsby;
reg [2:0] lsbx_reg;
reg [3:0] lsby_reg;
reg [11:0] letter_rgb;
wire [7:0] ROM_Data;
wire [1:0] AD_deco;//posicion en la rom
reg  [3:0] BCD_deco;
wire [3:0] selec_carac_deco;
wire digit_TempH1,digit_TempH2,digit_TempM1,digit_TempM2,digit_TempS1,digit_TempS2;
parameter  R1=1,R2=2,R3=3,R4=4,R5=5,R6=6;
reg [2:0] estado;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Ubicacion de los caracteres en pantalla
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	


        assign digit_TempH1 =(304<=pixel_x) && (pixel_x<=319) && (383<=pixel_y) && (pixel_y<=414);
        assign digit_TempH2 =(320<=pixel_x) && (pixel_x<=335) &&(383<=pixel_y) && (pixel_y<=414);

        assign digit_TempM1 =(352<=pixel_x) && (pixel_x<=367) &&(383<=pixel_y) && (pixel_y<=414);
        assign digit_TempM2 =(368<=pixel_x) && (pixel_x<=383) && (383<=pixel_y) && (pixel_y<=414);

        assign digit_TempS1 =(400<=pixel_x) && (pixel_x<=415) &&(383<=pixel_y) && (pixel_y<=414);
        assign digit_TempS2 =(416<=pixel_x) && (pixel_x<=431) && (383<=pixel_y) && (pixel_y<=414);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Conexion de los modulos para decodificador y ROM
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

assign enable=Reg_enable;
assign lsbx= lsbx_reg;
assign lsby=lsby_reg;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Instanciacion de decodificador y ROM de caracteres
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
Decodificador Decodificador(
        .enable(enable),
        .bcd_num(BCD_deco),
        .address_out_reg(AD_deco),
        .sel_address_out_reg(selec_carac_deco)
        );


font_rom Mem_caracteres(
        reset,
        AD_deco,
        lsby,
        ROM_Data,
        selec_carac_deco
        );


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Maquina para salida hacia otros modulos
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    

always @(posedge clk) begin
		if(reset) begin
    			BCD_deco<=0;
    			lsby_reg<=0;
    			lsbx_reg<=0;
    			Reg_enable<=0;
          end

		else if(maquina_listo) begin
				case(estado)
						R1: begin
								if (digit_TempH1)begin
								      BCD_deco<=digit_TimerHORA[7:4];
											Reg_enable<=1;
								      lsby_reg<= pixel_y[4:1];
                      lsbx_reg<= pixel_x[3:1];
											estado<=R1;
											end
								else if(~digit_TempH1)
										estado<=R2;end
						R2:begin
                  if (digit_TempH2) begin
								      BCD_deco<=digit_TimerHORA[3:0];
                      Reg_enable<=1;
								      lsby_reg<= pixel_y[4:1];
                      lsbx_reg<= pixel_x[3:1];
											estado<=R2;
											end
								else if(~digit_TempH2)
										estado<=R3;end
						R3:begin
								 if (digit_TempM1)begin
								    BCD_deco<=digit_TimerMIN[7:4];
                    Reg_enable<=1;
								    lsby_reg<= pixel_y[4:1];
                    lsbx_reg<= pixel_x[3:1];
										estado<=R3;
										end
							else if(~digit_TempM1)
									estado<=R4;end
						R4:begin
    								if (digit_TempM2)begin
    								    BCD_deco<=digit_TimerMIN[3:0];
                        Reg_enable<=1;
    								    lsby_reg<= pixel_y[4:1];
                        lsbx_reg<= pixel_x[3:1];
    										estado<=R4;
    										end
    							   else if(~digit_TempM2)
    									  estado<=R5;end
						R5:begin
    							 if (digit_TempS1)begin
    								   BCD_deco<=digit_TimerSEG[7:4];
                       Reg_enable<=1;
    								   lsby_reg<= pixel_y[4:1];
                       lsbx_reg<= pixel_x[3:1];
    									 estado<=R5;
    			 						 end
    			 			else if(~digit_TempS1)
    			 					estado<=R6;end
						R6: begin
								   if (digit_TempS2)begin
    								    BCD_deco<=digit_TimerSEG[3:0];
                        Reg_enable<=1;
    								    lsby_reg<= pixel_y[4:1];
                        lsbx_reg<= pixel_x[3:1];
    										estado<=R6;
									      end
						       else if(~digit_TempS2)
								        estado<=R1;
                 end

						default:  estado<=R1;
					endcase
        end

	 else begin
  			BCD_deco<=0;
  			lsby_reg<=0;
  			lsbx_reg<=0;
  			Reg_enable<=0;
        end
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Para recorrer la direccion en la ROM
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	


always @(posedge clk)
    if(reset)
              pixelbit<=0;
    else begin
      case (lsbx)
              0: pixelbit <= ROM_Data[7];
              1: pixelbit <= ROM_Data[6];
              2: pixelbit <= ROM_Data[5];
              3: pixelbit <= ROM_Data[4];
              4: pixelbit <= ROM_Data[3];
              5: pixelbit <= ROM_Data[2];
              6: pixelbit <= ROM_Data[1];
              7: pixelbit <= ROM_Data[0];
              default:pixelbit<=0;
      endcase
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Para seleccionar el color de los caracteres
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

parameter Prog=0,ProgNo=1;
reg state;

always @(posedge clk)
    if (reset) begin
              letter_rgb<=12'hfff;
              state<=0;
          end
   else begin
        case(state)
            ProgNo: begin
                      if(~Prog_on)begin
                                state<=ProgNo;
                                if (pixelbit)
                                  letter_rgb <=12'hfff;
                                else
                                  letter_rgb <= 0; end
                      else if(Prog_on)
                            state<=Prog;
                      end
            Prog: begin
                    if(Prog_on)begin
                          state<=Prog;
                          if (pixelbit && (digit_TempH1|digit_TempH2))begin
                                    if(Cursor==6)
                                        letter_rgb <=12'hf00;
                                    else letter_rgb <=12'hfff;
                                    end
                          else if (pixelbit && (digit_TempM1|digit_TempM2))begin
                                    if(Cursor==7)
                                        letter_rgb <=12'hf00;
                                    else letter_rgb <=12'hfff;
                                    end
                          else if (pixelbit && (digit_TempS1|digit_TempS2))begin
                                    if(Cursor==8)
                                        letter_rgb <=12'hf00;
                                    else letter_rgb <=12'hfff;
                                    end
                          else
                                letter_rgb <= 0;
                          end
                      else if(~Prog_on)
                              state<=ProgNo;
                  end
            endcase
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Salida RGB de los caracteres de la temporizador
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

reg [11:0] rgbtext1;

always@(posedge clk) begin
  if(reset)
        rgbtext1<=0;
  else begin
      if(~video_on)
              rgbtext1<=12'hfff;
      else begin
          if ( digit_TempH1  | digit_TempH2  | digit_TempM1 | digit_TempM2 | digit_TempS1 | digit_TempS2)
              rgbtext1 <= letter_rgb;
          else
             rgbtext1<=0;
        end
    end
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Salida RGB
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

assign rgbtext=rgbtext1;


endmodule
