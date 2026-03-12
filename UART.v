module UART #(parameter BAUD_RATE = 9600, parameter CLOCK_FREQ = 50000000,BITS = 8)(
	input wire clk,
   input wire rst,
   input wire [BITS-1:0] data_in,
   input wire start,
   input wire rx_in,
	output [7:0] data_out,
	output wire busy,
	output wire data_ready,
	output wire tx_out
);

UART_Tx #(.BAUD_RATE(9600), .CLOCK_FREQ(50000000), .BITS(8)) UART_TX (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .start(start),
    .tx_out(tx_out),
    .busy(busy)
);

UART_Rx #(.BAUD_RATE(9600), .CLOCK_FREQ(50000000), .BITS(8)) UART_RX (
    .clk(clk),
    .rst(rst),
    .rx_in(rx_in),
    .data_out(data_out),
    .data_ready(data_ready)
);

endmodule