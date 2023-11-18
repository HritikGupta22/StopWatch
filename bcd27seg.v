module bcd27seg(
    bcd,
    HEX
);

    
    input       [3:0] bcd;
    output reg  [6:0] HEX;

  
    always @ (bcd) begin
        case (bcd)
            //           GFEDCBA		
		4'd0 : HEX = 7'b0000001;
		4'd1 : HEX = 7'b1001111;
		4'd2 : HEX = 7'b0010010;
		4'd3 : HEX = 7'b0000110;
		4'd4 : HEX = 7'b1001100;
		4'd5 : HEX = 7'b0100100;
		4'd6 : HEX = 7'b0100000;
		4'd7 : HEX = 7'b0001111;
		4'd8 : HEX = 7'b0000000;
		4'd9 : HEX = 7'b0000100;
		4'd10: HEX = 7'b0001000;
		4'd11: HEX = 7'b1100000;
		4'd12: HEX = 7'b0110001;
		4'd13: HEX = 7'b1000010;
		4'd14: HEX = 7'b0110000;
		4'd15: HEX = 7'b0111000;


            default: HEX = 7'b0000110;
        endcase
    end

endmodule