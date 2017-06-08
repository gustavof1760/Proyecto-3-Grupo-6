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
module Numeros_Fecha(
    input maquina_listo,
    input [9:0] pixel_y, pixel_x,
    input wire video_on,Prog_on,
    input [3:0] Cursor,
    input clk,reset,
    output [11:0] rgbtext,
    input [7:0] digit_DD,digit_M,digit_AN
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
wire digit_DD1,digit_DD2,digit_M1,digit_M2,digit_AN1,digit_AN2;
wire [3:0] selec_carac_deco; //Para ubicacion del caracter en la rom
wire [7:0] ROM_Data;
wire [1:0] AD_deco; //posicion en la rom
reg [3:0] BCD_deco; //numero a decodificar
wire [3:0] BCD_deco_salida;
parameter Prog=0,ProgNo=1;
reg state;
reg [11:0] rgbtext1;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Ubicacion de los caracteres en pantalla
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

      assign digit_DD1 =(272<=pixel_x) && (pixel_x<=287) && (127<=pixel_y) && (pixel_y<=158);
      assign digit_DD2 =(288<=pixel_x) && (pixel_x<=303) &&(127<=pixel_y) && (pixel_y<=158);

      assign digit_M1 =(320<=pixel_x) && (pixel_x<=335) &&(127<=pixel_y) && (pixel_y<=158);
      assign digit_M2 =(336<=pixel_x) && (pixel_x<=351) && (127<=pixel_y) && (pixel_y<=158);

      assign digit_AN1 =(368<=pixel_x) && (pixel_x<=383) &&(127<=pixel_y) && (pixel_y<=158);
      assign digit_AN2 =(384<=pixel_x) && (pixel_x<=399) && (127<=pixel_y) && (pixel_y<=158);

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

parameter  R1=1,R2=2,R3=3,R4=4,R5=5,R6=6;

reg [2:0] estado;


always @(posedge clk) begin
		if(reset) begin
    			BCD_deco<=0;
    			lsby_reg<=0;
    			lsbx_reg<=0;
    			Reg_enable<=0;
          end

		else  if(maquina_listo) begin
				case(estado)
						R1: begin
								  if (digit_DD1)
								    begin
								      BCD_deco<=digit_DD[7:4];
									  Reg_enable<=1;
								      lsby_reg<= pixel_y[4:1];
                                      lsbx_reg<= pixel_x[3:1];
									  estado<=R1;
									end

								   else if(~digit_DD1)
										  estado<=R2;
							 end


						R2:begin
  							  if (digit_DD2)
                                   begin
                                      BCD_deco<=digit_DD[3:0];
                                      Reg_enable<=1;
                                      lsby_reg<= pixel_y[4:1];
                                      lsbx_reg<= pixel_x[3:1];
                                      estado<=R2;
                                   end
  							   
  							  else if(~digit_DD2)
  										estado<=R3;
                           end
                           
                           
						R3:begin
							  if (digit_M1)
							       begin
    								  BCD_deco<=digit_M[7:4];
                                      Reg_enable<=1;
    								  lsby_reg<= pixel_y[4:1];
                                      lsbx_reg<= pixel_x[3:1];
    								  estado<=R3;
								   end
								   
							    else if(~digit_M1)
									      estado<=R4;
                           end
                           
                           
						R4:begin
							  if (digit_M2)
							       begin
      								  BCD_deco<=digit_M[3:0];
                                      Reg_enable<=1;
      								  lsby_reg<= pixel_y[4:1];
                                      lsbx_reg<= pixel_x[3:1];
      								  estado<=R4;
								   end
								   
							  else if(~digit_M2)
									      estado<=R5;
                              end
                              
                              
						R5:begin
							  if (digit_AN1)
							       begin
      								  BCD_deco<=digit_AN[7:4];
                                      Reg_enable<=1;
      								  lsby_reg<= pixel_y[4:1];
                                      lsbx_reg<= pixel_x[3:1];
      								  estado<=R5;
      			 				   end
      			 				   
			 			      else if(~digit_AN1)
          			 					estado<=R6;
          			 		end
          			 		
          			 		
						R6: begin
							   if (digit_AN2)
							        begin
    								   BCD_deco<=digit_AN[3:0];
                                       Reg_enable<=1;
    								   lsby_reg<= pixel_y[4:1];
                                       lsbx_reg<= pixel_x[3:1];
    								   estado<=R6;
									end
									
      						  else if(~digit_AN2)
      								 estado<=R1;
                            end
                            
                            
						default:  estado<=R1;
				endcase
			end

        else 
            begin
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
                        			letter_rgb <= 12'h000; end
                else if(Prog_on)
                          state<=Prog;
                  end
          Prog: begin
                if(Prog_on)begin
                        state<=Prog;
                        if (pixelbit && (digit_DD1|digit_DD2))begin
                                  if(Cursor==3)
                                      letter_rgb <=12'hf00;
                                  else letter_rgb <=12'hfff;
                                  end

                        else if (pixelbit && (digit_M1|digit_M2))begin
                                  if(Cursor==4)
                                      letter_rgb <=12'hf00;
                                  else letter_rgb <=12'hfff;
                                  end
                        else if (pixelbit && (digit_AN1|digit_AN2))begin
                                  if(Cursor==5)
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
//// Salida RGB de los caracteres de la fecha
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

 always@(posedge clk) begin
    if(reset)
        rgbtext1<=0;
    else begin
     		if(~video_on)
        			rgbtext1<=0;
      	else begin
            	if ( digit_DD1  | digit_DD2 | digit_M1 | digit_M2 | digit_AN1 | digit_AN2)
            			rgbtext1 <= letter_rgb;
            	else
            			rgbtext1<=12'h000;
        end
  end
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Salida RGB
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

	assign rgbtext=rgbtext1;

  endmodule
