`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    22:02:32 05/22/2017
// Design Name:
// Module Name:    Generador_Cajas_Imagenes
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
module Generador_Cajas_Imagenes(
	input [9:0] pix_y, pix_x,
	 input wire video_on,
	 input reset,
	 output  [11:0] rgbtext

);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// SECCION GENERADORA DE CUADROS EN LA PANTALLA
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	 wire [11:0] color_rgb; //output de salida


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// VALORES LIMITES DE LOS CUADROS QUE ENCERRARAN LOS NUMEROS
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Limites para caja de hora

   localparam Caja_Hora1_XI = 20; //limite izquierdo de la caja
   localparam Caja_Hora1_XD = 230; //limite derecho de la caja
   localparam Caja_Hora1_YA = 90; //Limite superior de la caja
   localparam Caja_Hora1_YD = 100; //limite inferior de la caja
   
   assign Caja_Hora1_on = (pix_x>=Caja_Hora1_XI)&&(pix_x<=Caja_Hora1_XD)&&(pix_y>=Caja_Hora1_YA)&&(pix_y<=Caja_Hora1_YD); 


   localparam Caja_Hora2_XI = 20; //limite izquierdo de la caja
   localparam Caja_Hora2_XD = 230; //limite derecho de la caja
   localparam Caja_Hora2_YA = 260; //Limite superior de la caja
   localparam Caja_Hora2_YD = 270; //limite inferior de la caja
           
   assign Caja_Hora2_on = (pix_x>=Caja_Hora2_XI)&&(pix_x<=Caja_Hora2_XD)&&(pix_y>=Caja_Hora2_YA)&&(pix_y<=Caja_Hora2_YD); 


   localparam Caja_Hora3_XI = 20; //limite izquierdo de la caja
   localparam Caja_Hora3_XD = 30; //limite derecho de la caja
   localparam Caja_Hora3_YA = 90; //Limite superior de la caja
   localparam Caja_Hora3_YD = 270; //limite inferior de la caja
           
   assign Caja_Hora3_on = (pix_x>=Caja_Hora3_XI)&&(pix_x<=Caja_Hora3_XD)&&(pix_y>=Caja_Hora3_YA)&&(pix_y<=Caja_Hora3_YD);


   localparam Caja_Hora4_XI = 220; //limite izquierdo de la caja
   localparam Caja_Hora4_XD = 230; //limite derecho de la caja
   localparam Caja_Hora4_YA = 90; //Limite superior de la caja
   localparam Caja_Hora4_YD = 270; //limite inferior de la caja
           
   assign Caja_Hora4_on = (pix_x>=Caja_Hora4_XI)&&(pix_x<=Caja_Hora4_XD)&&(pix_y>=Caja_Hora4_YA)&&(pix_y<=Caja_Hora4_YD);
   
   
   localparam Caja_Hora5_XI = 50; //limite izquierdo de la caja
   localparam Caja_Hora5_XD = 200; //limite derecho de la caja
   localparam Caja_Hora5_YA = 68; //Limite superior de la caja
   localparam Caja_Hora5_YD = 70; //limite inferior de la caja
           
   assign Caja_Hora5_on = (pix_x>=Caja_Hora5_XI)&&(pix_x<=Caja_Hora5_XD)&&(pix_y>=Caja_Hora5_YA)&&(pix_y<=Caja_Hora5_YD);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Limites para caja de fecha
                  
  localparam Caja_Fecha1_XI = 250; //limite izquierdo de la caja
  localparam Caja_Fecha1_XD = 420; //limite derecho de la caja
  localparam Caja_Fecha1_YA = 90; //Limite superior de la caja
  localparam Caja_Fecha1_YD = 100; //limite inferior de la caja
  
  assign Caja_Fecha1_on = (pix_x>=Caja_Fecha1_XI)&&(pix_x<=Caja_Fecha1_XD)&&(pix_y>=Caja_Fecha1_YA)&&(pix_y<=Caja_Fecha1_YD); 


  localparam Caja_Fecha2_XI = 250; //limite izquierdo de la caja
  localparam Caja_Fecha2_XD = 420; //limite derecho de la caja
  localparam Caja_Fecha2_YA = 207; //Limite superior de la caja
  localparam Caja_Fecha2_YD = 217; //limite inferior de la caja
          
  assign Caja_Fecha2_on = (pix_x>=Caja_Fecha2_XI)&&(pix_x<=Caja_Fecha2_XD)&&(pix_y>=Caja_Fecha2_YA)&&(pix_y<=Caja_Fecha2_YD); 


  localparam Caja_Fecha3_XI = 250; //limite izquierdo de la caja
  localparam Caja_Fecha3_XD = 260; //limite derecho de la caja
  localparam Caja_Fecha3_YA = 90; //Limite superior de la caja
  localparam Caja_Fecha3_YD = 217; //limite inferior de la caja
          
  assign Caja_Fecha3_on = (pix_x>=Caja_Fecha3_XI)&&(pix_x<=Caja_Fecha3_XD)&&(pix_y>=Caja_Fecha3_YA)&&(pix_y<=Caja_Fecha3_YD);


  localparam Caja_Fecha4_XI = 410; //limite izquierdo de la caja
  localparam Caja_Fecha4_XD = 420; //limite derecho de la caja
  localparam Caja_Fecha4_YA = 90; //Limite superior de la caja
  localparam Caja_Fecha4_YD = 217; //limite inferior de la caja
          
  assign Caja_Fecha4_on = (pix_x>=Caja_Fecha4_XI)&&(pix_x<=Caja_Fecha4_XD)&&(pix_y>=Caja_Fecha4_YA)&&(pix_y<=Caja_Fecha4_YD);
  
  
  localparam Caja_Fecha5_XI = 275; //limite izquierdo de la caja
  localparam Caja_Fecha5_XD = 395; //limite derecho de la caja
  localparam Caja_Fecha5_YA = 68; //Limite superior de la caja
  localparam Caja_Fecha5_YD = 70; //limite inferior de la caja
          
  assign Caja_Fecha5_on = (pix_x>=Caja_Fecha5_XI)&&(pix_x<=Caja_Fecha5_XD)&&(pix_y>=Caja_Fecha5_YA)&&(pix_y<=Caja_Fecha5_YD);
  
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //Limites para caja de temporizador
                        
  localparam Caja_Tempo1_XI = 250; //limite izquierdo de la caja
  localparam Caja_Tempo1_XD = 625; //limite derecho de la caja
  localparam Caja_Tempo1_YA = 237; //Limite superior de la caja
  localparam Caja_Tempo1_YD = 257; //limite inferior de la caja
    
  assign Caja_Tempo1_on = (pix_x>=Caja_Tempo1_XI)&&(pix_x<=Caja_Tempo1_XD)&&(pix_y>=Caja_Tempo1_YA)&&(pix_y<=Caja_Tempo1_YD); 


  localparam Caja_Tempo2_XI = 250; //limite izquierdo de la caja
  localparam Caja_Tempo2_XD = 625; //limite derecho de la caja
  localparam Caja_Tempo2_YA = 457; //Limite superior de la caja
  localparam Caja_Tempo2_YD = 477; //limite inferior de la caja
            
  assign Caja_Tempo2_on = (pix_x>=Caja_Tempo2_XI)&&(pix_x<=Caja_Tempo2_XD)&&(pix_y>=Caja_Tempo2_YA)&&(pix_y<=Caja_Tempo2_YD); 


  localparam Caja_Tempo3_XI = 250; //limite izquierdo de la caja
  localparam Caja_Tempo3_XD = 270; //limite derecho de la caja
  localparam Caja_Tempo3_YA = 237; //Limite superior de la caja
  localparam Caja_Tempo3_YD = 477; //limite inferior de la caja
            
  assign Caja_Tempo3_on = (pix_x>=Caja_Tempo3_XI)&&(pix_x<=Caja_Tempo3_XD)&&(pix_y>=Caja_Tempo3_YA)&&(pix_y<=Caja_Tempo3_YD);
 
 
  localparam Caja_Tempo4_XI = 605; //limite izquierdo de la caja
  localparam Caja_Tempo4_XD = 625; //limite derecho de la caja
  localparam Caja_Tempo4_YA = 237; //Limite superior de la caja
  localparam Caja_Tempo4_YD = 477; //limite inferior de la caja
            
  assign Caja_Tempo4_on = (pix_x>=Caja_Tempo4_XI)&&(pix_x<=Caja_Tempo4_XD)&&(pix_y>=Caja_Tempo4_YA)&&(pix_y<=Caja_Tempo4_YD); 


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// SECCION GENERADORA DE IMAGENES EN LA PANTALLA
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //Imagen Hora
      localparam hora_X = 127; 
      localparam hora_Y = 33; 
      localparam hora_size = 4191;// (127x33)
  
      //Declaración señales
      
      reg [11:0] Dato_Color_H [0:hora_size];
      wire [19:0] STATE_H;
      wire hora;
      
      //Coordenadas Imagen Hora
      reg signed [10:0]XH = 65;
      reg signed [9:0]YH = 30;
      
      //Lectura de las imágenes 
      initial
      $readmemh ("Hora.list", Dato_Color_H);
      
      //Asignación STATE
      assign STATE_H = ((pix_x-XH)*hora_Y)+pix_y-YH;
      
      //Verifica cuando se cumplen las coordenadas para pintar la imagen
      assign hora = (pix_x >= XH && pix_x < XH + hora_X && pix_y >= YH && pix_y < YH + hora_Y);
      

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //Imagen 24H
      localparam Ho_X = 90; 
      localparam Ho_Y = 57; 
      localparam Ho_size = 5130;// (127x33)
  
      //Declaración señales
      
      reg [11:0] Dato_Color_Ho [0:Ho_size];
      wire [19:0] STATE_Ho;
      wire Ho;
      
      //Coordenadas Imagen 24H
      reg signed [10:0]XHo = 80;
      reg signed [9:0]YHo = 193;
      
      //Lectura de las imágenes 
      initial
      $readmemh ("H.list", Dato_Color_Ho);
      
      //Asignación STATE
      assign STATE_Ho = ((pix_x-XHo)*Ho_Y)+pix_y-YHo;
      
      //Verifica cuando se cumplen las coordenadas para pintar la imagen
      assign Ho = (pix_x >= XHo && pix_x < XHo + Ho_X && pix_y >= YHo && pix_y < YHo + Ho_Y);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
    
      //Imagen Fecha
      localparam fecha_X = 91; 
      localparam fecha_Y = 40; 
      localparam fecha_size = 3640;// (91x40)
  
      //Declaración señales
      
      reg [11:0] Dato_Color_F [0:fecha_size];
      wire [19:0] STATE_F;
      wire fecha;
      
      //Coordenadas Imagen Fecha
      reg signed [10:0]XF = 290;
      reg signed [9:0]YF = 30;
      
      //Lectura de las imágenes 
      initial
      $readmemh ("Fecha.list", Dato_Color_F);
      
      //Asignación STATE
      assign STATE_F = ((pix_x-XF)*fecha_Y)+pix_y-YF;
      
      //Verifica cuando se cumplen las coordenadas para pintar la imagen
      assign fecha = (pix_x >= XF && pix_x < XF + fecha_X && pix_y >= YF && pix_y < YF + fecha_Y);
      
      
      
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        //Imagen Configuracion
        localparam configuracion_X = 180; 
        localparam configuracion_Y = 40; 
        localparam configuracion_size = 7200;// (180x40)
    
        //Declaración señales
        
        reg [11:0] Dato_Color_C [0:configuracion_size];
        wire [19:0] STATE_C;
        wire configuracion;
        
        //Coordenadas Imagen Configuracion
        reg signed [10:0]XC = 435;
        reg signed [9:0]YC= 30;
        
        //Lectura de las imágenes 
        initial
        $readmemh ("Configuracion.list", Dato_Color_C);
        
        //Asignación STATE
        assign STATE_C = ((pix_x-XC)*configuracion_Y)+pix_y-YC;
        
        //Verifica cuando se cumplen las coordenadas para pintar la imagen
        assign configuracion = (pix_x >= XC && pix_x < XC + configuracion_X && pix_y >= YC && pix_y < YC + configuracion_Y);
        

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        //Imagen Seleccion
        localparam seleccion_X = 180; 
        localparam seleccion_Y = 120; 
        localparam seleccion_size = 21600;// (180x40)
    
        //Declaración señales
        
        reg [11:0] Dato_Color_seleccion [0:seleccion_size];
        wire [19:0] STATE_seleccion;
        wire seleccion;
        
        //Coordenadas Imagen Seleccion
        reg signed [10:0]Xseleccion = 435;
        reg signed [9:0]Yseleccion= 90;
        
        //Lectura de las imágenes 
        initial
        $readmemh ("Seleccion.list", Dato_Color_seleccion);
        
        //Asignación STATE
        assign STATE_seleccion = ((pix_x-Xseleccion)*seleccion_Y)+pix_y-Yseleccion;
        
        //Verifica cuando se cumplen las coordenadas para pintar la imagen
        assign seleccion = (pix_x >= Xseleccion && pix_x < Xseleccion + seleccion_X && pix_y >= Yseleccion && pix_y < Yseleccion + seleccion_Y);
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        //Imagen GEK
        localparam GEK_X = 117; 
        localparam GEK_Y = 71; 
        localparam GEK_size = 8307;// (91x40)
    
        //Declaración señales
        
        reg [11:0] Dato_Color_GEK [0:GEK_size];
        wire [19:0] STATE_GEK;
        wire GEK;
        
        //Coordenadas Imagen GEK
        reg signed [10:0]XGEK = 65;
        reg signed [9:0]YGEK = 300;
        
        //Lectura de las imágenes 
        initial
        $readmemh ("GEK.list", Dato_Color_GEK);
        
        //Asignación STATE
        assign STATE_GEK = ((pix_x-XGEK)*GEK_Y)+pix_y-YGEK;
        
        //Verifica cuando se cumplen las coordenadas para pintar la imagen
        assign GEK = (pix_x >= XGEK && pix_x < XGEK + GEK_X && pix_y >= YGEK && pix_y < YGEK + GEK_Y);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
        //Imagen Flechas
        localparam Flechas_X = 117; 
        localparam Flechas_Y = 71; 
        localparam Flechas_size = 8307;// (91x40)
    
        //Declaración señales
        
        reg [11:0] Dato_Color_Flechas [0:Flechas_size];
        wire [19:0] STATE_Flechas;
        wire Flechas;
        
        //Coordenadas Imagen Flechas
        reg signed [10:0]XFlechas = 65;
        reg signed [9:0]YFlechas = 400;
        
        //Lectura de las imágenes 
        initial
        $readmemh ("Flechas.list", Dato_Color_Flechas);
        
        //Asignación STATE
        assign STATE_Flechas = ((pix_x-XFlechas)*Flechas_Y)+pix_y-YFlechas;
        
        //Verifica cuando se cumplen las coordenadas para pintar la imagen
        assign Flechas = (pix_x >= XFlechas && pix_x < XFlechas + Flechas_X && pix_y >= YFlechas && pix_y < YFlechas + Flechas_Y);
  
 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   

       //Imagen dia/mes/año
        localparam ddmmaa_X = 119; 
        localparam ddmmaa_Y = 27; 
        localparam ddmmaa_size = 3213;// (91x40)
    
        //Declaración señales
        
        reg [11:0] Dato_Color_ddmmaa [0:ddmmaa_size];
        wire [19:0] STATE_ddmmaa;
        wire ddmmaa;
        
        //Coordenadas Imagen Dia/mes/año
        reg signed [10:0]Xddmmaa = 275;
        reg signed [9:0]Yddmmaa = 170;
        
        //Lectura de las imágenes 
        initial
        $readmemh ("ddmmaa.list", Dato_Color_ddmmaa);
        
        //Asignación STATE
        assign STATE_ddmmaa = ((pix_x-Xddmmaa)*ddmmaa_Y)+pix_y-Yddmmaa;
        
        //Verifica cuando se cumplen las coordenadas para pintar la imagen
        assign ddmmaa = (pix_x >= Xddmmaa && pix_x < Xddmmaa + ddmmaa_X && pix_y >= Yddmmaa && pix_y < Yddmmaa + ddmmaa_Y);
      
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    

      //Imagen Temporizador
      localparam Temporizador_X = 212; 
      localparam Temporizador_Y = 57; 
      localparam Temporizador_size = 12084;// (212x57)
  
      //Declaración señales
      
      reg [11:0] Dato_Color_Temporizador [0:Temporizador_size];
      wire [19:0] STATE_Temporizador;
      wire Temporizador;
      
      //Coordenadas Imagen Fecha 
      reg signed [10:0]XTemporizador = 280;
      reg signed [9:0]YTemporizador = 265;
      
      //Lectura de las imágenes 
      initial
      $readmemh ("Temporizador.list", Dato_Color_Temporizador);
      
      //Asignación STATE
      assign STATE_Temporizador = ((pix_x-XTemporizador)*Temporizador_Y)+pix_y-YTemporizador;
      
      //Verifica cuando se cumplen las coordenadas para pintar la imagen
      assign Temporizador = (pix_x >= XTemporizador && pix_x < XTemporizador + Temporizador_X && pix_y >= YTemporizador && pix_y < YTemporizador + Temporizador_Y);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
     //Imagen Barra1
      localparam Barra1_X = 15; 
      localparam Barra1_Y = 31; 
      localparam Barra1_size = 465;// (15x31)
  
      //Declaración señales
      
      reg [11:0] Dato_Color_Barra1 [0:Barra1_size];
      wire [19:0] STATE_Barra1;
      wire Barra1;
      
      //Coordenadas Imagen Barra 
      reg signed [10:0]XBarra1 = 304;
      reg signed [9:0]YBarra1 = 127;
      
      //Lectura de las imágenes 
      initial
      $readmemh ("Barra.list", Dato_Color_Barra1);
      
      //Asignación STATE
      assign STATE_Barra1 = ((pix_x-XBarra1)*Barra1_Y)+pix_y-YBarra1;
      
      //Verifica cuando se cumplen las coordenadas para pintar la imagen
      assign Barra1 = (pix_x >= XBarra1 && pix_x < XBarra1 + Barra1_X && pix_y >= YBarra1 && pix_y < YBarra1 + Barra1_Y);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
      
      //Imagen Barra2
      localparam Barra2_X = 15; 
      localparam Barra2_Y = 31; 
      localparam Barra2_size = 465;// (15x31)
  
      //Declaración señales
      
      reg [11:0] Dato_Color_Barra2 [0:Barra2_size];
      wire [19:0] STATE_Barra2;
      wire Barra2;
      
      //Coordenadas Imagen Barra 
      reg signed [10:0]XBarra2 = 352;
      reg signed [9:0]YBarra2 = 127;
      
      //Lectura de las imágenes 
      initial
      $readmemh ("Barra.list", Dato_Color_Barra2);
      
      //Asignación STATE
      assign STATE_Barra2 = ((pix_x-XBarra2)*Barra2_Y)+pix_y-YBarra2;
      
      //Verifica cuando se cumplen las coordenadas para pintar la imagen
      assign Barra2 = (pix_x >= XBarra2 && pix_x < XBarra2 + Barra2_X && pix_y >= YBarra2 && pix_y < YBarra2 + Barra2_Y);
      

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
      //Imagen Puntos1
      localparam Puntos1_X = 15; 
      localparam Puntos1_Y = 31; 
      localparam Puntos1_size = 465;// (15x31)
  
      //Declaración señales
      
      reg [11:0] Dato_Color_Puntos1 [0:Puntos1_size];
      wire [19:0] STATE_Puntos1;
      wire Puntos1;
      
      //Coordenadas Imagen Puntos 
      reg signed [10:0]XPuntos1 = 96;
      reg signed [9:0]YPuntos1 = 127;
      
      //Lectura de las imágenes 
      initial
      $readmemh ("Puntos.list", Dato_Color_Puntos1);
      
      //Asignación STATE
      assign STATE_Puntos1 = ((pix_x-XPuntos1)*Puntos1_Y)+pix_y-YPuntos1;
      
      //Verifica cuando se cumplen las coordenadas para pintar la imagen
      assign Puntos1 = (pix_x >= XPuntos1 && pix_x < XPuntos1 + Puntos1_X && pix_y >= YPuntos1 && pix_y < YPuntos1 + Puntos1_Y);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      //Imagen Puntos2
      localparam Puntos2_X = 15; 
      localparam Puntos2_Y = 31; 
      localparam Puntos2_size = 465;// (15x31)
  
      //Declaración señales
      
      reg [11:0] Dato_Color_Puntos2 [0:Puntos2_size];
      wire [19:0] STATE_Puntos2;
      wire Puntos2;
      
      //Coordenadas Imagen Puntos
      reg signed [10:0]XPuntos2 = 144;
      reg signed [9:0]YPuntos2 = 127;
      
      //Lectura de las imágenes 
      initial
      $readmemh ("Puntos.list", Dato_Color_Puntos2);
      
      //Asignación STATE
      assign STATE_Puntos2 = ((pix_x-XPuntos2)*Puntos2_Y)+pix_y-YPuntos2;
      
      //Verifica cuando se cumplen las coordenadas para pintar la imagen
      assign Puntos2 = (pix_x >= XPuntos2 && pix_x < XPuntos2 + Puntos2_X && pix_y >= YPuntos2 && pix_y < YPuntos2 + Puntos2_Y);
      
      
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

      //Imagen Puntos3
      localparam Puntos3_X = 15; 
      localparam Puntos3_Y = 31; 
      localparam Puntos3_size = 465;// (15x31)
  
      //Declaración señales
      
      reg [11:0] Dato_Color_Puntos3 [0:Puntos3_size];
      wire [19:0] STATE_Puntos3;
      wire Puntos3;
      
      //Coordenadas Imagen Puntos
      reg signed [10:0]XPuntos3 = 336;
      reg signed [9:0]YPuntos3 = 383;
      
      //Lectura de las imágenes 
      initial
      $readmemh ("Puntos.list", Dato_Color_Puntos3);
      
      //Asignación STATE
      assign STATE_Puntos3 = ((pix_x-XPuntos3)*Puntos3_Y)+pix_y-YPuntos3;
      
      //Verifica cuando se cumplen las coordenadas para pintar la imagen
      assign Puntos3 = (pix_x >= XPuntos3 && pix_x < XPuntos3 + Puntos3_X && pix_y >= YPuntos3 && pix_y < YPuntos3 + Puntos3_Y);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

      //Imagen Puntos4
      localparam Puntos4_X = 15; 
      localparam Puntos4_Y = 31; 
      localparam Puntos4_size = 465;// (15x31)
  
      //Declaración señales
      
      reg [11:0] Dato_Color_Puntos4 [0:Puntos4_size];
      wire [19:0] STATE_Puntos4;
      wire Puntos4;
      
      //Coordenadas Imagen Puntos 
      reg signed [10:0]XPuntos4 = 384;
      reg signed [9:0]YPuntos4 = 383;
      
      //Lectura de las imágenes 
      initial
      $readmemh ("Puntos.list", Dato_Color_Puntos4);
      
      //Asignación STATE
      assign STATE_Puntos4 = ((pix_x-XPuntos4)*Puntos4_Y)+pix_y-YPuntos4;
      
      //Verifica cuando se cumplen las coordenadas para pintar la imagen
      assign Puntos4 = (pix_x >= XPuntos4 && pix_x < XPuntos4 + Puntos4_X && pix_y >= YPuntos4 && pix_y < YPuntos4 + Puntos4_Y);



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

wire [11:0] color;
assign color=12'h009;
reg [11:0] rgbtext1=12'hfff;

always@*
			if(reset)
					rgbtext1<=12'h000;
			else begin
						case(video_on)
						0: begin
								rgbtext1<=12'h000;
								end

						1: begin
									//PARA IMPRIMIR CUADROS
									if (Caja_Hora1_on | Caja_Hora2_on | Caja_Hora3_on |Caja_Hora4_on | Caja_Hora5_on)
										rgbtext1<=12'hF36;
									else if(Caja_Fecha1_on | Caja_Fecha2_on |Caja_Fecha3_on | Caja_Fecha4_on | Caja_Fecha5_on)
											rgbtext1<=12'h4CF;
									else if(Caja_Tempo1_on | Caja_Tempo2_on | Caja_Tempo3_on | Caja_Tempo4_on)
											rgbtext1<=12'hFB0;
									/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                    //PARA IMPRIMIR IMAGENES
                                                               
                                    else if (hora) rgbtext1 = Dato_Color_H[{STATE_H}];
                                    else if (Ho) rgbtext1 = Dato_Color_Ho[{STATE_Ho}]; 
                                    else if (fecha) rgbtext1 = Dato_Color_F[{STATE_F}];
                                    else if (configuracion) rgbtext1 = Dato_Color_C[{STATE_C}];
                                    else if (seleccion) rgbtext1 = Dato_Color_seleccion[{STATE_seleccion}];
                                    else if (GEK) rgbtext1 = Dato_Color_GEK[{STATE_GEK}];
                                    else if (Flechas) rgbtext1 = Dato_Color_Flechas[{STATE_Flechas}]; 
                                    else if (ddmmaa) rgbtext1 = Dato_Color_ddmmaa[{STATE_ddmmaa}]; 
                                    else if (Temporizador) rgbtext1 = Dato_Color_Temporizador[{STATE_Temporizador}]; 
                                    else if (Barra1) rgbtext1 = Dato_Color_Barra1[{STATE_Barra1}];      		
									else if (Barra2) rgbtext1 = Dato_Color_Barra2[{STATE_Barra2}];
									else if (Puntos1) rgbtext1 = Dato_Color_Puntos1[{STATE_Puntos1}];
									else if (Puntos2) rgbtext1 = Dato_Color_Puntos2[{STATE_Puntos2}];
									else if (Puntos3) rgbtext1 = Dato_Color_Puntos3[{STATE_Puntos3}];
									else if (Puntos4) rgbtext1 = Dato_Color_Puntos4[{STATE_Puntos4}];
									else
									rgbtext1<=12'h000;
						   end

						default:rgbtext1<=12'hfff;
						endcase
end

assign rgbtext=rgbtext1;

endmodule