module fft_cbfp_0 #(
    parameter int WIDTH_IN  = 23,
    parameter int WIDTH_OUT = 11,
    parameter int ARRAY_IN  = 16
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
    reg [5:0] out_cnt;
    reg [4:0] shift_re[0:3];
    reg [4:0] shift_im[0:3];

    wire [4:0] index_reg_re[0:15];
    wire [4:0] index_reg_im[0:15];
    reg signed [WIDTH_IN-1:0] reg_re[0:63];
    reg signed [WIDTH_IN-1:0] reg_im[0:63];
    reg signed [WIDTH_IN-1:0] reg_re_1[0:63];
    reg signed [WIDTH_IN-1:0] reg_im_1[0:63];

    reg signed [WIDTH_IN-12-1:0] r_reg_re[0:63];
    reg signed [WIDTH_IN-12-1:0] r_reg_im[0:63];
    reg out_ready_valid;
    reg out_valid;

    integer i;
    genvar k;

    // [수정] Combinational Loop 해결을 위한 next 신호 선언
    logic [4:0] min_reg_re_next;
    logic [4:0] min_reg_im_next;

    reg   [4:0] min_reg_re;
    reg   [4:0] min_reg_im;

    // 입력 데이터를 4 클럭에 걸쳐 내부 메모리에 저장
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 64; i = i + 1) begin
                reg_re[i] <= '0;
                reg_im[i] <= '0;
            end
        end else if (i_valid) begin
            for (i = 0; i < 16; i = i + 1) begin
                reg_re[((cnt%4)*16)+i] <= din_i[i];
                reg_im[((cnt%4)*16)+i] <= din_q[i];
            end
        end
    end

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 64; i = i + 1) begin
                reg_re_1[i] <= '0;
                reg_im_1[i] <= '0;
            end
        end else begin
            reg_re_1 <= reg_re;
            reg_im_1 <= reg_im;
        end
    end

    // MSB와 다른 첫 비트의 위치를 찾아 index로 변환 (Priority Encoder)
    // 이 로직은 for-loop와 function으로 더 간결하게 만들 수 있습니다. (하단 추가 제안 참고)
    for (k = 0; k < 16; k = k + 1) begin
        assign index_reg_re[k] = (din_i[k][21] != din_i[k][WIDTH_IN-1]) ? 0 :
                                 (din_i[k][20] != din_i[k][WIDTH_IN-1]) ? 1 :
                                 (din_i[k][19] != din_i[k][WIDTH_IN-1]) ? 2 :
                                 (din_i[k][18] != din_i[k][WIDTH_IN-1]) ? 3 :
                                 (din_i[k][17] != din_i[k][WIDTH_IN-1]) ? 4 :
                                 (din_i[k][16] != din_i[k][WIDTH_IN-1]) ? 5 :
                                 (din_i[k][15] != din_i[k][WIDTH_IN-1]) ? 6 :
                                 (din_i[k][14] != din_i[k][WIDTH_IN-1]) ? 7 :
                                 (din_i[k][13] != din_i[k][WIDTH_IN-1]) ? 8 :
                                 (din_i[k][12] != din_i[k][WIDTH_IN-1]) ? 9 :
                                 (din_i[k][11] != din_i[k][WIDTH_IN-1]) ? 10 : 
                                 (din_i[k][10] != din_i[k][WIDTH_IN-1]) ? 11 : 
                                 (din_i[k][9] != din_i[k][WIDTH_IN-1]) ? 12 : 
                                 (din_i[k][8] != din_i[k][WIDTH_IN-1]) ? 13 : 
                                 (din_i[k][7] != din_i[k][WIDTH_IN-1]) ? 14 : 
                                 (din_i[k][6] != din_i[k][WIDTH_IN-1]) ? 15 : 
                                 (din_i[k][5] != din_i[k][WIDTH_IN-1]) ? 16 : 
                                 (din_i[k][4] != din_i[k][WIDTH_IN-1]) ? 17 : 
                                 (din_i[k][3] != din_i[k][WIDTH_IN-1]) ? 18 : 
                                 (din_i[k][2] != din_i[k][WIDTH_IN-1]) ? 19 : 
                                 (din_i[k][1] != din_i[k][WIDTH_IN-1]) ? 20 : 
                                 (din_i[k][0] != din_i[k][WIDTH_IN-1]) ? 21 :  
                                 22;
    end

    for (k = 0; k < 16; k = k + 1) begin
        assign index_reg_im[k] = (din_q[k][21] != din_q[k][WIDTH_IN-1]) ? 0 :
                                 (din_q[k][20] != din_q[k][WIDTH_IN-1]) ? 1 :
                                 (din_q[k][19] != din_q[k][WIDTH_IN-1]) ? 2 :
                                 (din_q[k][18] != din_q[k][WIDTH_IN-1]) ? 3 :
                                 (din_q[k][17] != din_q[k][WIDTH_IN-1]) ? 4 :
                                 (din_q[k][16] != din_q[k][WIDTH_IN-1]) ? 5 :
                                 (din_q[k][15] != din_q[k][WIDTH_IN-1]) ? 6 :
                                 (din_q[k][14] != din_q[k][WIDTH_IN-1]) ? 7 :
                                 (din_q[k][13] != din_q[k][WIDTH_IN-1]) ? 8 :
                                 (din_q[k][12] != din_q[k][WIDTH_IN-1]) ? 9 :
                                 (din_q[k][11] != din_q[k][WIDTH_IN-1]) ? 10 : 
                                 (din_q[k][10] != din_q[k][WIDTH_IN-1]) ? 11 : 
                                 (din_q[k][9] != din_q[k][WIDTH_IN-1]) ? 12 : 
                                 (din_q[k][8] != din_q[k][WIDTH_IN-1]) ? 13 : 
                                 (din_q[k][7] != din_q[k][WIDTH_IN-1]) ? 14 : 
                                 (din_q[k][6] != din_q[k][WIDTH_IN-1]) ? 15 : 
                                 (din_q[k][5] != din_q[k][WIDTH_IN-1]) ? 16 : 
                                 (din_q[k][4] != din_q[k][WIDTH_IN-1]) ? 17 : 
                                 (din_q[k][3] != din_q[k][WIDTH_IN-1]) ? 18 : 
                                 (din_q[k][2] != din_q[k][WIDTH_IN-1]) ? 19 : 
                                 (din_q[k][1] != din_q[k][WIDTH_IN-1]) ? 20 : 
                                 (din_q[k][0] != din_q[k][WIDTH_IN-1]) ? 21 :  
                                 22;
    end

    logic [4:0] level1_re[0:7];
    logic [4:0] level2_re[0:3];
    logic [4:0] level3_re[0:1];
    logic [4:0] min_re;

    logic [4:0] level1_im[0:7];
    logic [4:0] level2_im[0:3];
    logic [4:0] level3_im[0:1];
    logic [4:0] min_im;

    // 16개 입력 데이터 중 최소 index 값을 찾음
    always @(*) begin
        // Level 1: 8쌍 비교
        for (i = 0; i < 8; i++) begin
            level1_re[i] = (index_reg_re[2*i] < index_reg_re[2*i+1]) ? index_reg_re[2*i] : index_reg_re[2*i+1];
            level1_im[i] = (index_reg_im[2*i] < index_reg_im[2*i+1]) ? index_reg_im[2*i] : index_reg_im[2*i+1];
        end

        // Level 2: 4쌍 비교
        for (i = 0; i < 4; i++) begin
            level2_re[i] = (level1_re[2*i] < level1_re[2*i+1]) ? level1_re[2*i] : level1_re[2*i+1];
            level2_im[i] = (level1_im[2*i] < level1_im[2*i+1]) ? level1_im[2*i] : level1_im[2*i+1];
        end

        // Level 3: 2쌍 비교
        for (i = 0; i < 2; i++) begin
            level3_re[i] = (level2_re[2*i] < level2_re[2*i+1]) ? level2_re[2*i] : level2_re[2*i+1];
            level3_im[i] = (level2_im[2*i] < level2_im[2*i+1]) ? level2_im[2*i] : level2_im[2*i+1];
        end

        // Level 4: 최종 비교
        min_re = (level3_re[0] < level3_re[1]) ? level3_re[0] : level3_re[1];
        min_im = (level3_im[0] < level3_im[1]) ? level3_im[0] : level3_im[1];
    end

    always @(*) begin
        logic [4:0] temp_min_re;
        logic [4:0] temp_min_im;

        // Default assignment: 현재 상태 유지
        min_reg_re_next = min_reg_re;
        min_reg_im_next = min_reg_im;

        if ((cnt % 4) == 0) begin
            temp_min_re = shift_re[0];
            temp_min_im = shift_im[0];
            for (i = 1; i < 4; i = i + 1) begin
                if (shift_re[i] < temp_min_re) temp_min_re = shift_re[i];
                if (shift_im[i] < temp_min_im) temp_min_im = shift_im[i];
            end
            // 계산된 값을 _next 신호에 할당
            min_reg_re_next = temp_min_re;
            min_reg_im_next = temp_min_im;
        end
    end

    // [추가] Sequential Logic: 클럭에 맞춰 min_reg 값을 업데이트
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            min_reg_re <= '0;
            min_reg_im <= '0;
        end else begin
            min_reg_re <= min_reg_re_next;
            min_reg_im <= min_reg_im_next;
        end
    end


    // 공통 shift 값 계산
    wire [4:0] w_min_reg_re;
    assign w_min_reg_re = (min_reg_re < min_reg_im) ? min_reg_re : min_reg_im;
    // w_min_reg_im은 w_min_reg_re와 항상 같으므로 하나만 사용해도 무방합니다.

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin  // Active-low reset
            // 모든 shift_re/im 원소를 리셋
            for (
                int i = 0; i < 4; i++
            ) begin  // shift_re의 크기에 따라 루프 범위 조절
                shift_re[i] <= '0;
                shift_im[i] <= '0;
            end
        end else begin
            // cnt에 해당하는 인덱스만 업데이트
            shift_re[cnt[1:0]] <= min_re;
            shift_im[cnt[1:0]] <= min_im;
        end
    end

    // 메인 컨트롤 및 데이터 쉬프트 로직
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 64; i = i + 1) begin
                r_reg_re[i] <= '0;
                r_reg_im[i] <= '0;
            end
            for (i = 0; i < 512; i = i + 1) begin
                index_out[i] <= '0;
            end
            cnt <= '0;
            out_cnt <= '0;
            out_valid <= 1'b0;
            out_ready_valid <= 1'b0;
            dout_valid <= 1'b0;
        end else begin
            if (i_valid) begin
                if (cnt >= 4) begin
                    out_ready_valid <= 1'b1;
                end
                cnt <= cnt + 1;
            end else begin
                cnt <= 0;
            end
            if (out_ready_valid && (out_cnt < 32)) begin
                for (i = 0; i < 64; i = i + 1) begin
                    // 산술 쉬프트(>>>) 사용
                    r_reg_re[i] <= (reg_re_1[i] <<< w_min_reg_re) >>> 12;
                    r_reg_im[i] <= (reg_im_1[i] <<< w_min_reg_re) >>> 12; // im도 같은 값으로 쉬프트
                end

                if ((out_cnt == 1) || !((out_cnt - 1) % 4)) begin
                    for (
                        i = 0; i < 64; i = i + 1
                    ) begin  // 루프 방향 수정
                        index_out[(out_cnt-1)*16+i] <= w_min_reg_re;
                    end
                end

                dout_valid <= 1'b1;

                if (out_cnt >= 31) begin
                    out_valid <= 1'b0;
                end
                out_cnt <= out_cnt + 1;
            end else if (out_cnt >= 32) begin
                for (i = 0; i < 64; i = i + 1) begin  // 루프 방향 수정
                    index_out[(out_cnt-4)*16+i] <= w_min_reg_re;
                end
                dout_valid <= out_valid;
                out_ready_valid <= 1'b0;
                out_cnt <= 0;
            end else begin
                dout_valid <= 1'b0;
            end
        end
    end

    // 최종 출력
    for (k = 0; k < 16; k = k + 1) begin
        assign dout_i[k] = r_reg_re[(((out_cnt-1)%4)*16)+k];
        assign dout_q[k] = r_reg_im[(((out_cnt-1)%4)*16)+k];
    end

endmodule
