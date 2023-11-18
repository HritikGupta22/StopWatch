module millisecond_delay(
    input wire clk,      // 50 MHz clock input
    output wire delay_done 
);

reg [31:0] counter;



always @(posedge clk)
 begin
    if (counter < 500_000) // 1 millisecond at 50 MHz
        counter <= counter + 1'b1;
    else
        counter <= 32'b0; 
end

assign delay_done = (counter == 500_000); 
endmodule



module stopwatch(
    output [7:0]millicount,
    output  [7:0]mincount,
    output  [7:0]seccount,
	 input clk,start,stop,reset,
	 output delay,
	 output wire   [6:0] HEX0,
    output wire  [6:0] HEX1,
    output wire   [6:0] HEX2,
    output wire  [6:0] HEX3,
    output wire   [6:0] HEX4,
    output wire   [6:0] HEX5

	 
);
reg [7:0] millicount_reg;
reg [7:0] seccount_reg;
reg [7:0] mincount_reg;
reg counting;

millisecond_delay(clk,delay);
always @( reset,start, stop) begin
    if (reset) begin
        
        counting <= 1'b0;  // Disable counting
    end else if (start) begin
        counting <= 1'b1;  // Enable counting on start button press
    end else if (stop) begin
        counting <= 1'b0;  // Disable counting on stop button press
	
		  
		  
    end
	 end
always@(posedge delay or posedge reset)
begin
if(reset)
 begin
millicount_reg=8'd0;
mincount_reg = 8'd0;
seccount_reg = 8'd0;
end
else
begin

if (counting) begin
    millicount_reg = millicount_reg + 1;
    if (millicount_reg >= 8'd99) begin
        seccount_reg = seccount_reg + 1;
        millicount_reg = 8'd0;
    end
    if (seccount_reg == 8'd59) begin
        mincount_reg = mincount_reg + 1;
        seccount_reg = 8'd0;
    end
    if (mincount_reg ==8'd59) begin
        mincount_reg = 8'd0;
        seccount_reg = 8'd0;
        millicount_reg = 8'd0;
    end
end
end
end
//assign millicount = millicount_reg;
//assign seccount = seccount_reg;
//assign mincount = mincount_reg;

	wire[11:0]bcd_mili,bcd_sec,bcd_min;
	wire[3:0] BCD0, BCD1, BCD2 ,BCD3,BCD4,BCD5;
	
	hex2bcd h1(.bin(millicount_reg),.bcd(bcd_mili));
	hex2bcd h2(.bin(seccount_reg),.bcd(bcd_sec));
	hex2bcd h3(.bin(mincount_reg),.bcd(bcd_min));
	
	assign BCD0=bcd_mili[3:0];
	assign BCD1=bcd_mili[7:4];
	assign BCD2=bcd_sec[3:0];
	assign BCD3=bcd_sec[7:4];
	assign BCD4=bcd_min[3:0];
	assign BCD5=bcd_min[7:4];
	
    bcd27seg b1(.bcd(BCD0), .HEX(HEX0));
    bcd27seg b2(.bcd(BCD1), .HEX(HEX1));
	 bcd27seg b3(.bcd(BCD2), .HEX(HEX2));
    bcd27seg b4(.bcd(BCD3), .HEX(HEX3));
	 bcd27seg b5(.bcd(BCD4), .HEX(HEX4));
    bcd27seg b6(.bcd(BCD5), .HEX(HEX5));




endmodule


