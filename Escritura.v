`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:03:53 05/13/2017
// Design Name: 
// Module Name:    Escritura 
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

module Escritura(clk, reset, entrada, MUX_AD, Fin_Escritura, state, a_d, cs, rd, wr, ts) ;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////ENTRADAS y SALIDAS
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	input clk, entrada, reset ; 
	output a_d, cs, rd, wr, ts, MUX_AD, Fin_Escritura; 
	output[2:0] state; 
	
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Registros
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    	
	reg [2:0] state_sig, state ; 
	reg [1:0] valor_cuenta; //Valor de la cuenta
	reg carga_temp, Fin_Escritura, a_d, cs, rd, wr, ts, MUX_AD;
	wire cuenta_terminada; //Cuenta terminada

	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
parameter [2:0] WW0 = 3'b000;
parameter [2:0] WW1 = 3'b001; 
parameter [2:0] WW2 = 3'b010; 
parameter [2:0] WW3 = 3'b011;
parameter [2:0] WW4 = 3'b100; 
parameter [2:0] WW5 = 3'b101;
parameter [2:0] WW6 = 3'b110;  
parameter [2:0] WW7 = 3'b111; 
	
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Instanciacion del Temporizador
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Temporizador Escritura_timer(clk, reset, carga_temp, valor_cuenta, cuenta_terminada);


// Logica de estado siguiente para salidas  al temporizador
	always @(state or entrada or cuenta_terminada) begin
		case(state)
			WW0: {carga_temp, valor_cuenta, state_sig} = {1'b1, 2'b10, entrada ? WW1 : WW0};
			WW1: {carga_temp, valor_cuenta, state_sig} = {1'b1, 2'b10, WW2};
			WW2: {carga_temp, valor_cuenta, state_sig} = {cuenta_terminada, 2'b01, cuenta_terminada ? WW3 : WW2};
			WW3: {carga_temp, valor_cuenta, state_sig} = {cuenta_terminada, 2'b11, cuenta_terminada ? WW4 : WW3};
			WW4: {carga_temp, valor_cuenta, state_sig} = {cuenta_terminada, 2'b10, cuenta_terminada ? WW5 : WW4};
			WW5: {carga_temp, valor_cuenta, state_sig} = {cuenta_terminada, 2'b11, cuenta_terminada ? WW6 : WW5};
			WW6: {carga_temp, valor_cuenta, state_sig} = {cuenta_terminada, 2'b00, cuenta_terminada ? WW7 : WW6};
			WW7: {carga_temp, valor_cuenta, state_sig} = {1'b1, 2'b00, WW0};
			default: {carga_temp, valor_cuenta, state_sig} = {1'b0, 2'b00, WW0};
		endcase
	end


//Logica de salida
	always @(state or entrada or cuenta_terminada) begin
		ts = 1'b0; 
		case(state)
			WW0: {a_d, cs, rd, wr, MUX_AD, Fin_Escritura} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0};
			WW1: {a_d, cs, rd, wr, MUX_AD, Fin_Escritura} = {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0};
			WW2: {a_d, cs, rd, wr, MUX_AD, Fin_Escritura} = {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0};
			WW3: {a_d, cs, rd, wr, MUX_AD, Fin_Escritura} = {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0};
			WW4: {a_d, cs, rd, wr, MUX_AD, Fin_Escritura} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0};
			WW5: {a_d, cs, rd, wr, MUX_AD, Fin_Escritura} = {1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0};
			WW6: {a_d, cs, rd, wr, MUX_AD, Fin_Escritura} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0};
			WW7: {a_d, cs, rd, wr, MUX_AD, Fin_Escritura} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
			default: {a_d, cs, rd, wr, MUX_AD, Fin_Escritura} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0};
		endcase
	end

//Para estado siguiente
	always @(posedge clk, posedge reset) begin
		if (reset) begin
		state <= WW0;
		end
		else begin
		state <= state_sig;
		end
	end
	
endmodule

