module reversal #(
    parameter int WIDTH_IN  = 13,
    parameter int ARRAY_IN  = 16,
    parameter int MAX_POINT = 512
) (
    input logic clk,
    input logic rstn,

    input logic din_valid,
    input logic signed [WIDTH_IN-1:0] din_i[0:ARRAY_IN-1],
    input logic signed [WIDTH_IN-1:0] din_q[0:ARRAY_IN-1],

    output logic do_en,
    output logic signed [WIDTH_IN-1:0] do_re[0:ARRAY_IN-1],
    output logic signed [WIDTH_IN-1:0] do_im[0:ARRAY_IN-1]
);

    // Internal buffer
    logic signed [WIDTH_IN-1:0] buf_re[0:MAX_POINT-1];
    logic signed [WIDTH_IN-1:0] buf_im[0:MAX_POINT-1];

    // Write & output state
    logic [4:0] wr_addr_base;
    logic [8:0] rd_addr_base;
    logic [5:0] out_cnt; // Enough to count 0~32

    logic output_mode;
    logic prev_din_valid;

    // Bit reversal function
    function automatic [8:0] bit_reverse(input logic [8:0] in);
        for (int i = 0; i < 9; i++) bit_reverse[i] = in[8 - i];
    endfunction

    // Write logic
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            wr_addr_base <= 0;
            for (int j = 0; j < MAX_POINT; j++) begin
                buf_re[j] <= 0;
                buf_im[j] <= 0;
            end
        end else if (din_valid) begin
            for (int i = 0; i < ARRAY_IN; i++) begin
                buf_re[wr_addr_base * ARRAY_IN + i] <= din_i[i];
                buf_im[wr_addr_base * ARRAY_IN + i] <= din_q[i];
            end
            if (wr_addr_base < (MAX_POINT/ARRAY_IN - 1))
                wr_addr_base <= wr_addr_base + 1;
        end else if (!din_valid && prev_din_valid) begin
            // Reset write address if din_valid just fell
            wr_addr_base <= 0;
        end
    end

    // Detect falling edge of din_valid
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn)
            prev_din_valid <= 0;
        else
            prev_din_valid <= din_valid;
    end

    // Output control FSM
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            output_mode <= 0;
            rd_addr_base <= 0;
            out_cnt <= 0;
            do_en <= 0;
            for (int i = 0; i < ARRAY_IN; i++) begin
                do_re[i] <= 0;
                do_im[i] <= 0;
            end
        end else begin
            // Start output: din_valid falling edge and enough data written
            if (!din_valid && prev_din_valid && wr_addr_base == (MAX_POINT/ARRAY_IN - 1)) begin
                output_mode <= 1;
                rd_addr_base <= 0;
                out_cnt <= 0;
            end

            if (output_mode) begin
                automatic logic [8:0] rev_addr[0:ARRAY_IN-1];
                for (int i = 0; i < ARRAY_IN; i++) begin
                    rev_addr[i] = bit_reverse(rd_addr_base + i);
                    do_re[i] <= buf_re[rev_addr[i]];
                    do_im[i] <= buf_im[rev_addr[i]];
                end
                do_en <= 1;
                rd_addr_base <= rd_addr_base + ARRAY_IN;
                out_cnt <= out_cnt + 1;

                if (out_cnt == (MAX_POINT / ARRAY_IN - 1)) begin
                    output_mode <= 0;
                    do_en <= 0;
                end
            end else begin
                do_en <= 0;
            end
        end
    end

endmodule
