module fft_cbfp_1 #(
    parameter int WIDTH_IN      = 25,
    parameter int WIDTH_OUT     = 12,
    parameter int ARRAY_IN      = 16
) (
    input logic clk,
    input logic rst_n,
    input logic i_valid,

    input logic signed [WIDTH_IN-1:0] din_i[0:ARRAY_IN-1],
    input logic signed [WIDTH_IN-1:0] din_q[0:ARRAY_IN-1],

    output logic dout_valid,
    output logic signed [WIDTH_OUT-1:0] dout_i[0:ARRAY_IN-1],
    output logic signed [WIDTH_OUT-1:0] dout_q[0:ARRAY_IN-1],
    output logic [4:0] index_out[0:511]
);

    reg [5:0] cnt;
    reg [4:0] shift_re_msb;
    reg [4:0] shift_re_lsb;
    reg [4:0] shift_im_msb;
    reg [4:0] shift_im_lsb;
    reg [4:0] index_reg_re_msb[0:7];
    reg [4:0] index_reg_im_msb[0:7];
    reg [4:0] index_reg_re_lsb[0:7];
    reg [4:0] index_reg_im_lsb[0:7];
    wire signed [WIDTH_IN-1:0] reg_re_msb[0:7];
    wire signed [WIDTH_IN-1:0] reg_re_lsb[0:7];
    wire signed [WIDTH_IN-1:0] reg_im_msb[0:7];
    wire signed [WIDTH_IN-1:0] reg_im_lsb[0:7];

    reg signed [WIDTH_IN-13-1:0] r_reg_re_msb[0:7];
    reg signed [WIDTH_IN-13-1:0] r_reg_re_lsb[0:7];
    reg signed [WIDTH_IN-13-1:0] r_reg_im_msb[0:7];
    reg signed [WIDTH_IN-13-1:0] r_reg_im_lsb[0:7];
    reg ready_valid;
    reg out_valid;

    genvar k;
    for (k = 0; k < 8; k = k + 1) begin
        assign reg_re_msb[k] = din_i[8+k];
        assign reg_re_lsb[k] = din_i[k];
        assign index_reg_re_msb[k] = (reg_re_msb[k][23] != din_i[8+k][WIDTH_IN-1]) ? 0 :
        (reg_re_msb[k][22] != din_i[8+k][WIDTH_IN-1]) ? 1 :
        (reg_re_msb[k][21] != din_i[8+k][WIDTH_IN-1]) ? 2 :
        (reg_re_msb[k][20] != din_i[8+k][WIDTH_IN-1]) ? 3 :
        (reg_re_msb[k][19] != din_i[8+k][WIDTH_IN-1]) ? 4 :
        (reg_re_msb[k][18] != din_i[8+k][WIDTH_IN-1]) ? 5 :
        (reg_re_msb[k][17] != din_i[8+k][WIDTH_IN-1]) ? 6 :
        (reg_re_msb[k][16] != din_i[8+k][WIDTH_IN-1]) ? 7 :
        (reg_re_msb[k][15] != din_i[8+k][WIDTH_IN-1]) ? 8 :
        (reg_re_msb[k][14] != din_i[8+k][WIDTH_IN-1]) ? 9 :
        (reg_re_msb[k][13] != din_i[8+k][WIDTH_IN-1]) ? 10 : 
        (reg_re_msb[k][12] != din_i[8+k][WIDTH_IN-1]) ? 11 : 
        (reg_re_msb[k][11] != din_i[8+k][WIDTH_IN-1]) ? 12 : 
        (reg_re_msb[k][10] != din_i[8+k][WIDTH_IN-1]) ? 13 : 
        (reg_re_msb[k][9] != din_i[8+k][WIDTH_IN-1]) ? 14 : 
        (reg_re_msb[k][8] != din_i[8+k][WIDTH_IN-1]) ? 15 : 
        (reg_re_msb[k][7] != din_i[8+k][WIDTH_IN-1]) ? 16 : 
        (reg_re_msb[k][6] != din_i[8+k][WIDTH_IN-1]) ? 17 : 
        (reg_re_msb[k][5] != din_i[8+k][WIDTH_IN-1]) ? 18 : 
        (reg_re_msb[k][4] != din_i[8+k][WIDTH_IN-1]) ? 19 : 
        (reg_re_msb[k][3] != din_i[8+k][WIDTH_IN-1]) ? 20 : 
        (reg_re_msb[k][2] != din_i[8+k][WIDTH_IN-1]) ? 21 : 
        (reg_re_msb[k][1] != din_i[8+k][WIDTH_IN-1]) ? 22 : 
        (reg_re_msb[k][0] != din_i[8+k][WIDTH_IN-1]) ? 23 : 
        24;
        assign index_reg_re_lsb[k] = (reg_re_lsb[k][23] != din_i[k][WIDTH_IN-1]) ? 0 :
        (reg_re_lsb[k][22] != din_i[k][WIDTH_IN-1]) ? 1 :
        (reg_re_lsb[k][21] != din_i[k][WIDTH_IN-1]) ? 2 :
        (reg_re_lsb[k][20] != din_i[k][WIDTH_IN-1]) ? 3 :
        (reg_re_lsb[k][19] != din_i[k][WIDTH_IN-1]) ? 4 :
        (reg_re_lsb[k][18] != din_i[k][WIDTH_IN-1]) ? 5 :
        (reg_re_lsb[k][17] != din_i[k][WIDTH_IN-1]) ? 6 :
        (reg_re_lsb[k][16] != din_i[k][WIDTH_IN-1]) ? 7 :
        (reg_re_lsb[k][15] != din_i[k][WIDTH_IN-1]) ? 8 :
        (reg_re_lsb[k][14] != din_i[k][WIDTH_IN-1]) ? 9 :
        (reg_re_lsb[k][13] != din_i[k][WIDTH_IN-1]) ? 10 : 
        (reg_re_lsb[k][12] != din_i[k][WIDTH_IN-1]) ? 11 : 
        (reg_re_lsb[k][11] != din_i[k][WIDTH_IN-1]) ? 12 : 
        (reg_re_lsb[k][10] != din_i[k][WIDTH_IN-1]) ? 13 : 
        (reg_re_lsb[k][9] != din_i[k][WIDTH_IN-1]) ? 14 : 
        (reg_re_lsb[k][8] != din_i[k][WIDTH_IN-1]) ? 15 : 
        (reg_re_lsb[k][7] != din_i[k][WIDTH_IN-1]) ? 16 : 
        (reg_re_lsb[k][6] != din_i[k][WIDTH_IN-1]) ? 17 : 
        (reg_re_lsb[k][5] != din_i[k][WIDTH_IN-1]) ? 18 : 
        (reg_re_lsb[k][4] != din_i[k][WIDTH_IN-1]) ? 19 : 
        (reg_re_lsb[k][3] != din_i[k][WIDTH_IN-1]) ? 20 : 
        (reg_re_lsb[k][2] != din_i[k][WIDTH_IN-1]) ? 21 : 
        (reg_re_lsb[k][1] != din_i[k][WIDTH_IN-1]) ? 22 : 
        (reg_re_lsb[k][0] != din_i[k][WIDTH_IN-1]) ? 23 : 
        24;
    end

    for (k = 0; k < 8; k = k + 1) begin
        assign reg_im_msb[k] = din_q[8+k];
        assign reg_im_lsb[k] = din_q[k];
        assign index_reg_im_msb[k] = (reg_im_msb[k][23] != din_q[8+k][WIDTH_IN-1]) ? 0 :
        (reg_im_msb[k][22] != din_q[8+k][WIDTH_IN-1]) ? 1 :
        (reg_im_msb[k][21] != din_q[8+k][WIDTH_IN-1]) ? 2 :
        (reg_im_msb[k][20] != din_q[8+k][WIDTH_IN-1]) ? 3 :
        (reg_im_msb[k][19] != din_q[8+k][WIDTH_IN-1]) ? 4 :
        (reg_im_msb[k][18] != din_q[8+k][WIDTH_IN-1]) ? 5 :
        (reg_im_msb[k][17] != din_q[8+k][WIDTH_IN-1]) ? 6 :
        (reg_im_msb[k][16] != din_q[8+k][WIDTH_IN-1]) ? 7 :
        (reg_im_msb[k][15] != din_q[8+k][WIDTH_IN-1]) ? 8 :
        (reg_im_msb[k][14] != din_q[8+k][WIDTH_IN-1]) ? 9 :
        (reg_im_msb[k][13] != din_q[8+k][WIDTH_IN-1]) ? 10 : 
        (reg_im_msb[k][12] != din_q[8+k][WIDTH_IN-1]) ? 11 : 
        (reg_im_msb[k][11] != din_q[8+k][WIDTH_IN-1]) ? 12 : 
        (reg_im_msb[k][10] != din_q[8+k][WIDTH_IN-1]) ? 13 : 
        (reg_im_msb[k][9] != din_q[8+k][WIDTH_IN-1]) ? 14 : 
        (reg_im_msb[k][8] != din_q[8+k][WIDTH_IN-1]) ? 15 : 
        (reg_im_msb[k][7] != din_q[8+k][WIDTH_IN-1]) ? 16 : 
        (reg_im_msb[k][6] != din_q[8+k][WIDTH_IN-1]) ? 17 : 
        (reg_im_msb[k][5] != din_q[8+k][WIDTH_IN-1]) ? 18 : 
        (reg_im_msb[k][4] != din_q[8+k][WIDTH_IN-1]) ? 19 : 
        (reg_im_msb[k][3] != din_q[8+k][WIDTH_IN-1]) ? 20 : 
        (reg_im_msb[k][2] != din_q[8+k][WIDTH_IN-1]) ? 21 : 
        (reg_im_msb[k][1] != din_q[8+k][WIDTH_IN-1]) ? 22 : 
        (reg_im_msb[k][0] != din_q[8+k][WIDTH_IN-1]) ? 23 : 
        24;
        assign index_reg_im_lsb[k] = (reg_im_lsb[k][23] != din_q[k][WIDTH_IN-1]) ? 0 :
        (reg_im_lsb[k][22] != din_q[k][WIDTH_IN-1]) ? 1 :
        (reg_im_lsb[k][21] != din_q[k][WIDTH_IN-1]) ? 2 :
        (reg_im_lsb[k][20] != din_q[k][WIDTH_IN-1]) ? 3 :
        (reg_im_lsb[k][19] != din_q[k][WIDTH_IN-1]) ? 4 :
        (reg_im_lsb[k][18] != din_q[k][WIDTH_IN-1]) ? 5 :
        (reg_im_lsb[k][17] != din_q[k][WIDTH_IN-1]) ? 6 :
        (reg_im_lsb[k][16] != din_q[k][WIDTH_IN-1]) ? 7 :
        (reg_im_lsb[k][15] != din_q[k][WIDTH_IN-1]) ? 8 :
        (reg_im_lsb[k][14] != din_q[k][WIDTH_IN-1]) ? 9 :
        (reg_im_lsb[k][13] != din_q[k][WIDTH_IN-1]) ? 10 : 
        (reg_im_lsb[k][12] != din_q[k][WIDTH_IN-1]) ? 11 : 
        (reg_im_lsb[k][11] != din_q[k][WIDTH_IN-1]) ? 12 : 
        (reg_im_lsb[k][10] != din_q[k][WIDTH_IN-1]) ? 13 : 
        (reg_im_lsb[k][9] != din_q[k][WIDTH_IN-1]) ? 14 : 
        (reg_im_lsb[k][8] != din_q[k][WIDTH_IN-1]) ? 15 : 
        (reg_im_lsb[k][7] != din_q[k][WIDTH_IN-1]) ? 16 : 
        (reg_im_lsb[k][6] != din_q[k][WIDTH_IN-1]) ? 17 : 
        (reg_im_lsb[k][5] != din_q[k][WIDTH_IN-1]) ? 18 : 
        (reg_im_lsb[k][4] != din_q[k][WIDTH_IN-1]) ? 19 : 
        (reg_im_lsb[k][3] != din_q[k][WIDTH_IN-1]) ? 20 : 
        (reg_im_lsb[k][2] != din_q[k][WIDTH_IN-1]) ? 21 : 
        (reg_im_lsb[k][1] != din_q[k][WIDTH_IN-1]) ? 22 : 
        (reg_im_lsb[k][0] != din_q[k][WIDTH_IN-1]) ? 23 : 
        24;
    end

    wire [4:0] w_shift_re_msb[0:7];
    wire [4:0] w_shift_re_lsb[0:7];
    wire [4:0] w_shift_im_msb[0:7];
    wire [4:0] w_shift_im_lsb[0:7];

    integer i;

    // --- 타이밍 루프 수정된 부분 ---
    always @(*) begin
        // 루프 내에서 사용할 임시 변수 선언
        logic [4:0] min_re_msb;
        logic [4:0] min_re_lsb;
        logic [4:0] min_im_msb;
        logic [4:0] min_im_lsb;

        // 1. 임시 변수를 배열의 첫 번째 값으로 초기화
        min_re_msb = index_reg_re_msb[0];
        min_re_lsb = index_reg_re_lsb[0];
        min_im_msb = index_reg_im_msb[0];
        min_im_lsb = index_reg_im_lsb[0];

        // 2. for 루프에서는 임시 변수를 사용해 비교하고 업데이트
        for (i = 1; i < 8; i = i + 1) begin
            if (index_reg_re_msb[i] < min_re_msb)
                min_re_msb = index_reg_re_msb[i];

            if (index_reg_re_lsb[i] < min_re_lsb)
                min_re_lsb = index_reg_re_lsb[i];

            if (index_reg_im_msb[i] < min_im_msb)
                min_im_msb = index_reg_im_msb[i];

            if (index_reg_im_lsb[i] < min_im_lsb)
                min_im_lsb = index_reg_im_lsb[i];
        end

        // 3. 최종 결과를 실제 신호에 한 번만 할당
        shift_re_msb = min_re_msb;
        shift_re_lsb = min_re_lsb;
        shift_im_msb = min_im_msb;
        shift_im_lsb = min_im_lsb;
    end

    for (k = 0; k < 8; k = k + 1) begin
        assign w_shift_re_msb[k] = (shift_re_msb>=shift_im_msb) ? shift_im_msb : shift_re_msb;
        assign w_shift_re_lsb[k] = (shift_re_lsb>=shift_im_lsb) ? shift_im_lsb : shift_re_lsb;
        assign w_shift_im_msb[k] = (shift_im_msb>=shift_re_msb) ? shift_re_msb : shift_im_msb;
        assign w_shift_im_lsb[k] = (shift_im_lsb>=shift_re_lsb) ? shift_re_lsb : shift_im_lsb;
    end

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 8; i = i + 1) begin
                r_reg_re_msb[i] <= 0;
                r_reg_re_lsb[i] <= 0;
                r_reg_im_msb[i] <= 0;
                r_reg_im_lsb[i] <= 0;
            end
            cnt <= 0;
            out_valid <= 0;
            dout_valid <= 0;
            // <<< 초기화 로직 추가 시작
            // index_out 배열의 모든 요소를 0으로 리셋합니다.
            for (int j = 0; j < 512; j = j + 1) begin
                index_out[j] <= 5'd0;
            end
            // <<< 초기화 로직 추가 끝

        end else begin
            if (i_valid) begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (w_shift_re_msb[i] > 13) begin
                        r_reg_re_msb[i] <= ((reg_re_msb[i] <<< w_shift_re_msb[i]) >>> 13);
                    end else begin
                        r_reg_re_msb[i] <= (reg_re_msb[i] >>> (13 - w_shift_re_msb[i]));
                    end
                    if (w_shift_re_lsb[i] > 13) begin
                        r_reg_re_lsb[i] <= ((reg_re_lsb[i] <<< w_shift_re_lsb[i]) >>> 13);
                    end else begin
                        r_reg_re_lsb[i] <= (reg_re_lsb[i] >>> (13 - w_shift_re_lsb[i]));
                    end
                    if (w_shift_im_msb[i] > 13) begin
                        r_reg_im_msb[i] <= ((reg_im_msb[i] <<< w_shift_im_msb[i]) >>> 13);
                    end else begin
                        r_reg_im_msb[i] <= (reg_im_msb[i] >>> (13 - w_shift_im_msb[i]));
                    end
                    if (w_shift_im_lsb[i] > 13) begin
                        r_reg_im_lsb[i] <= ((reg_im_lsb[i] <<< w_shift_im_lsb[i]) >>> 13);
                    end else begin
                        r_reg_im_lsb[i] <= (reg_im_lsb[i] >>> (13 - w_shift_im_lsb[i]));
                    end
                end
                for(i = 7; i >=0; i=i-1)begin
                    index_out[(cnt*16)+i] <= w_shift_re_lsb[i];
                    index_out[(cnt*16)+8+i] <= w_shift_re_msb[i];
                end
                dout_valid <= 1;
                cnt <= cnt + 1;
                if (cnt >= 31) begin
                    out_valid <= 0;
                end
            end else begin
                dout_valid <= out_valid;
                cnt <= 0;
            end
        end
    end

    for (k = 0; k < 8; k = k + 1) begin
        assign dout_i[8+k] = r_reg_re_msb[k][11:0];
        assign dout_i[k]   = r_reg_re_lsb[k][11:0];
        assign dout_q[8+k] = r_reg_im_msb[k][11:0];
        assign dout_q[k]   = r_reg_im_lsb[k][11:0];
    end

endmodule