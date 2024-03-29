

module control 
(	input logic CLR_LDB,
	input	logic Run,
	input logic Reset,
	input logic M,
	input logic Clk,
	output logic CLR_XA_LD_B,
	output logic Shift_XAB, 
	output logic ADD,	// ADD = 1 for add op
	output logic SUB,  // SUB = 1 for sub op
	output logic CLR_XA
);

// have synthesis tool pick encoding (recommended)
enum logic [4:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16} curr_state, next_state;

assign CLR_XA_LD_B = CLR_LDB;

always_ff @ (posedge Clk)
begin
	if(Reset)	// Synchronous Reset
		curr_state <= S0;	// Start state
	else
		curr_state <= next_state;
end


// This is the next state logic 
always_comb 
begin 
	next_state = curr_state; //not all combinations accounted for below
	unique case (curr_state) 
		// XA <- A + M * S
		S0:  begin 
			CLR_XA = 0;
			if (Run == 1)
				begin
					Shift_XAB = 0;
					SUB = 0;	
					if (M == 1)
						ADD = 1;
					else
						ADD = 0;	
					next_state = S1;	
				end
			else
				begin
					Shift_XAB = 0;
					SUB = 0;
					ADD = 0;
					next_state = S0;
				end
		end 
		// SHIFT XAB
		S1: begin
			CLR_XA = 0;
			Shift_XAB = 1;
			SUB = 0;
			ADD = 0;	
			next_state = S2;
		end
		// XA <- A + M * S
		S2:  begin 
			CLR_XA = 0;
			Shift_XAB = 0;
			SUB = 0;	
			if (M == 1)
				ADD = 1;
			else
				ADD = 0;	
			next_state = S3;
		end 
		// SHIFT XAB
		S3: begin
			CLR_XA = 0;
			Shift_XAB = 1;
			SUB = 0;
			ADD = 0;	
			next_state = S4;
		end
		// XA <- A + M * S
		S4:  begin 
			CLR_XA = 0;
			Shift_XAB = 0;
			SUB = 0;	
			if (M == 1)
				ADD = 1;
			else
				ADD = 0;	
			next_state = S5;	
		end 
		// SHIFT XAB
		S5: begin
			CLR_XA = 0;
			Shift_XAB = 1;
			SUB = 0;
			ADD = 0;	
			next_state = S6;
		end
		// XA <- A + M * S
		S6:  begin 
			CLR_XA = 0;
			Shift_XAB = 0;
			SUB = 0;	
			if (M == 1)
				ADD = 1;
			else
				ADD = 0;	
			next_state = S7;	
		end 
		// SHIFT XAB
		S7: begin
			CLR_XA = 0;
			Shift_XAB = 1;
			SUB = 0;
			ADD = 0;	
			next_state = S8;
		end
		// XA <- A + M * S
		S8:  begin 
			CLR_XA = 0;
			Shift_XAB = 0;
			SUB = 0;	
			if (M == 1)
				ADD = 1;
			else
				ADD = 0;	
			next_state = S9;		
		end 
		// SHIFT XAB
		S9: begin
			CLR_XA = 0;
			Shift_XAB = 1;
			SUB = 0;
			ADD = 0;
			next_state = S10;	
		end
		// XA <- A + M * S
		S10:  begin 
			CLR_XA = 0;
			Shift_XAB = 0;
			SUB = 0;	
			if (M == 1)
				ADD = 1;
			else
				ADD = 0;	
			next_state = S11;		
		end 
		// SHIFT XAB
		S11: begin
			CLR_XA = 0;
			Shift_XAB = 1;
			SUB = 0;
			ADD = 0;	
			next_state = S12;
		end
		// XA <- A + M * S
		S12:  begin 
			CLR_XA = 0;
			Shift_XAB = 0;
			SUB = 0;	
			if (M == 1)
				ADD = 1;
			else
				ADD = 0;	
			next_state = S13;		
		end 
		// SHIFT XAB
		S13: begin
			CLR_XA = 0;
			Shift_XAB = 1;
			SUB = 0;
			ADD = 0;	
			next_state = S14;
		end
		// XA <- A - M * S
		S14:  begin 
			CLR_XA = 0;
			Shift_XAB = 0;
			ADD = 0;	
			if (M == 1)
				SUB = 1;
			else
				SUB = 0;		
			next_state = S15;	
		end 
		// SHIFT XAB
		S15: begin
			CLR_XA = 0;
			Shift_XAB = 1;
			SUB = 0;
			ADD = 0;	
			next_state = S16;
		end
		// Wait until Run switch returns 0
		S16: begin
			Shift_XAB = 0;
			SUB = 0;
			ADD = 0;
			
			if (Run==1)
			begin
				next_state = S16;
				CLR_XA = 0;
			end
			else
			begin
				next_state = S0;
				CLR_XA = 1;
			end
		end
			
	endcase
end
	
	
endmodule