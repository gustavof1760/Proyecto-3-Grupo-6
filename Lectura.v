`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:57:14 05/10/2017 
// Design Name: 
// Module Name:    Lectura 
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



module Lectura(clk, reset, entrada, MUX_AD, Fin_Lectura, state, a_d, cs, rd, wr, ts, enable_Reg);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////ENTRADAS y SALIDAS
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	input clk, entrada, reset ; 
	output a_d, cs, rd, wr, ts, MUX_AD, Fin_Lectura, enable_Reg;
	output[2:0] state; 
	
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Registros
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	reg [2:0] state_sig, state; 
	reg [1:0] valor_cuenta;//Valor de la cuenta
	reg carga_temp, enable_Reg, Fin_Lectura, a_d, cs, rd, wr, ts, MUX_AD;
	wire cuenta_terminada; //Cuenta terminada
	
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
parameter [2:0] RR_0 = 3'b000;
parameter [2:0] RR_1 = 3'b001;
parameter [2:0] RR_2 = 3'b010;
parameter [2:0] RR_3 = 3'b011;
parameter [2:0] RR_4 = 3'b100;
parameter [2:0] RR_5 = 3'b101;
parameter [2:0] RR_6 = 3'b110;
parameter [2:0] RR_7 = 3'b111; 
	
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Instanciacion del Temporizador
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Temporizador Lectura_Timer(clk, reset, carga_temp, valor_cuenta, cuenta_terminada);


//Logica de estado siguiente para salidas/control del temporizador
	always @(state or entrada or cuenta_terminada) begin
		case(state)
			RR_0: {carga_temp, valor_cuenta, state_sig} = {1'b1, 2'b10, entrada ? RR_1 : RR_0};
			RR_1: {carga_temp, valor_cuenta, state_sig} = {1'b1, 2'b10, RR_2};
			RR_2: {carga_temp, valor_cuenta, state_sig} = {cuenta_terminada, 2'b01, cuenta_terminada ? RR_3 : RR_2};
			RR_3: {carga_temp, valor_cuenta, state_sig} = {cuenta_terminada, 2'b11, cuenta_terminada ? RR_4 : RR_3};
			RR_4: {carga_temp, valor_cuenta, state_sig} = {cuenta_terminada, 2'b10, cuenta_terminada ? RR_5 : RR_4};
			RR_5: {carga_temp, valor_cuenta, state_sig} = {cuenta_terminada, 2'b11, cuenta_terminada ? RR_6 : RR_5};
			RR_6: {carga_temp, valor_cuenta, state_sig} = {cuenta_terminada, 2'b00, cuenta_terminada ? RR_7 : RR_6};
			RR_7: {carga_temp, valor_cuenta, state_sig} = {1'b1, 2'b00, RR_0};
			default: {carga_temp, valor_cuenta, state_sig} = {1'b0, 2'b00, RR_0};
		endcase
	end
	
	
//Logica de salida
	always @(state or entrada or cuenta_terminada) begin
		case(state)
			RR_0: {a_d, cs, rd, wr, MUX_AD, Fin_Lectura, ts, enable_Reg} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0};
			RR_1: {a_d, cs, rd, wr, MUX_AD, Fin_Lectura, ts, enable_Reg} = {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0};
			RR_2: {a_d, cs, rd, wr, MUX_AD, Fin_Lectura, ts, enable_Reg} = {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
			RR_3: {a_d, cs, rd, wr, MUX_AD, Fin_Lectura, ts, enable_Reg} = {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0};
			RR_4: {a_d, cs, rd, wr, MUX_AD, Fin_Lectura, ts, enable_Reg} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0};
			RR_5: {a_d, cs, rd, wr, MUX_AD, Fin_Lectura, ts, enable_Reg} = {1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1};
			RR_6: {a_d, cs, rd, wr, MUX_AD, Fin_Lectura, ts, enable_Reg} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0};
			RR_7: {a_d, cs, rd, wr, MUX_AD, Fin_Lectura, ts, enable_Reg} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0};
			default: {a_d, cs, rd, wr, MUX_AD, Fin_Lectura, ts, enable_Reg} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0};
		endcase
	end
	
//Para estado siguiente
	always @(posedge clk, posedge reset) begin
		if (reset) begin
		state <= RR_0;
		end
		else begin
		state <= state_sig;
		end
	end
	
endmodule
