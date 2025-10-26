`timescale 1ns/1ps

module gray_code_testbench;
	localparam COUNTER_MSB = 32;
	reg clock;
	reg reset;
	integer counter;
	integer i;
	reg [COUNTER_MSB-1:0] gray_code_input;
	reg [COUNTER_MSB:0] gray_code_output;
	reg input_valid;
	reg output_valid;
	
    integer file_handle;
    reg [COUNTER_MSB-1:0] current_gray_code;	
    reg [COUNTER_MSB-1:0] previous_gray_code;	
    reg [COUNTER_MSB-1:0] gray_code_difference;
    reg [COUNTER_MSB-1:0] difference_sum;

	function [COUNTER_MSB:0] gray_code;
		input valid_data_in;
		input [COUNTER_MSB-1:0] data_input;
		integer i;
		reg [COUNTER_MSB-1:0] carry;
		reg [COUNTER_MSB-1:0] addend_a;
		reg [COUNTER_MSB-1:0] addend_b;
		reg [COUNTER_MSB-1:0] sum;
		reg valid_data_out;
		begin
			carry[0] = 1'b0;
			addend_a[0] = data_input[0];
			addend_b[0] = 1'b1;
			sum[0] = addend_a[0] ^ addend_b[0];

			for (i = 1; i < COUNTER_MSB; i = i + 1) begin
				addend_b[i] = 1'b0;
				carry[i] = ((addend_a[i-1] & carry[i-1]) | (addend_a[i-1] & addend_b[i-1])) | (addend_b[i-1] & carry[i-1]);
				addend_a[i] = data_input[i];
				sum[i] = (carry[i] ^ addend_a[i]) ^ addend_b[i];
				gray_code[i-1] = sum[i-1] ^ sum[i];
			end
			
			valid_data_out = valid_data_in;
			
//			$display("carry = %b\taddend_a = %b\taddend_b = %b\n", carry, addend_a[COUNTER_MSB-1], addend_b[COUNTER_MSB-1]);
			gray_code[COUNTER_MSB-1] = (carry[COUNTER_MSB-1] ^ addend_a[COUNTER_MSB-1]) ^ addend_b[COUNTER_MSB-1];
			gray_code[COUNTER_MSB] = valid_data_out;
		end
	endfunction
	
	initial begin
		clock = 1'b0;
		reset = 1'b1;
	end

	initial begin
		#995 reset = 1'b0;
	end
	
	always begin
		#5 clock = ~clock;
	end

    initial begin
        file_handle = $fopen("output.txt", "w"); // "w" for write mode
        if (file_handle == 0) begin
            $display("Error: Could not open file.");
            $finish;
        end
    end

	always @(posedge clock)  begin
		if (reset == 1'b1) begin
			counter			<= 0;
			gray_code_input	<= 32'b0;
			gray_code_output<= 33'b0;
			input_valid		<= 1'b0;
			output_valid	<= 1'b0;
			current_gray_code	<= 32'b0;
			previous_gray_code	<= 32'b0;
			gray_code_difference<= 32'b0;
			difference_sum = 0;
		end
		else begin
			gray_code_input		<= counter;
			input_valid			<= 1'b1;
			gray_code_output	<= gray_code(input_valid, gray_code_input);
			output_valid		<= gray_code_output[COUNTER_MSB];
			
			if (counter < (2**16-1)) begin
				if (output_valid == 1'b1) begin
					// Verify the gray codes
					current_gray_code	<= gray_code_output[COUNTER_MSB-1:0];
					previous_gray_code	<= current_gray_code;
					
					gray_code_difference	<= current_gray_code ^ previous_gray_code;
					difference_sum = 0;
					
					for (i = 0; i < COUNTER_MSB-1; i = i + 1) begin
						if (gray_code_difference[i] == 1'b1) begin
							difference_sum = difference_sum + 1;
						end
					end
					
					if (difference_sum > 1) begin
						$display("GRAY CODE ERROR: counter = %b\n", counter); 
					end
					
    				$fwrite(file_handle, "%b\n", gray_code_output[COUNTER_MSB-1:0]);
    			end
    		end
    		else begin
    			$fclose(file_handle);
    		end
    		
    		if (input_valid) begin
				counter				<= counter + 1;
			end
		end
	end
endmodule
