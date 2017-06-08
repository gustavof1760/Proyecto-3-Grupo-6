`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2017 04:26:44
// Design Name: 
// Module Name: CTRL_RTC_PICOBLAZE
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


module CTRL_RTC_PICOBLAZE(
     input clk, reset, IRQ,
	 input ps2d,ps2c,rx_en,
	 inout  [7:0] AddressData,
	 output h_sync,v_sync,
	 output a_d,cs,rd,wr,
	 output [11:0] rgb,
	 output speaker
    );
    
    
wire [11:0]	address;
wire [17:0] instruction;
wire bram_enable;
wire [7:0] port_id;
wire [7:0] out_port;
reg	[7:0] in_port;
wire write_strobe;
wire k_write_strobe;
wire read_strobe;
wire interrupt;            
wire interrupt_ack;
wire kcpsm6_sleep;         
wire kcpsm6_reset;         
wire reset_cpu;
wire rdl;
wire int_request;



kcpsm6 #(
	.interrupt_vector	(12'h3FF),
	.scratch_pad_memory_size(64),
	.hwbuild		(8'h00)
	)



Picoblaze (
	.address 		(address),
	.instruction 	(instruction),
	.bram_enable 	(bram_enable),
	.port_id 		(port_id),
	.write_strobe 	(write_strobe),
	.k_write_strobe (k_write_strobe),
	.out_port 		(out_port),
	.read_strobe 	(read_strobe),
	.in_port 		(in_port),
	.interrupt 		(interrupt),
	.interrupt_ack 	(interrupt_ack),
	.reset 		    (kcpsm6_reset),
	.sleep		    (kcpsm6_sleep),
	.clk 			(clk)
	); 
	
assign kcpsm6_sleep = 1'b0;
assign interrupt = 1'b0;



CRTL_RTC_ROM #(
	.C_FAMILY ("7S"),   	//Family 'S6' or 'V6'
	.C_RAM_SIZE_KWORDS (2),  	//Program size '1', '2' or '4'
	.C_JTAG_LOADER_ENABLE (0)
	)  	//Include JTAG Loader when set to '1' 



ROM (    				
 	.rdl (kcpsm6_reset),
	.enable (bram_enable),
	.address (address),
	.instruction (instruction),
	.clk (clk)
	);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// ENTRADAS_PUERTOS
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

reg [7:0] dato_rtc_puerto;
reg [7:0] puerto_listoW;
reg [7:0] puerto_listoR;//
reg [7:0] puerto_anno, puerto_mes, puerto_dia, puerto_hora, puerto_minutos, puerto_segundos, puerto_Temphora, puerto_Tempminutos, puerto_Tempsegundos, puerto_Temphora_regresivo, puerto_Tempmin_regresivo, puerto_Tempseg_regresivo;
reg [7:0] puerto_FH, puerto_PT, puerto_OKK;


always @ (posedge clk)
  begin
      case (port_id) 
          8'h0b : in_port <= dato_rtc_puerto;
		  8'h10 : in_port <= puerto_anno;
		  8'h11 : in_port <= puerto_mes;
		  8'h12 : in_port <= puerto_dia;
		  8'h13 : in_port <= puerto_hora;
		  8'h14 : in_port <= puerto_minutos;
		  8'h15 : in_port <= puerto_segundos;
		  8'h16 : in_port <= puerto_Temphora;
		  8'h17 : in_port <= puerto_Tempminutos;
		  8'h18 : in_port <= puerto_Tempsegundos;
		  8'h19 : in_port <= puerto_Temphora_regresivo;
		  8'h1a : in_port <= puerto_Tempmin_regresivo;
		  8'h1b : in_port <= puerto_Tempseg_regresivo;
		  8'h20 : in_port <= puerto_FH;
		  8'h21 : in_port <= puerto_PT;
		  8'h22 : in_port <= puerto_OKK;
		  8'h23 : in_port <= puerto_listoW;
		  8'h24 : in_port <= puerto_listoR;

        default : in_port <= 8'bXXXXXXXX ;  
      endcase
  end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// SALIDAS_PUERTOS
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

reg [7:0] puerto_vga_anno;
reg [7:0] puerto_vga_mes;
reg [7:0] puerto_vga_dia;
reg [7:0] puerto_vga_hora;
reg [7:0] puerto_vga_minutos;
reg [7:0] puerto_vga_segundos;
reg [7:0] puerto_vga_Temphora;
reg [7:0] puerto_vga_Tempmin;
reg [7:0] puerto_vga_Tempseg;
reg [7:0] puerto_address_rtc_in;
reg [7:0] puerto_data_rtc_in;
reg [7:0] puerto_Win;
reg [7:0] puerto_Rin;
reg [7:0] puerto_control;
reg [7:0] puerto_prog;

always @ (posedge clk)
  begin
        if (write_strobe == 1'b1) 
        begin
		
        if (port_id == 8'h00) begin
          puerto_vga_anno <= out_port;
        end
		  
		  if (port_id == 8'h01) begin
          puerto_vga_mes <= out_port;
        end
		  
		  if (port_id == 8'h02) begin
          puerto_vga_dia <= out_port;
        end
		  
		  if (port_id == 8'h03) begin
          puerto_vga_hora <= out_port;
        end
		  
		  if (port_id == 8'h04) begin
          puerto_vga_minutos <= out_port;
        end
		  
		  if (port_id == 8'h05) begin
          puerto_vga_segundos <= out_port;
        end
		  
		  if (port_id == 8'h06) begin
          puerto_vga_Temphora <= out_port;
        end
		  
		  if (port_id == 8'h07) begin
          puerto_vga_Tempmin <= out_port;
        end
		  
		  if (port_id == 8'h08) begin
          puerto_vga_Tempseg <= out_port;
        end
		  
		  if (port_id == 8'h09) begin
          puerto_address_rtc_in <= out_port;
        end
		  
		  if (port_id == 8'h0a) begin
          puerto_data_rtc_in <= out_port;
        end
		  
		  if (port_id == 8'h0e) begin
          puerto_Win <= out_port;
        end
		  
		  if (port_id == 8'h0f) begin
          puerto_Rin <= out_port;
        end
		  
		  if (port_id == 8'h0c) begin
          puerto_control <= out_port;
        end
		  
		  if (port_id == 8'h0d) begin
          puerto_prog <= out_port;
        end 
		  
        end
  end
  

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Instanciacion Teclado
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Top_Teclado Teclado(clk,reset,ps2d,ps2c,rx_en, Tecla_FH,Tecla_Temp,Ring_off,Tecla_Enter,Tecla_arri,Tecla_abaj,Tecla_izq,Tecla_der);

FlipFlops Enter(clk,reset,Tecla_Enter,B_prog);
FlipFlops Arriba(clk,reset,Tecla_arri,B_up);
FlipFlops Abajo(clk,reset,Tecla_abaj,B_down);
FlipFlops Derecha(clk,reset,Tecla_der,B_right);
FlipFlops Izquierda(clk,reset,Tecla_izq,B_left);
FlipFlops Fecha_Hora(clk,reset,Tecla_FH,B_FH);
FlipFlops Temporizador(clk,reset,Tecla_Temp,B_Temp);

reg BoFH, BoTemp, OK;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

always @(posedge clk, posedge reset)
  if (reset)
    BoFH <= 1'b0;
  else
	 case (BoFH)
		1'b0:	if (B_FH)
					BoFH <= 1'b1;
				else
					BoFH <= BoFH;
		1'b1:	if (puerto_control[0])
					BoFH <= 1'b0;
				else
					BoFH <= BoFH;
		default: BoFH <= BoFH;
	 endcase


always @(posedge clk, posedge reset)
  if (reset)
    BoTemp <= 1'b0;
  else
	 case (BoTemp)
		1'b0:	if (B_Temp)
					BoTemp <= 1'b1;
				else
					BoTemp <= BoTemp;
		1'b1:	if (puerto_control[0])
					BoTemp <= 1'b0;
				else
					BoTemp <= BoTemp;
		default: BoTemp <= BoTemp;
	 endcase

	 
always @(posedge clk, posedge reset)
  if (reset)
    OK <= 1'b0;
  else
	 case (OK)
		1'b0:	if (B_prog)
					OK <= 1'b1;
				else
					OK <= OK;
		1'b1:	if (puerto_control[0])
					OK <= OK;
				else
					OK <= 1'b0;
		default: OK <= OK;
	 endcase


always @(posedge clk)
	if (BoFH)
		puerto_FH = 8'h1;
	else
		puerto_FH = 8'h0;

		
always @(posedge clk)
	if (BoTemp)
		puerto_PT = 8'h1;
	else
		puerto_PT = 8'h0;

		
always @(posedge clk)
	if (OK)
		puerto_OKK = 8'h1;
	else
		puerto_OKK = 8'h0;
		



wire TS, seleccion_AD;
wire [9:0] pixel_x,pixel_y;
wire [7:0] Dia, Mes, Anno, Hora, Minutos, Segundos, Temp_Hora, Temp_Min, Temp_Seg, salida_AD;
wire [3:0] state_U, direccion;
wire [2:0] read_state, write_state;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Instanciacion Ciclo de Lectura y Escritura
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Lectura Lectura(clk, 
                reset, 
                puerto_Rin[0], 
                selec_Read, listo_Read, 
                read_state, 
                R_ad, 
                R_cs, 
                R_rd, 
                R_wr, 
                R_ts, 
                enable_Reg
                );
                
                
Escritura Escritura(clk, 
                    reset, 
                    puerto_Win[0],
                    selec_Write, 
                    listo_Write, 
                    write_state, 
                    W_ad, 
                    W_cs, 
                    W_rd, 
                    W_wr, 
                    W_ts
                    ); 


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Instanciacion CONTROL
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CONTROL Sist_CONTROL(clk, reset, B_prog, B_right, B_left, B_up, B_down, BoFH, BoTemp, state_U, direccion, Dia, Mes, Anno, Hora, Minutos, Segundos, Temp_Hora, Temp_Min, Temp_Seg) ; 


assign a_d = puerto_control[0] ? W_ad : R_ad;
assign cs = puerto_control[0] ? W_cs : R_cs;
assign rd = puerto_control[0] ? W_rd : R_rd;
assign wr = puerto_control[0] ? W_wr : R_wr;
assign TS = puerto_control[0] ? W_ts : R_ts;
assign seleccion_AD = puerto_control[0] ? selec_Write : selec_Read;


assign salida_AD = seleccion_AD ? puerto_data_rtc_in : puerto_address_rtc_in;
assign AddressData = TS ? 8'hzz : salida_AD;


//Registro Lectura del RTC
always @(posedge clk, posedge reset)
	if (reset)
		dato_rtc_puerto = 8'h00;
	else
		if (enable_Reg)
			dato_rtc_puerto = AddressData;
		else
			dato_rtc_puerto = dato_rtc_puerto;


//Registro listo Write
always @(posedge clk, posedge reset)
	if (reset) 
		puerto_listoW = 8'h00;
	else
		case (puerto_listoW)
		8'h00: if (listo_Write)
					puerto_listoW = 8'h01;
				 else
					puerto_listoW = puerto_listoW;
		8'h01: if (puerto_Win[0])
					puerto_listoW = 8'h00;
				 else
					puerto_listoW = puerto_listoW;
		default: puerto_listoW = puerto_listoW;
		endcase


//Registro listo Read		
always @(posedge clk, posedge reset)
	if (reset) 
		puerto_listoR = 8'h00;
	else
		case (puerto_listoR)
		8'h00: if (listo_Read)
					puerto_listoR = 8'h01;
				 else
					puerto_listoR = puerto_listoR;
		8'h01: if (puerto_Rin[0])
					puerto_listoR = 8'h00;
				 else
					puerto_listoR = puerto_listoR;
		default: puerto_listoR = puerto_listoR;
		endcase

		
//Registro de datos de usuario
always @(posedge clk)
	begin
		puerto_anno <= Anno;
		puerto_mes <= Mes;
		puerto_dia <= Dia;
		puerto_hora <= Hora;
		puerto_minutos <= Minutos;
		puerto_segundos <= Segundos;
		puerto_Temphora <= Temp_Hora;
		puerto_Tempminutos <= Temp_Min;
		puerto_Tempsegundos <= Temp_Seg;
		
		begin
            if ((Temp_Min == 8'b0) & (Temp_Seg == 8'b0))
                if (Temp_Hora == 8'b0)
                    puerto_Temphora_regresivo = Temp_Hora;
                else
                    if ((Temp_Hora[3:0] == 4'h3)|(Temp_Hora[3:0] == 4'h2)|(Temp_Hora[3:0] == 4'h1)|(Temp_Hora[3:0] == 4'h0))
                        puerto_Temphora_regresivo = 8'h24 - Temp_Hora;
                    else
                        puerto_Temphora_regresivo = 8'h1e - Temp_Hora;
            else
                if ((Temp_Hora[3:0] == 4'h3)|(Temp_Hora[3:0] == 4'h2)|(Temp_Hora[3:0] == 4'h1)|(Temp_Hora[3:0] == 4'h0))
                    puerto_Temphora_regresivo = 8'h23 - Temp_Hora;
                else
                    puerto_Temphora_regresivo = 8'h1d - Temp_Hora;
       end
		
		
		begin
            if (Temp_Seg == 8'b0)
                if (Temp_Min == 8'b0)
                    puerto_Tempmin_regresivo = Temp_Min;
                else
                    if (Temp_Min[3:0] == 4'h0)
                        puerto_Tempmin_regresivo = 8'h60 - Temp_Min;
                    else
                        puerto_Tempmin_regresivo = 8'h5a - Temp_Min;
            else
                puerto_Tempmin_regresivo = 8'h59 - Temp_Min;
        end
			
							
		begin
            if (Temp_Seg == 8'h0)
              puerto_Tempseg_regresivo = Temp_Seg;
            else
              if (Temp_Seg[3:0] == 4'h0)
                    puerto_Tempseg_regresivo = 8'h60 - Temp_Seg;
                else
                    puerto_Tempseg_regresivo = 8'h5a - Temp_Seg;
       end
		
	end



//Registro para VGA

reg [7:0] rhora,rmin,rseg,dia,mes,anno,thora,tmin,tseg;

reg [7:0] rthoravga,
  		   rtminvga,
  			rtsegvga;

  always @(posedge clk, posedge reset) begin
  if (reset)
    {rthoravga,rtminvga,rtsegvga} = {8'h00,8'h00,8'h00};
  else begin
  //Resta de hora
  	if ((puerto_vga_Tempmin == 8'b0) & (puerto_vga_Tempseg == 8'b0)) begin
  		if (puerto_vga_Temphora == 8'b0)
  			rthoravga = puerto_vga_Temphora;
  		else begin
  			if ((puerto_vga_Temphora[3:0] == 4'h3)|(puerto_vga_Temphora[3:0] == 4'h2)|(puerto_vga_Temphora[3:0] == 4'h1)|(puerto_vga_Temphora[3:0] == 4'h0))
  				rthoravga = 8'h24 - puerto_vga_Temphora;
  			else
  				rthoravga = 8'h1e - puerto_vga_Temphora;
      end
    end
  	else begin
  		if ((puerto_vga_Temphora[3:0] == 4'h3)|(puerto_vga_Temphora[3:0] == 4'h2)|(puerto_vga_Temphora[3:0] == 4'h1)|(puerto_vga_Temphora[3:0] == 4'h0))
  			rthoravga = 8'h23 - puerto_vga_Temphora;
  		else
  			rthoravga = 8'h1d - puerto_vga_Temphora;
    end

  //Resta de minutos
  	if (puerto_vga_Tempseg == 8'b0) begin
  		if (puerto_vga_Tempmin == 8'b0)
  			rtminvga = puerto_vga_Tempmin;
  		else begin
  			if (puerto_vga_Tempmin[3:0] == 4'h0)
  				rtminvga = 8'h60 - puerto_vga_Tempmin;
  			else
  				rtminvga = 8'h5a - puerto_vga_Tempmin;
      end
    end
  	else
  		rtminvga = 8'h59 - puerto_vga_Tempmin;


  //Resta de segundos
  	if (puerto_vga_Tempseg == 8'h0)
  		rtsegvga = puerto_vga_Tempseg;
  	else begin
  		if (puerto_vga_Tempseg[3:0] == 4'h0)
  			rtsegvga = 8'h60 - puerto_vga_Tempseg;
  		else
  			rtsegvga = 8'h5a - puerto_vga_Tempseg;
    end
    end
  end


wire [7:0] mtseg,mtmin,mthora;
assign mtseg = IRQ ? rtsegvga:8'h00;
assign mtmin = IRQ ? rtminvga:8'h00;
assign mthora = IRQ ? rthoravga:8'h00;



always @(posedge clk)
	if ( (pixel_x==0)&& (pixel_y==0)) begin 
		{rhora,rmin,rseg,dia,mes,anno} = {puerto_vga_hora,puerto_vga_minutos,puerto_vga_segundos,puerto_vga_dia,puerto_vga_mes,puerto_vga_anno};
		if (puerto_control)
			{thora,tmin,tseg} = {puerto_vga_Temphora,puerto_vga_Tempmin,puerto_vga_Tempseg};
		else
			{thora,tmin,tseg} = {mthora,mtmin,mtseg};
		end
	else
		{rhora,rmin,rseg,dia,mes,anno,thora,tmin,tseg} = {rhora,rmin,rseg,dia,mes,anno,thora,tmin,tseg};
		






////////////////////////////////////////////////////////////////////////////


reg FFalarma;
always @ (posedge clk, posedge reset)
	if (reset)
		FFalarma <= 1'b0;
	else begin
		FFalarma <= FFalarma;
		case (FFalarma)
			1'b0: if (IRQ)
						FFalarma <= 1'b1;
					else
						FFalarma <= 1'b0;
			1'b1: if ((~IRQ && Ring_off)|puerto_prog[0])
						FFalarma <= 1'b0;
					else
						FFalarma <= 1'b1;
			default: FFalarma <= 1'b1;
		endcase
	end

and(alarma,FFalarma,~IRQ);

Divisor_25MHz Divisor_25MHz(
    .clk_in(clk),
    .reset(reset),
    .clk2(clk2)
    );
    

Top_VGA Control_VGA(clk,reset,alarma,h_sync,v_sync,rgb,pixel_x,pixel_y,rhora,rmin,rseg,dia,mes,anno,thora,tmin,tseg,puerto_prog[0],direccion);

music Melodia(alarma,clk2,speaker);

endmodule
