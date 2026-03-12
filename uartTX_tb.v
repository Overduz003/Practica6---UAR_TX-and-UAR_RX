module uartTX_tb #(
    parameter BAUD_RATE = 9600, 
    parameter CLOCK_FREQ = 50000000, 
    parameter BITS = 8               
)();

	// Entradas y salidas de Tx
    reg clk;
    reg rst;
    reg [BITS-1:0] data_in;
    reg start;
    
    //wire tx_out;
    wire busy;
	 
	 
	 //Entradas y salidas de Rx                                               
    //reg rx_in;
	 wire [BITS - 1:0]data_out;
	 wire UART_wire; 
	 wire data_ready;
    
    UART_Tx #(.BAUD_RATE(BAUD_RATE), .CLOCK_FREQ(CLOCK_FREQ), .BITS(BITS)) DUT1 (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .start(start),
        .tx_out(UART_wire),
        .busy(busy)
    );
	 
	 
	 UART_Rx #(.BAUD_RATE(BAUD_RATE), .CLK_FREQ(CLOCK_FREQ), .BITS(BITS)) DUT2 (
		.clk(clk),
		.rst(rst),
		.rx_in(UART_wire),
		.data_out(data_out),
		.data_ready(data_ready)
	 
	 );
    
	 
	 initial begin
        // Inicialización de señales
        clk = 0;
        rst = 1;
        data_in = 8'h00;
        start = 0;
		  #100;
		
		
		always #10 clk = ~clk; 
		
		initial
		begin
       
			$display("Simulacion iniciada");
			#30;
			rst = 1;
			#10;
			rst = 0;
         #20000;
        repeat(10) begin
            
            data_in = $random % 256;
            start = 1;
            #20;
            start = 0;
           
            wait(data_ready ==1); // Esperar a que empiece
            $display("Dato transmitido: %b, Dato recibido: %b", data_in, data_out);

        
            #20;
        end
        
        $display("Simulacion finalizada");
        $stop;
    end 

endmodule