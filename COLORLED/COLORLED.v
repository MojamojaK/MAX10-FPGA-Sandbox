`define CYCLE_1SEC 48000000 // 48MHz

module COLORLED
(
	input 	wire 			clk,       	// 48MHz Clock
	input 	wire 			reset_n,   	// Reset Signal
	output 	wire [2:0] 	led 			// LED Output
);

reg [31:0] 	counter_1sec;
wire			period_1sec;

// 1 Second time keeper
always @(posedge clk, negedge reset_n)
begin
	if (~reset_n)
		counter_1sec <= 32'h00000000;
	else if (period_1sec)
		counter_1sec <= 32'h00000000;
	else
		counter_1sec <= counter_1sec + 32'h00000001;
end

assign period_1sec = (counter_1sec == (`CYCLE_1SEC - 1));


// LED State Manager
reg [2:0] counter_led;

always @(posedge clk, negedge reset_n)
begin
	if (~reset_n)
		counter_led <= 3'b000;
	else if (period_1sec)
		counter_led <= counter_led + 3'b001;
end

assign led = ~counter_led; // LED State is inverted on MAX10-FB board

endmodule
