`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:51:58 05/20/2017
// Design Name:
// Module Name:    ps2_receptor
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
module ps2_receptor(
    input clk,reset,
    input ps2d,ps2c,rx_en,
    output reg rx_done_tick,
    output wire [7:0] salida
    );

      localparam [1:0] idle=2'b00, dps=2'b01 , load=2'b10 ;
      reg [1:0] state_reg, state_sig;
      reg [7:0] filter_reg;
      wire [7:0] filter_sig;
      reg f_ps2c_reg ;
      wire f_ps2c_sig ;
      reg [3:0] n_reg , n_sig ;
      reg [10:0] b_reg , b_sig ;
      wire fall_edge ;

always @(posedge clk, posedge reset)
    if (reset)
        begin
            filter_reg  <= 0;
            f_ps2c_reg <= 0;
        end
        
    else begin
            filter_reg<= filter_sig;
            f_ps2c_reg<= f_ps2c_sig;
        end


assign filter_sig = {ps2c, filter_reg[7:1]};
assign f_ps2c_sig = (filter_reg==8'b11111111) ? 1'b1 : (filter_reg == 8'b00000000) ? 1'b0 : f_ps2c_reg;
assign fall_edge = f_ps2c_reg & ~f_ps2c_sig;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Maquina de estados
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

always @(posedge clk, posedge reset)
      if (reset)
          begin
              state_reg <= idle;
              n_reg <= 0 ;
              b_reg <= 0 ;
          end
      else begin
              state_reg <= state_sig ;
              n_reg <= n_sig;
              b_reg <= b_sig;
      end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Logica de estado siguiente
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

always @* begin
          state_sig = state_reg;
          rx_done_tick = 1'b0;
          n_sig = n_reg;
          b_sig = b_reg;
      case (state_reg)
      idle:
            if (fall_edge & rx_en)
            begin
                b_sig = { ps2d, b_reg [10:1]} ;
                n_sig = 4'b1001;
                state_sig = dps;
            end

      dps: 
            if (fall_edge) begin
                b_sig = { ps2d , b_reg [10:1] };
                if (n_reg==0)
                    state_sig = load;
                else
                    n_sig = n_reg - 1 ;
            end

      load: 
            begin
                  state_sig = idle;
                  rx_done_tick = 1'b1 ;
            end
      endcase
end


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////SALIDA
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
assign salida = b_reg[8:1];


endmodule
