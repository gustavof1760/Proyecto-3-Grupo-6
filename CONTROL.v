`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:43:00 05/14/2017 
// Design Name: 
// Module Name:    CONTROL
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
module CONTROL (
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// ENTRADAS y SALIDAS
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	input clk, reset, T_Det, T_der, T_izq, T_arri, T_abaj, T_FeHo, T_Temp,
	output reg [3:0] state, direccion, 
	output reg [7:0] dia, mes, anno, hora, minutos, segundos, temp_hora, temp_min, temp_seg
	);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
reg [3:0] state_sig;
parameter [3:0] M0 = 4'b0000; //Mantener estado
parameter [3:0] rst_reloj = 4'b0001; //Reset del reloj
parameter [3:0] Prog_dia = 4'b0010; //Prog. dia
parameter [3:0] Prog_mes = 4'b0011; //Prog. mes
parameter [3:0] Prog_anno = 4'b0100; //Prog. anno
parameter [3:0] Prog_hora = 4'b0101; //Prog. hora
parameter [3:0] Prog_min = 4'b0110; //Prog. minutos
parameter [3:0] Prog_seg = 4'b0111; //Prog. segundos
parameter [3:0] rst_temp = 4'b1000; //Reset del temporizador
parameter [3:0] Prog_temphora = 4'b1001; //Prog. hora temporizador
parameter [3:0] Prog_tempmin = 4'b1010; //Prog. minutos temporizador
parameter [3:0] Prog_tempseg = 4'b1011; //Prog. segundos temporizador
parameter [3:0] A = 4'b1100;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always @* begin //Logica de siguiente estado
    case(state)
        M0: if (T_FeHo)
                state_sig = rst_reloj;
             else if (T_Temp)
                state_sig = rst_temp;
             else
                state_sig = M0;
                
                
        rst_reloj: state_sig = Prog_dia;
        
        
        Prog_dia: if (T_Det)
                    state_sig = M0;
                else if (T_der)
                    state_sig = Prog_mes;
                else if (T_izq)
                    state_sig = Prog_seg;
                else
                    state_sig = Prog_dia;
                    
                    
        Prog_mes: if (T_Det)
                    state_sig = M0;
                else if (T_der)
                    state_sig = Prog_anno;
                else if (T_izq)
                    state_sig = Prog_dia;
                else
                    state_sig = Prog_mes;
                    
                    
        Prog_anno: if (T_Det)
                    state_sig = M0;
                else if (T_der)
                    state_sig = Prog_hora;
                else if (T_izq)
                    state_sig = Prog_mes;
                else
                    state_sig = Prog_anno;
                    
        Prog_hora: if (T_Det)
                    state_sig = M0;
                else if (T_der)
                    state_sig = Prog_min;
                else if (T_izq)
                    state_sig = Prog_anno;
                else
                    state_sig = Prog_hora;
                    
                    
        Prog_min: if (T_Det)
                    state_sig = M0;
                else if (T_der)
                    state_sig = Prog_seg;
                else if (T_izq)
                    state_sig = Prog_hora;
                else
                    state_sig = Prog_min;
                    
                    
        Prog_seg: if (T_Det)
                    state_sig = M0;
                else if (T_der)
                    state_sig = Prog_dia;
                else if (T_izq)
                    state_sig = Prog_min;
                else
                    state_sig = Prog_seg;
                    
                    
        rst_temp: state_sig = Prog_temphora;
        
        
        Prog_temphora: if (T_Det)
                    state_sig = M0;
                else if (T_der)
                    state_sig = Prog_tempmin;
                else if (T_izq)
                    state_sig = Prog_tempseg;
                else
                    state_sig = Prog_temphora;
                    
                    
        Prog_tempmin: if (T_Det)
                    state_sig = M0;
                else if (T_der)
                    state_sig = Prog_tempseg;
                else if (T_izq)
                    state_sig = Prog_temphora;
                else
                    state_sig = Prog_tempmin;
                    
                    
        Prog_tempseg: if (T_Det)
                    state_sig = M0;
                else if (T_der)
                    state_sig = Prog_temphora;
                else if (T_izq)
                    state_sig = Prog_tempmin;
                else
                    state_sig = Prog_tempseg;
                    
                    
        default: state_sig = M0;
        
    endcase
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Control de las teclas
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


always @(posedge clk, posedge reset)
    if (reset) 
        {dia, mes, anno, hora, minutos, segundos, temp_hora, temp_min, temp_seg, direccion} = {8'h0,8'h0,8'h0,8'h0,8'h0,8'h0,8'h0,8'h0,8'h0,4'h0} ;
    
    else 
        begin
            {dia, mes, anno, hora, minutos, segundos, temp_hora, temp_min, temp_seg, direccion} = {dia, mes, anno, hora, minutos, segundos, temp_hora, temp_min, temp_seg, direccion} ;
            case(state)
            
               M0:{dia, mes, anno, hora, minutos, segundos, temp_hora, temp_min, temp_seg, direccion} = {dia, mes, anno, hora, minutos, segundos, temp_hora, temp_min, temp_seg, direccion} ;
               
               
               rst_reloj: {dia, mes, anno, hora, minutos, segundos, direccion} = {8'h1, 8'h1, 8'h0, 8'h0, 8'h0, 8'h0, 4'h0 } ;
               
               
               Prog_dia: begin
                        direccion = 4'h3;
                        if (T_arri)
                            if (dia == 8'h31)
                                dia = 8'h1;
                            else if (dia[3:0] == 4'h9)
                                dia = dia + 8'h7;
                            else
                                dia = dia + 8'h1;
                        else
                            if (T_abaj)
                                if (dia == 8'h0)
                                    dia = 8'h31;
                                else if (dia[3:0] == 4'h0)
                                    dia = dia - 8'h7;
                                else
                                dia = dia - 8'h1;
                        end
                        
                        
               Prog_mes: begin
                        direccion = 4'h4;
                        if (T_arri)
                            if (mes == 8'h12)
                                mes = 8'h1;
                            else if (mes[3:0] == 4'h9)
                                mes = mes + 8'h7;
                            else
                                mes = mes + 8'h1;
                        else if (T_abaj)
                            if (mes == 8'h1)
                                mes = 8'h12;
                            else if (mes[3:0] == 4'h0)
                                mes = mes - 8'h7;
                            else
                                mes = mes - 8'h1;
                        end
               
               
              Prog_anno: begin
                        direccion = 4'h5;
                        if (T_arri)
                            if (anno == 8'h99)
                                anno = 8'h0;
                            else if (anno[3:0] == 4'h9)
                                anno = anno + 8'h7;
                            else
                                anno = anno + 8'h1;
                        else if (T_abaj)
                            if (anno == 8'h0)
                                anno = 8'h99;
                            else if (anno[3:0] == 4'h0)
                                anno = anno - 8'h7;
                            else
                                anno = anno - 8'h1;
                        end
              
              
              Prog_hora:begin
                        direccion = 4'h0;
                        if (T_arri)
                            if (hora == 8'h23)
                                hora = 8'h0;
                            else if (hora[3:0] == 4'h9)
                                hora = hora + 8'h7;
                            else
                                hora = hora + 8'h1;
                        else if (T_abaj)
                            if (hora == 8'h0)
                                hora = 8'h23;
                            else if (hora[3:0] == 4'h0)
                                hora = hora - 8'h7;
                            else
                                hora = hora - 8'h1;
                        end
              
              
              Prog_min: begin
                        direccion = 4'h1;
                        if (T_arri)
                            if (minutos == 8'h59)
                                minutos = 8'h0;
                            else if (minutos[3:0] == 4'h9)
                                minutos = minutos + 8'h7;
                            else
                                minutos = minutos + 8'h1;
                        else if (T_abaj)
                            if (minutos == 8'h0)
                                minutos = 8'h59;
                            else if (minutos[3:0] == 4'h0)
                                minutos = minutos - 8'h7;
                            else
                                minutos = minutos - 8'h1;
                        end
              
              
              Prog_seg: begin
                        direccion = 4'h2;
                        if (T_arri)
                            if (segundos == 8'h59)
                                segundos= 8'h0;
                            else if (segundos[3:0] == 4'h9)
                                segundos = segundos + 8'h7;
                            else
                                segundos = segundos + 8'h1;
                        else if (T_abaj)
                            if (segundos == 8'h0)
                                segundos = 8'h59;
                            else if (segundos[3:0] == 4'h0)
                                segundos = segundos - 8'h7;
                            else
                                segundos = segundos - 8'h1;
                        end
              
              
              rst_temp: {temp_hora, temp_min, temp_seg, direccion} = {8'b0, 8'b0, 8'b0, 4'h0} ;
              
              
              Prog_temphora: begin
                        direccion = 4'h6;
                        if (T_arri)
                            if (temp_hora == 8'h23)
                                temp_hora = 8'h0;
                            else if (temp_hora[3:0] == 4'h9)
                                temp_hora = temp_hora + 8'h7;
                            else
                                temp_hora = temp_hora + 8'h1;
                        else if (T_abaj)
                            if (temp_hora == 8'h0)
                                temp_hora = 8'h23;
                            else if (temp_hora[3:0] == 4'h0)
                                temp_hora = temp_hora - 8'h7;
                            else
                                temp_hora = temp_hora - 8'h1;
                        end
              
              
              Prog_tempmin: begin
                        direccion = 4'h7;
                        if (T_arri)
                            if (temp_min == 8'h59)
                                temp_min = 8'h0;
                            else if (temp_min[3:0] == 4'h9)
                                temp_min = temp_min + 8'h7;
                            else
                                temp_min = temp_min + 8'h1;
                        else if (T_abaj)
                            if (temp_min == 8'h0)
                                temp_min = 8'h59;
                            else if (temp_min[3:0] == 4'h0)
                                temp_min = temp_min - 8'h7;
                            else
                                temp_min = temp_min - 8'h1;
                        end
              
              
              Prog_tempseg: begin
                        direccion = 4'h8;
                        if (T_arri)
                            if (temp_seg == 8'h59)
                                temp_seg= 8'h0;
                            else if (temp_seg[3:0] == 4'h9)
                                temp_seg = temp_seg + 8'h7;
                            else
                                temp_seg = temp_seg + 8'h1;
                        else if (T_abaj)
                            if (temp_seg == 8'h0)
                                temp_seg = 8'h59;
                            else if (temp_seg[3:0] == 4'h0)
                                temp_seg = temp_seg - 8'h7;
                            else
                                temp_seg = temp_seg - 8'h1;
                        end
              
              
              A: {dia, mes, anno, hora, minutos, segundos, temp_hora, temp_min, temp_seg,direccion} = {8'hff, 8'hff, 8'hff, 8'hff, 8'hff, 8'hff, 8'hff, 8'hff, 8'hff , 4'hf} ;
              
              
              default: {dia, mes, anno, hora, minutos, segundos, temp_hora, temp_min, temp_seg, direccion} = {8'h1, 8'h1, 8'h0, 8'h0, 8'h0, 8'h0, 8'h0, 8'h0, 8'h0, 4'h0 } ; //Evita warning de Latch
          
          
          endcase
end

always @(posedge clk, posedge reset)
    begin
        if (reset)
            state <= M0;
        else
            state <= state_sig;
    end

endmodule