`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15:57:14 05/22/2017 
// Design Name: 
// Module Name: Ring
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

module Ring(
	 input alarma_on,
     input [9:0] pixel_y, pixel_x,
     input clk,reset,
     output wire [11:0] rgbtext
     );


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Control de las teclas
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

parameter ring_size = 15'd22374;//cantidad de pixeles (113x198)
parameter ringX = 113;     //largo en x
parameter ringY = 198;     //ancho en y
parameter InicioringX = 491; // coordenada de inicio en pantalla en el eje x
parameter InicioringY = 258;  // coordenada de inicio en pantalla en el eje y
parameter FinringX = 604;  // coordenada de finalizacion en pantalla en el eje x
parameter FinringY = 456;  // coordenada de finalizacion en pantalla en el eje y

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


reg [11:0]  Dato_color_ring [0:ring_size]; 
reg [11:0] RING;              
reg [4:0]  Selector; 
reg  [3:0]Numero; 
wire [15:0]STATE_Ring1;
reg [15:0]STATE_Ring; 
reg  [8:0]Y; 
reg  [8:0]X;
reg  [8:0]MUL; 
wire Activacion_img;

//Para el parpadeo
reg [5:0] contador;
reg enable;
reg [11:0] rgb;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Activacion de la imagen

assign Activacion_img = ((InicioringX < pixel_x) && (pixel_x < FinringX) && (InicioringY < pixel_y) && (pixel_y < FinringY));


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

always @(posedge clk) begin  
        if(reset)
                Selector<=5'h0;
        else begin
              if (Activacion_img)
                Selector <= 5'h1;
            else
                Selector <= 5'h0;
        end
end


///Lectura de las imágenes 

initial begin
    $readmemh ("Reloj2.list", Dato_color_ring); //paso de list a memorias
end


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Recorrido de la memoria
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

always @(*) begin //Selector elige los parametros a operar
			  case(Selector)
			      5'h0 : begin Y = 0; X= 0; MUL= 0;  end
			      5'h1 : begin Y = InicioringY; X=InicioringX; MUL= ringY;end
			      default: begin Y = InicioringY; X=InicioringX; MUL= ringY;end
			  endcase
end


assign STATE_Ring1 = (pixel_y - Y) + (pixel_x - X)*MUL; //Establecimieto de puntero para la memoria

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Recorrido de la memoria por cada una de las direcciones
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


always @(posedge clk) begin
				if(reset)
							STATE_Ring <= 0;
				else
							STATE_Ring <= STATE_Ring1;
				end

always @(posedge clk) begin
		if(reset)
							Numero<= 4'h0;
		else begin
			case (Selector)
				      5'h0  : Numero <= 4'hF;
				      5'h1  : Numero <= 4'hB;
							default: Numero <= 4'h0;
			endcase
		end
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Asignacion para color RGB
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


always @(posedge clk) begin   //de acuerdo al selector se asigna la imagen en memoria que corresponde
			if(reset)
							RING<=12'h000;
			else begin
	  		case (Numero)
				      4'hF : RING <= 12'h000;
							4'hB : RING <= Dato_color_ring[{STATE_Ring}];
							default: RING <= 12'h000;
				endcase
	  end
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////Generador del parpadeo
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

reg [6:0] count1reg;
reg count2reg;

always @(posedge clk)begin
    if(reset) begin
          count1reg<=0;
    end
    else if((pixel_y==0) && (pixel_x==0)) begin
          count1reg<=count1reg+1;
             end

     else begin
             count1reg<=count1reg;
    end
end



always @(posedge clk)begin
    if(reset) begin
       count2reg<=0;
          end
    else if(count1reg==127) begin
             count2reg<=count2reg+1;
             end
     else begin
             count2reg<=count2reg;
         end
end

always @(posedge clk)begin
            if(reset)
                    rgb = 12'h000;
            else begin
                    if(alarma_on) begin
                            if(count2reg)
                                    rgb =  RING;
                            else
                                    rgb = 12'h000;
                                    end
                    else rgb = 12'h000;
            end
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// SALIDA RGB
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

assign rgbtext=rgb;  

endmodule
