`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:51:58 05/20/2017
// Design Name:
// Module Name:    Tecla_Salida
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
module Tecla_Salida(
  input clk,reset,rx_done_tick,
  input [7:0] CodigoTecla_salida,
  output reg Codigo_c,Codigo_t,Codigo_p,Codigo_enter,Codigo_arriba,Codigo_abajo,Codigo_izq,Codigo_der
  );

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Registros a utilizar
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

reg [7:0] Hex_codigo;
reg [7:0] Tecla_off;
reg [7:0] Tecla_sig;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


always @(posedge clk) begin
    if(reset) begin
    		 Hex_codigo <= 8'h00;
        end
    else begin
		   if((rx_done_tick) && (Tecla_off != 8'hf0))
         begin
            Hex_codigo <= CodigoTecla_salida;
           end
        else if((rx_done_tick) && (CodigoTecla_salida == 8'hf0))
        		Hex_codigo <= 0;
        else begin
            Hex_codigo<=Hex_codigo;
            end
    end
end


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Deteccion Tecla Suelta
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

reg [1:0] contador;

// contador para habilitaciones

always@(posedge clk) begin
	if(reset) begin
				contador<=0;
			  end
	 else if((rx_done_tick) && (CodigoTecla_salida != 8'hf0) )begin
					contador<=contador+1;
					end
	 else if((rx_done_tick) && (CodigoTecla_salida == 8'hf0))begin
					contador<=0;
					end
	 else
			contador<=contador;
end


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Deteccion de codigo F0 indicando que la tecla se solto
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

always @(posedge clk) begin
    if(reset) begin
    		Tecla_off <= 8'h00;
        end
    else begin
        if((rx_done_tick) && (CodigoTecla_salida==8'hf0))begin
           Tecla_off <= CodigoTecla_salida[7:0];
           end
        else if(contador==1)begin
              Tecla_off <= 8'h00;
            end
        else begin
        		Tecla_off <= Tecla_off;
           end
    end
end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Decodificacion de tecla
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

always @(posedge clk) begin
    if(reset) begin
          Codigo_c<=0;Codigo_abajo<=1'b0;
          Codigo_t<=0;Codigo_arriba<=1'b0;
          Codigo_p<=0;Codigo_izq<=1'b0;
          Codigo_enter<=0;Codigo_der<=1'b0;
        end
    else begin
        case(Hex_codigo)
        8'h21: begin   //letra C
                    Codigo_c<=1'b1;
                      end
        8'h2c: begin   //letra T
                    Codigo_t<=1'b1;
                      end
        8'h4d: begin   //letra P
                    Codigo_p<=1'b1;
                      end
        8'h5a: begin   //letra Enter
                    Codigo_enter<=1'b1;
                             end
        8'h75: begin
               Codigo_arriba<=1'b1;
               end
        8'h72: begin
                Codigo_abajo<=1'b1;
                end
        8'h6B: begin
                 Codigo_izq<=1'b1;
                 end
        8'h74: begin
                 Codigo_der<=1'b1;
                 end
        default: begin
                  Codigo_c<=0;Codigo_abajo<=1'b0;
                  Codigo_t<=0;Codigo_arriba<=1'b0;
                  Codigo_p<=0;Codigo_izq<=1'b0;
                  Codigo_enter<=0;Codigo_der<=1'b0;
                end
        endcase
		  end
end

endmodule
