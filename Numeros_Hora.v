`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15:57:14 05/22/2017 
// Design Name: 
// Module Name: Numeros_Fecha
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
module Numeros_Hora(
		input maquina_listo,
		input [9:0] pixel_y, pixel_x,
		input wire video_on,Prog_on,
        input [3:0] Cursor,
		input clk,reset,
		output wire [11:0] rgbtext,
		input [7:0] digit_HORA,digit_MIN,digit_SEG
		);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  

wire digit_Hora1,digit_Hora2,digit_Min1,digit_Min2,digit_Seg1,digit_Seg2;
reg pixelbit;
wire enable; //enable para el decodificador
reg Reg_enable;
//bits que se encargan de generar los mosaicos
wire [2:0] lsbx;
wire [3:0] lsby;
reg [2:0] lsbx_reg;
reg [3:0] lsby_reg;
reg [11:0] letter_rgb;
//indicadores que se cayo en la coordenada de impresion
wire hour_1,hour_2,hour_3,hour_4,hour_5,hour_6;
//byte de salida de la rom
wire [7:0] ROM_Data;
//para el decodificador
wire [1:0] AD_deco; //posicion en la rom
reg [3:0] BCD_deco; //numero a decodificar
wire [3:0] BCD_deco_salida;
wire [3:0] selec_carac_deco; //fila donde esta en el rom
parameter  R1=1,R2=2,R3=3,R4=4,R5=5,R6=6;
reg [2:0] estado;
parameter Prog=0,ProgNo=1;
reg state;



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Ubicacion de los caracteres en pantalla
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

	assign digit_Hora1 =(64<=pixel_x) && (pixel_x<=79) &&(127<=pixel_y) && (pixel_y<=158);
	assign digit_Hora2 =(80<=pixel_x) && (pixel_x<=95) && (127<=pixel_y) && (pixel_y<=158);
 
	assign digit_Min1 =(112<=pixel_x) && (pixel_x<=127) &&(127<=pixel_y) && (pixel_y<=158);
	assign digit_Min2 =(128<=pixel_x) && (pixel_x<=143) && (127<=pixel_y) && (pixel_y<=158);
  
	assign digit_Seg1 =(160<=pixel_x) && (pixel_x<=175) &&(127<=pixel_y) && (pixel_y<=158);
	assign digit_Seg2 =(176<=pixel_x) && (pixel_x<=191) &&(127<=pixel_y) && (pixel_y<=158);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Conexion de los modulos para decodificador y ROM
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
assign enable=Reg_enable;
assign lsbx= lsbx_reg;
assign lsby=lsby_reg;
assign BCD_deco_salida=BCD_deco_salida;


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
												if (digit_Hora1)begin
												      BCD_deco<=digit_HORA[7:4];
															Reg_enable<=1;
												      lsby_reg<= pixel_y[4:1];
															lsbx_reg<= pixel_x[3:1];
															estado<=R1;
															end
												else if(~digit_Hora1)
														estado<=R2;
												end

						R2:begin
									   	if (digit_Hora2)begin
											      BCD_deco<=digit_HORA[3:0];
														Reg_enable<=1;
											      lsby_reg<= pixel_y[4:1];
														lsbx_reg<= pixel_x[3:1];
														estado<=R2;
														end
											else if(~digit_Hora2)
													estado<=R3;
													end
						R3:begin
											if (digit_Min1)begin
											    BCD_deco<=digit_MIN[7:4];
													Reg_enable<=1;
											    lsby_reg<= pixel_y[4:1];
													lsbx_reg<= pixel_x[3:1];
													estado<=R3;
													end
										else if(~digit_Min1)
												estado<=R4;end
						R4:begin
											if (digit_Min2)begin
											    BCD_deco<=digit_MIN[3:0];
													Reg_enable<=1;
											    lsby_reg<= pixel_y[4:1];
													lsbx_reg<= pixel_x[3:1];
													estado<=R4;
													end
										else if(~digit_Min2)
												estado<=R5;end
						R5:begin
										 if (digit_Seg1)begin
											   BCD_deco<=digit_SEG[7:4];
												 Reg_enable<=1;
											   lsby_reg<= pixel_y[4:1];
												 lsbx_reg<= pixel_x[3:1];
												 estado<=R5;
						 						end
						 			else if(~digit_Seg1)
						 					estado<=R6;end
						R6: begin
										 if (digit_Seg2)begin
										    BCD_deco<=digit_SEG[3:0];
												Reg_enable<=1;
										    lsby_reg<= pixel_y[4:1];
												lsbx_reg<= pixel_x[3:1];
												estado<=R6;
											 end
								 else if(~digit_Seg2)
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



always @(posedge clk)
    if (reset) begin
		            letter_rgb<=12'h000;
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
		                          			letter_rgb <= 0;
																	end
		                  else if(Prog_on)
		                          state<=Prog;
		                  end
              Prog: begin
		                  if(Prog_on)begin
		                            state<=Prog;
		                            if (pixelbit && (digit_Hora1|digit_Hora2))begin
		                                  if(Cursor==0)
		                                      letter_rgb <=12'hf00;
		                                  else letter_rgb <=12'hfff;
																      end

		                            else if (pixelbit && (digit_Min1|digit_Min2))begin
		                                  if(Cursor==1)
		                                      letter_rgb <=12'hf00;
		                                  else letter_rgb <=12'hfff;
															      	end

		                            else if (pixelbit && (digit_Seg1|digit_Seg2))begin
		                                  if(Cursor==2)
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
//// Salida RGB de los caracteres de la hora
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

reg [11:0] rgbtext1;
always@(posedge clk)  begin
		 if(reset)
					 rgbtext1<=0;
		 else begin
				  if(~video_on)
				        rgbtext1<=12'hfff;
				  else begin
				      if ( digit_Hora1 | digit_Hora2 | digit_Min1 | digit_Min2 | digit_Seg1 | digit_Seg2)
				              rgbtext1 <= letter_rgb;
				      else
				          rgbtext1<=0;
				    end
		end
end

assign rgbtext=rgbtext1;

endmodule
