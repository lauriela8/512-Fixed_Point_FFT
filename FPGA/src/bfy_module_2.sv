`timescale 1ns / 1ps

module Bfy_Module_2 #(
    parameter WIDTH_IN  = 12,
    parameter WIDTH_OUT = 13,
    parameter ARRAY_IN  = 16,
    parameter ARRAY_BTF = 16
) (
    input clk,
    input rstn,
    input din_valid,
    input logic signed [WIDTH_IN-1:0] din_i[0:ARRAY_IN-1],  // 실수부
    input logic signed [WIDTH_IN-1:0] din_q[0:ARRAY_IN-1],  // 허수부
    input logic [4:0] index_0[0:511],
    input logic [4:0] index_1[0:511],
    output logic do_en,
    output logic signed [WIDTH_OUT-1:0] do_re[0:ARRAY_BTF-1],
    output logic signed [WIDTH_OUT-1:0] do_im[0:ARRAY_BTF-1]
);

    reg signed [WIDTH_IN+1-1:0] shift_din20_i_add_1[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_i_add_2[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_i_sub_1[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_i_sub_2[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_i_add_3[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_i_add_4[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_i_sub_3[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_i_sub_4[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_q_add_1[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_q_add_2[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_q_sub_1[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_q_sub_2[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_q_add_3[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_q_add_4[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_q_sub_3[0:1];
    reg signed [WIDTH_IN+1-1:0] shift_din20_q_sub_4[0:1];

    reg signed [WIDTH_IN+2-1:0] shift_din21_i_1[0:7];
    reg signed [WIDTH_IN+2-1:0] shift_din21_i_2[0:7];
    reg signed [WIDTH_IN+2-1:0] shift_din21_q_1[0:7];
    reg signed [WIDTH_IN+2-1:0] shift_din21_q_2[0:7];

    reg signed [WIDTH_IN+12-1:0] shift_din21_i_1_fac[0:7];
    reg signed [WIDTH_IN+12-1:0] shift_din21_i_2_fac[0:7];
    reg signed [WIDTH_IN+12-1:0] shift_din21_q_1_fac[0:7];
    reg signed [WIDTH_IN+12-1:0] shift_din21_q_2_fac[0:7];

    wire signed [WIDTH_IN+3-1:0] w_shift_din21_i_1_fac[0:7];
    wire signed [WIDTH_IN+3-1:0] w_shift_din21_i_2_fac[0:7];
    wire signed [WIDTH_IN+3-1:0] w_shift_din21_q_1_fac[0:7];
    wire signed [WIDTH_IN+3-1:0] w_shift_din21_q_2_fac[0:7];

    reg signed [WIDTH_IN+3-1:0] shift_din22_i[0:15];
    reg signed [WIDTH_IN+3-1:0] shift_din22_q[0:15];

    wire signed [WIDTH_IN+1 -1:0] bit_din_i[0:15];
    wire signed [WIDTH_IN+1 -1:0] bit_din_q[0:15];

    wire [5:0] index_2[0:511];

    reg [5:0] din_cnt;
    reg [5:0] m21_cnt;
    reg m21_ready_valid;
    reg cbfp_valid;
    reg bit_valid;

    wire signed [9:0] fac8_1_re[0:7];
    wire signed [9:0] fac8_1_im[0:7];

    assign fac8_1_re[0] = 256;
    assign fac8_1_re[1] = 256;
    assign fac8_1_re[2] = 256;
    assign fac8_1_re[3] = 0;
    assign fac8_1_re[4] = 256;
    assign fac8_1_re[5] = 181;
    assign fac8_1_re[6] = 256;
    assign fac8_1_re[7] = -181;

    assign fac8_1_im[0] = 0;
    assign fac8_1_im[1] = 0;
    assign fac8_1_im[2] = 0;
    assign fac8_1_im[3] = -256;
    assign fac8_1_im[4] = 0;
    assign fac8_1_im[5] = -181;
    assign fac8_1_im[6] = 0;
    assign fac8_1_im[7] = -181;

    wire [7:0] half;

    assign half = 8'b1000_0000;

    genvar k;
    for (k = 0; k <= 7; k = k + 1) begin
        assign w_shift_din21_i_1_fac[k] = (shift_din21_i_1_fac[k] + half) >>> 8;
        assign w_shift_din21_i_2_fac[k] = (shift_din21_i_2_fac[k] + half) >>> 8;
        assign w_shift_din21_q_1_fac[k] = (shift_din21_q_1_fac[k] + half) >>> 8;
        assign w_shift_din21_q_2_fac[k] = (shift_din21_q_2_fac[k] + half) >>> 8;
    end

    for (k = 0; k <= 511; k = k + 1) begin
        assign index_2[k] = index_0[k] + index_1[k];
    end

    for (k = 0; k <= 15; k = k + 1) begin
        assign bit_din_i[k] = ((m21_cnt >= 3)&(m21_cnt <35)) ? (index_2[(m21_cnt-3)*16+k] >= 23) ? 0 : ((index_2[(m21_cnt-3)*16+k] > 9) ?
        shift_din22_i[k] >>> (index_2[(m21_cnt-3)*16+k]-9) : shift_din22_i[k] <<< (9-index_2[(m21_cnt-3)*16+k])) : 0;
        assign bit_din_q[k] = ((m21_cnt >= 3)&(m21_cnt <35)) ? (index_2[(m21_cnt-3)*16+k] >= 23) ? 0 : ((index_2[(m21_cnt-3)*16+k] > 9) ? 
        shift_din22_q[k] >>> (index_2[(m21_cnt-3)*16+k]-9): shift_din22_q[k] <<< (9-index_2[(m21_cnt-3)*16+k])) : 0;
    end

    reversal #(
        .WIDTH_IN (13),
        .ARRAY_IN (16),
        .MAX_POINT(512)
    ) BIT_REVERSE (
        .clk (clk),
        .rstn(rstn),

        .din_valid(bit_valid),
        .din_i(bit_din_i),
        .din_q(bit_din_q),

        .do_en(do_en),
        .do_re(do_re),
        .do_im(do_im)
    );

    integer i, j;

    always @(posedge clk, negedge rstn) begin // 16클락동안 데이터 저장 및 신호 관리
        if (~rstn) begin
            din_cnt <= 0;
            for (i = 1; i >= 0; i = i - 1) begin
                shift_din20_i_add_1[i] <= 0;
                shift_din20_i_add_2[i] <= 0;
                shift_din20_i_sub_1[i] <= 0;
                shift_din20_i_sub_2[i] <= 0;
                shift_din20_i_add_3[i] <= 0;
                shift_din20_i_add_4[i] <= 0;
                shift_din20_i_sub_3[i] <= 0;
                shift_din20_i_sub_4[i] <= 0;
                shift_din20_q_add_1[i] <= 0;
                shift_din20_q_add_2[i] <= 0;
                shift_din20_q_sub_1[i] <= 0;
                shift_din20_q_sub_2[i] <= 0;
                shift_din20_q_add_3[i] <= 0;
                shift_din20_q_add_4[i] <= 0;
                shift_din20_q_sub_3[i] <= 0;
                shift_din20_q_sub_4[i] <= 0;
            end
            m21_ready_valid <= 0;
        end else begin
            if (din_valid) begin
                if ((din_cnt >= 0) & (din_cnt < 32)) begin
                    for (i = 0; i <= 1; i = i + 1) begin
                        shift_din20_i_add_1[i] <= din_i[i] + din_i[4+i];
                        shift_din20_i_add_2[i] <= din_i[2+i] + din_i[6+i];
                        shift_din20_i_add_3[i] <= din_i[8+i] + din_i[12+i];
                        shift_din20_i_add_4[i] <= din_i[10+i] + din_i[14+i];
                        shift_din20_i_sub_1[i] <= din_i[i] - din_i[4+i];
                        shift_din20_i_sub_2[i] <= din_q[2+i] - din_q[6+i];
                        shift_din20_i_sub_3[i] <= din_i[8+i] - din_i[12+i];
                        shift_din20_i_sub_4[i] <= din_q[10+i] - din_q[14+i];
                        shift_din20_q_add_1[i] <= din_q[i] + din_q[4+i];
                        shift_din20_q_add_2[i] <= din_q[2+i] + din_q[6+i];
                        shift_din20_q_add_3[i] <= din_q[8+i] + din_q[12+i];
                        shift_din20_q_add_4[i] <= din_q[10+i] + din_q[14+i];
                        shift_din20_q_sub_1[i] <= din_q[i] - din_q[4+i];
                        shift_din20_q_sub_2[i] <= -1*(din_i[2+i] - din_i[6+i]);
                        shift_din20_q_sub_3[i] <= din_q[8+i] - din_q[12+i];
                        shift_din20_q_sub_4[i] <= -1*(din_i[10+i] - din_i[14+i]);
                    end
                end
                if (din_cnt == 0) begin
                    m21_ready_valid <= 1;
                end
                din_cnt <= din_cnt + 1;
            end else if (m21_cnt >= 34) begin
                m21_ready_valid <= 0;
            end else begin
                din_cnt <= 0;
            end
        end
    end

    always @(posedge clk, negedge rstn) begin
        if (~rstn) begin
            for (i = 7; i >= 0; i = i - 1) begin
                shift_din21_i_1[i] <= 0;
                shift_din21_i_2[i] <= 0;
                shift_din21_q_1[i] <= 0;
                shift_din21_q_2[i] <= 0;
            end
            m21_cnt <= 0;
        end else begin
            if (m21_ready_valid) begin
                if ((m21_cnt >= 0) & (m21_cnt <= 31)) begin
                    shift_din21_i_1[0] <= shift_din20_i_add_1[0] + shift_din20_i_add_2[0];
                    shift_din21_i_1[1] <= shift_din20_i_add_1[1] + shift_din20_i_add_2[1];
                    shift_din21_i_1[2] <= shift_din20_i_add_1[0] - shift_din20_i_add_2[0];
                    shift_din21_i_1[3] <= shift_din20_i_add_1[1] - shift_din20_i_add_2[1];
                    shift_din21_i_1[4] <= shift_din20_i_sub_1[0] + shift_din20_i_sub_2[0];
                    shift_din21_i_1[5] <= shift_din20_i_sub_1[1] + shift_din20_i_sub_2[1];
                    shift_din21_i_1[6] <= shift_din20_i_sub_1[0] - shift_din20_i_sub_2[0];
                    shift_din21_i_1[7] <= shift_din20_i_sub_1[1] - shift_din20_i_sub_2[1];
                    shift_din21_i_2[0] <= shift_din20_i_add_3[0] + shift_din20_i_add_4[0];
                    shift_din21_i_2[1] <= shift_din20_i_add_3[1] + shift_din20_i_add_4[1];
                    shift_din21_i_2[2] <= shift_din20_i_add_3[0] - shift_din20_i_add_4[0];
                    shift_din21_i_2[3] <= shift_din20_i_add_3[1] - shift_din20_i_add_4[1];
                    shift_din21_i_2[4] <= shift_din20_i_sub_3[0] + shift_din20_i_sub_4[0];
                    shift_din21_i_2[5] <= shift_din20_i_sub_3[1] + shift_din20_i_sub_4[1];
                    shift_din21_i_2[6] <= shift_din20_i_sub_3[0] - shift_din20_i_sub_4[0];
                    shift_din21_i_2[7] <= shift_din20_i_sub_3[1] - shift_din20_i_sub_4[1];
                    shift_din21_q_1[0] <= shift_din20_q_add_1[0] + shift_din20_q_add_2[0];
                    shift_din21_q_1[1] <= shift_din20_q_add_1[1] + shift_din20_q_add_2[1];
                    shift_din21_q_1[2] <= shift_din20_q_add_1[0] - shift_din20_q_add_2[0];
                    shift_din21_q_1[3] <= shift_din20_q_add_1[1] - shift_din20_q_add_2[1];
                    shift_din21_q_1[4] <= shift_din20_q_sub_1[0] + shift_din20_q_sub_2[0];
                    shift_din21_q_1[5] <= shift_din20_q_sub_1[1] + shift_din20_q_sub_2[1];
                    shift_din21_q_1[6] <= shift_din20_q_sub_1[0] - shift_din20_q_sub_2[0];
                    shift_din21_q_1[7] <= shift_din20_q_sub_1[1] - shift_din20_q_sub_2[1];
                    shift_din21_q_2[0] <= shift_din20_q_add_3[0] + shift_din20_q_add_4[0];
                    shift_din21_q_2[1] <= shift_din20_q_add_3[1] + shift_din20_q_add_4[1];
                    shift_din21_q_2[2] <= shift_din20_q_add_3[0] - shift_din20_q_add_4[0];
                    shift_din21_q_2[3] <= shift_din20_q_add_3[1] - shift_din20_q_add_4[1];
                    shift_din21_q_2[4] <= shift_din20_q_sub_3[0] + shift_din20_q_sub_4[0];
                    shift_din21_q_2[5] <= shift_din20_q_sub_3[1] + shift_din20_q_sub_4[1];
                    shift_din21_q_2[6] <= shift_din20_q_sub_3[0] - shift_din20_q_sub_4[0];
                    shift_din21_q_2[7] <= shift_din20_q_sub_3[1] - shift_din20_q_sub_4[1];
                end
                m21_cnt <= m21_cnt + 1;
            end else begin
                m21_cnt <= 0;
            end
        end
    end

    always @(posedge clk, negedge rstn) begin
        if (~rstn) begin
            for (i = 7; i >= 0; i = i - 1) begin
                shift_din21_i_1_fac[i] <= 0;
                shift_din21_i_2_fac[i] <= 0;
                shift_din21_q_1_fac[i] <= 0;
                shift_din21_q_2_fac[i] <= 0;
            end
        end else begin
            if ((m21_cnt >= 1) & (m21_cnt <= 32)) begin
                shift_din21_i_1_fac[0] <= (shift_din21_i_1[0]*fac8_1_re[0]) - (shift_din21_q_1[0]*fac8_1_im[0]);
                shift_din21_i_1_fac[1] <= (shift_din21_i_1[1]*fac8_1_re[1]) - (shift_din21_q_1[1]*fac8_1_im[1]);
                shift_din21_i_1_fac[2] <= (shift_din21_i_1[2]*fac8_1_re[2]) - (shift_din21_q_1[2]*fac8_1_im[2]);
                shift_din21_i_1_fac[3] <= (shift_din21_i_1[3]*fac8_1_re[3]) - (shift_din21_q_1[3]*fac8_1_im[3]);
                shift_din21_i_1_fac[4] <= (shift_din21_i_1[4]*fac8_1_re[4]) - (shift_din21_q_1[4]*fac8_1_im[4]);
                shift_din21_i_1_fac[5] <= (shift_din21_i_1[5]*fac8_1_re[5]) - (shift_din21_q_1[5]*fac8_1_im[5]);
                shift_din21_i_1_fac[6] <= (shift_din21_i_1[6]*fac8_1_re[6]) - (shift_din21_q_1[6]*fac8_1_im[6]);
                shift_din21_i_1_fac[7] <= (shift_din21_i_1[7]*fac8_1_re[7]) - (shift_din21_q_1[7]*fac8_1_im[7]);
                shift_din21_i_2_fac[0] <= (shift_din21_i_2[0]*fac8_1_re[0]) - (shift_din21_q_2[0]*fac8_1_im[0]);
                shift_din21_i_2_fac[1] <= (shift_din21_i_2[1]*fac8_1_re[1]) - (shift_din21_q_2[1]*fac8_1_im[1]);
                shift_din21_i_2_fac[2] <= (shift_din21_i_2[2]*fac8_1_re[2]) - (shift_din21_q_2[2]*fac8_1_im[2]);
                shift_din21_i_2_fac[3] <= (shift_din21_i_2[3]*fac8_1_re[3]) - (shift_din21_q_2[3]*fac8_1_im[3]);
                shift_din21_i_2_fac[4] <= (shift_din21_i_2[4]*fac8_1_re[4]) - (shift_din21_q_2[4]*fac8_1_im[4]);
                shift_din21_i_2_fac[5] <= (shift_din21_i_2[5]*fac8_1_re[5]) - (shift_din21_q_2[5]*fac8_1_im[5]);
                shift_din21_i_2_fac[6] <= (shift_din21_i_2[6]*fac8_1_re[6]) - (shift_din21_q_2[6]*fac8_1_im[6]);
                shift_din21_i_2_fac[7] <= (shift_din21_i_2[7]*fac8_1_re[7]) - (shift_din21_q_2[7]*fac8_1_im[7]);
                shift_din21_q_1_fac[0] <= (shift_din21_q_1[0]*fac8_1_re[0]) + (shift_din21_i_1[0]*fac8_1_im[0]);
                shift_din21_q_1_fac[1] <= (shift_din21_q_1[1]*fac8_1_re[1]) + (shift_din21_i_1[1]*fac8_1_im[1]);
                shift_din21_q_1_fac[2] <= (shift_din21_q_1[2]*fac8_1_re[2]) + (shift_din21_i_1[2]*fac8_1_im[2]);
                shift_din21_q_1_fac[3] <= (shift_din21_q_1[3]*fac8_1_re[3]) + (shift_din21_i_1[3]*fac8_1_im[3]);
                shift_din21_q_1_fac[4] <= (shift_din21_q_1[4]*fac8_1_re[4]) + (shift_din21_i_1[4]*fac8_1_im[4]);
                shift_din21_q_1_fac[5] <= (shift_din21_q_1[5]*fac8_1_re[5]) + (shift_din21_i_1[5]*fac8_1_im[5]);
                shift_din21_q_1_fac[6] <= (shift_din21_q_1[6]*fac8_1_re[6]) + (shift_din21_i_1[6]*fac8_1_im[6]);
                shift_din21_q_1_fac[7] <= (shift_din21_q_1[7]*fac8_1_re[7]) + (shift_din21_i_1[7]*fac8_1_im[7]);
                shift_din21_q_2_fac[0] <= (shift_din21_q_2[0]*fac8_1_re[0]) + (shift_din21_i_2[0]*fac8_1_im[0]);
                shift_din21_q_2_fac[1] <= (shift_din21_q_2[1]*fac8_1_re[1]) + (shift_din21_i_2[1]*fac8_1_im[1]);
                shift_din21_q_2_fac[2] <= (shift_din21_q_2[2]*fac8_1_re[2]) + (shift_din21_i_2[2]*fac8_1_im[2]);
                shift_din21_q_2_fac[3] <= (shift_din21_q_2[3]*fac8_1_re[3]) + (shift_din21_i_2[3]*fac8_1_im[3]);
                shift_din21_q_2_fac[4] <= (shift_din21_q_2[4]*fac8_1_re[4]) + (shift_din21_i_2[4]*fac8_1_im[4]);
                shift_din21_q_2_fac[5] <= (shift_din21_q_2[5]*fac8_1_re[5]) + (shift_din21_i_2[5]*fac8_1_im[5]);
                shift_din21_q_2_fac[6] <= (shift_din21_q_2[6]*fac8_1_re[6]) + (shift_din21_i_2[6]*fac8_1_im[6]);
                shift_din21_q_2_fac[7] <= (shift_din21_q_2[7]*fac8_1_re[7]) + (shift_din21_i_2[7]*fac8_1_im[7]);
            end
        end
    end

    always @(posedge clk, negedge rstn) begin
        if (~rstn) begin
            for (i = 15; i >= 0; i = i - 1) begin
                shift_din22_i[i] <= 0;
                shift_din22_q[i] <= 0;
            end
            bit_valid <= 0;
        end else begin
            if ((m21_cnt >= 2) & (m21_cnt <= 33)) begin
                for (i = 0; i < 2; i = i + 1) begin
                    shift_din22_i[(i*4)] <= w_shift_din21_i_1_fac[(i*4)] + w_shift_din21_i_1_fac[(i*4)+1];
                    shift_din22_i[(i*4)+1] <= w_shift_din21_i_1_fac[(i*4)] - w_shift_din21_i_1_fac[(i*4)+1];
                    shift_din22_i[(i*4)+2] <= w_shift_din21_i_1_fac[(i*4)+2] + w_shift_din21_i_1_fac[(i*4)+3];
                    shift_din22_i[(i*4)+3] <= w_shift_din21_i_1_fac[(i*4)+2] - w_shift_din21_i_1_fac[(i*4)+3];
                    shift_din22_i[(i*4)+8] <= w_shift_din21_i_2_fac[(i*4)] + w_shift_din21_i_2_fac[(i*4)+1];
                    shift_din22_i[(i*4)+9] <= w_shift_din21_i_2_fac[(i*4)] - w_shift_din21_i_2_fac[(i*4)+1];
                    shift_din22_i[(i*4)+10] <= w_shift_din21_i_2_fac[(i*4)+2] + w_shift_din21_i_2_fac[(i*4)+3];
                    shift_din22_i[(i*4)+11] <= w_shift_din21_i_2_fac[(i*4)+2] - w_shift_din21_i_2_fac[(i*4)+3];
                    shift_din22_q[(i*4)] <= w_shift_din21_q_1_fac[(i*4)] + w_shift_din21_q_1_fac[(i*4)+1];
                    shift_din22_q[(i*4)+1] <= w_shift_din21_q_1_fac[(i*4)] - w_shift_din21_q_1_fac[(i*4)+1];
                    shift_din22_q[(i*4)+2] <= w_shift_din21_q_1_fac[(i*4)+2] + w_shift_din21_q_1_fac[(i*4)+3];
                    shift_din22_q[(i*4)+3] <= w_shift_din21_q_1_fac[(i*4)+2] - w_shift_din21_q_1_fac[(i*4)+3];
                    shift_din22_q[(i*4)+8] <= w_shift_din21_q_2_fac[(i*4)] + w_shift_din21_q_2_fac[(i*4)+1];
                    shift_din22_q[(i*4)+9] <= w_shift_din21_q_2_fac[(i*4)] - w_shift_din21_q_2_fac[(i*4)+1];
                    shift_din22_q[(i*4)+10] <= w_shift_din21_q_2_fac[(i*4)+2] + w_shift_din21_q_2_fac[(i*4)+3];
                    shift_din22_q[(i*4)+11] <= w_shift_din21_q_2_fac[(i*4)+2] - w_shift_din21_q_2_fac[(i*4)+3];
                end
                bit_valid <= 1;
            end else begin
                bit_valid <= 0;
            end
        end
    end

endmodule
