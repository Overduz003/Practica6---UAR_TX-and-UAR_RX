module UART_tb #(parameter BAUD_RATE = 9600, parameter CLOCK_FREQ = 50000000, BITS = 8)();

// Señales
reg clk;
reg rst;
reg [BITS-1:0] data_in;
reg start;
wire busy;

wire [BITS-1:0] data_out;
wire data_ready;
wire tx_out;

// Instancia del DUT
UART #(
    .BAUD_RATE(BAUD_RATE),
    .CLOCK_FREQ(CLOCK_FREQ),
    .BITS(BITS)
) DUT (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .start(start),
    .rx_in(tx_out),
    .data_out(data_out),
    .busy(busy),
    .data_ready(data_ready),
    .tx_out(tx_out)
);

// Reloj 50 MHz
always #10 clk = ~clk;

initial begin
    clk = 0;
    rst = 0;
    data_in = 0;
    start = 0;
end

initial begin

    $display("Simulación iniciada");

    // Reset
    #30;
    rst = 1;
    #20;
    rst = 0;

    #20000;

    repeat(10) begin

        wait(!busy);               // esperar a que TX esté libre

        data_in = $random % 256;

        start = 1;
        @(posedge clk);            // pulso de un ciclo
        start = 0;

        @(posedge data_ready);     // esperar recepción

        $display("Dato transmitido: %b, Dato recibido: %b", data_in, data_out);

    end

    $display("Fin de simulación");
    $stop;

end

endmodule