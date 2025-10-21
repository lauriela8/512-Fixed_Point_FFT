`timescale 1ns / 1ps

module Bfy_Module_0 #(
    parameter WIDTH_IN  = 9,
    parameter WIDTH_OUT = 11,
    parameter ARRAY_IN  = 16,
    parameter ARRAY_BTF = 16
) (
    input clk,
    input rstn,
    input din_valid,
    input logic signed [WIDTH_IN-1:0] din_i[0:ARRAY_IN-1],  // 실수부
    input logic signed [WIDTH_IN-1:0] din_q[0:ARRAY_IN-1],  // 허수부
    output logic do_en,
    output logic signed [WIDTH_OUT-1:0] do_re[0:ARRAY_BTF-1],
    output logic signed [WIDTH_OUT-1:0] do_im[0:ARRAY_BTF-1],
    output logic [4:0] index_out[0:511]
);

    reg signed [WIDTH_IN-1:0] shift_din00_i[0:255];
    reg signed [WIDTH_IN-1:0] shift_din00_q[0:255];

    reg signed [WIDTH_IN+1-1:0] shift_din01_i_add[0:127];
    reg signed [WIDTH_IN+1-1:0] shift_din01_i_sub[0:127];
    reg signed [WIDTH_IN+1-1:0] shift_din01_q_add[0:127];
    reg signed [WIDTH_IN+1-1:0] shift_din01_q_sub[0:127];

    reg signed [WIDTH_IN+1-1:0] shift_din01_i_add_delay[0:127];
    reg signed [WIDTH_IN+1-1:0] shift_din01_i_sub_delay[0:127];
    reg signed [WIDTH_IN+1-1:0] shift_din01_q_add_delay[0:127];
    reg signed [WIDTH_IN+1-1:0] shift_din01_q_sub_delay[0:127];

    reg signed [WIDTH_IN+2-1:0] shift_din02_i_add_1[0:63];
    reg signed [WIDTH_IN+2-1:0] shift_din02_i_sub_1[0:63];
    reg signed [WIDTH_IN+2-1:0] shift_din02_i_add_2[0:63];
    reg signed [WIDTH_IN+2-1:0] shift_din02_i_sub_2[0:63];
    reg signed [WIDTH_IN+2-1:0] shift_din02_q_add_1[0:63];
    reg signed [WIDTH_IN+2-1:0] shift_din02_q_sub_1[0:63];
    reg signed [WIDTH_IN+2-1:0] shift_din02_q_add_2[0:63];
    reg signed [WIDTH_IN+2-1:0] shift_din02_q_sub_2[0:63];

    reg signed [WIDTH_IN+13-1:0] shift_din02_i_add_1_fac[0:63];
    reg signed [WIDTH_IN+13-1:0] shift_din02_i_sub_1_fac[0:63];
    reg signed [WIDTH_IN+13-1:0] shift_din02_i_sub_2_fac[0:63];
    reg signed [WIDTH_IN+13-1:0] shift_din02_q_add_1_fac[0:63];
    reg signed [WIDTH_IN+13-1:0] shift_din02_q_sub_1_fac[0:63];
    reg signed [WIDTH_IN+13-1:0] shift_din02_q_sub_2_fac[0:63];

    reg signed [WIDTH_IN+4-1:0] shift_din10_i_add_1[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_i_sub_1[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_i_add_2[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_i_sub_2[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_i_add_3[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_i_sub_3[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_i_add_4[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_i_sub_4[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_q_add_1[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_q_sub_1[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_q_add_2[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_q_sub_2[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_q_add_3[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_q_sub_3[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_q_add_4[0:31];
    reg signed [WIDTH_IN+4-1:0] shift_din10_q_sub_4[0:31];

    reg signed [WIDTH_IN+14-1:0] shift_din10_i_cbfp[0:15];
    reg signed [WIDTH_IN+14-1:0] shift_din10_q_cbfp[0:15];

    reg [5:0] din_cnt;
    reg m00_valid;
    reg m01_valid;
    reg [5:0] m01_cnt;
    reg m01_ready_valid;
    reg cbfp_valid;

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

    wire signed [8:0] twf_m0_re[0:15];
    wire signed [8:0] twf_m0_im[0:15];

    reg signed [WIDTH_IN+13-1:0] shift_din02_i_1_fac[0:15];
    reg signed [WIDTH_IN+13-1:0] shift_din02_i_2_fac[0:15];
    reg signed [WIDTH_IN+13-1:0] shift_din02_q_1_fac[0:15];
    reg signed [WIDTH_IN+13-1:0] shift_din02_q_2_fac[0:15];
    wire signed [WIDTH_IN+13-1:0] w_shift_din02_i_1_fac[0:15];
    wire signed [WIDTH_IN+13-1:0] w_shift_din02_i_2_fac[0:15];
    wire signed [WIDTH_IN+13-1:0] w_shift_din02_q_1_fac[0:15];
    wire signed [WIDTH_IN+13-1:0] w_shift_din02_q_2_fac[0:15];

    wire [7:0] half;

    assign half = 8'b1000_0000;

    genvar k;
    for (k = 0; k < 16; k = k + 1) begin
        assign w_shift_din02_i_1_fac[k] = (shift_din02_i_1_fac[k] + half) >>> 8;
        assign w_shift_din02_i_2_fac[k] = (shift_din02_i_2_fac[k] + half) >>> 8;
        assign w_shift_din02_q_1_fac[k] = (shift_din02_q_1_fac[k] + half) >>> 8;
        assign w_shift_din02_q_2_fac[k] = (shift_din02_q_2_fac[k] + half) >>> 8;
    end

    for (k = 0; k < 16; k = k + 1) begin
        logic [8:0] addr;
        assign addr = (m01_cnt >= 6) ? ((m01_cnt - 6) * 16 + k) : 0;
        twf_m0 TWF_M0 (
            .clk(clk),
            .rstn(rstn),
            .addr(addr),
            .twf_m0_re(twf_m0_re[k]),
            .twf_m0_im(twf_m0_im[k])
        );
    end

    fft_cbfp_0 #(
        .WIDTH_IN (23),
        .WIDTH_OUT(11),
        .ARRAY_IN (16)
    ) CBFP (
        // System & Control Signals
        .clk(clk),
        .rst_n(rstn),
        .i_valid(cbfp_valid),

        // Input Data (1 Block in Parallel)
        .din_i(shift_din10_i_cbfp),
        .din_q(shift_din10_q_cbfp),

        // Output Data (1 Block in Parallel)
        .dout_valid(do_en),
        .dout_i(do_re),
        .dout_q(do_im),
        .index_out(index_out)
    );

    integer i, j;

    always @(posedge clk, negedge rstn) begin // 16클락동안 데이터 저장 및 신호 관리
        if (~rstn) begin
            din_cnt   <= 0;
            m00_valid <= 0;
            m01_valid <= 0;
            for (i = 255; i >= 0; i = i - 1) begin
                shift_din00_i[i] <= 0;
                shift_din00_q[i] <= 0;
            end
        end else begin
            if (din_valid) begin
                if (din_cnt < 16) begin
                    for (i = 255; i >= 16; i = i - 1) begin
                        shift_din00_i[i-16] <= shift_din00_i[i];
                        shift_din00_q[i-16] <= shift_din00_q[i];
                    end
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din00_i[240+i] <= din_i[i];
                        shift_din00_q[240+i] <= din_q[i];
                    end
                    if (din_cnt == 15) begin
                        m00_valid <= 1;
                    end
                end else if (din_cnt == 23) begin
                    m01_valid <= 1;
                end else if (din_cnt == 31) begin
                    m00_valid <= 0;
                    m01_valid <= 0;
                end
                din_cnt <= din_cnt + 1;
            end else begin
                m00_valid <= 0;
                m01_valid <= 0;
                din_cnt   <= 0;
            end
        end
    end

    always @(posedge clk, negedge rstn) begin
        if (~rstn) begin
            m01_ready_valid <= 0;
            for (i = 127; i >= 0; i = i - 1) begin
                shift_din01_i_add[i] <= 0;
                shift_din01_i_sub[i] <= 0;
                shift_din01_q_add[i] <= 0;
                shift_din01_q_sub[i] <= 0;
                shift_din01_i_add_delay[i] <= 0;
                shift_din01_i_sub_delay[i] <= 0;
                shift_din01_q_add_delay[i] <= 0;
                shift_din01_q_sub_delay[i] <= 0;
            end
        end else begin
            if ((din_cnt >= 16) & (din_cnt < 24)) begin
                for (i = 127; i >= 16; i = i - 1) begin
                    shift_din01_i_add[i-16] <= shift_din01_i_add[i];
                    shift_din01_i_sub[i-16] <= shift_din01_i_sub[i];
                    shift_din01_q_add[i-16] <= shift_din01_q_add[i];
                    shift_din01_q_sub[i-16] <= shift_din01_q_sub[i];
                end
                for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                    shift_din01_i_add[112+i] <= shift_din00_i[((din_cnt - 16) * ARRAY_IN) + i] + din_i[i];
                    shift_din01_i_sub[112+i] <= shift_din00_i[((din_cnt - 16) * ARRAY_IN) + i] - din_i[i];
                    shift_din01_q_add[112+i] <= shift_din00_q[((din_cnt - 16) * ARRAY_IN) + i] + din_q[i];
                    shift_din01_q_sub[112+i] <= shift_din00_q[((din_cnt - 16) * ARRAY_IN) + i] - din_q[i];
                end
                if (m01_cnt == 38) begin
                    m01_ready_valid <= 0;
                end
            end else if ((din_cnt >= 24) & (din_cnt < 32)) begin
                for (i = 127; i >= 16; i = i - 1) begin
                    shift_din01_i_add_delay[i-16] <= shift_din01_i_add_delay[i];
                    shift_din01_i_sub_delay[i-16] <= shift_din01_i_sub_delay[i];
                    shift_din01_q_add_delay[i-16] <= shift_din01_q_add_delay[i];
                    shift_din01_q_sub_delay[i-16] <= shift_din01_q_sub_delay[i];
                end
                for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                    shift_din01_i_add_delay[112+i] <= shift_din00_i[((din_cnt - 24) * ARRAY_IN + 128) + i] + din_i[i];
                    shift_din01_i_sub_delay[112+i] <= shift_din00_q[((din_cnt - 24) * ARRAY_IN + 128) + i] - din_q[i];
                    shift_din01_q_add_delay[112+i] <= shift_din00_q[((din_cnt - 24) * ARRAY_IN + 128) + i] + din_q[i];
                    shift_din01_q_sub_delay[112+i] <= -shift_din00_i[((din_cnt - 24) * ARRAY_IN + 128) + i] + din_i[i];
                end
                if (m01_cnt == 38) begin
                    m01_ready_valid <= 0;
                end else begin
                    m01_ready_valid <= 1;
                end
            end else if (m01_cnt == 38) begin
                m01_ready_valid <= 0;
            end
        end
    end

    always @(posedge clk, negedge rstn) begin
        if (~rstn) begin
            m01_cnt <= 0;
            // 리셋 시 모든 레지스터를 0으로 초기화합니다.
            for (i = 63; i >= 0; i = i - 1) begin
                shift_din02_i_add_1[i] <= 0;
                shift_din02_i_add_2[i] <= 0;
                shift_din02_q_add_1[i] <= 0;
                shift_din02_q_add_2[i] <= 0;
                shift_din02_i_sub_1[i] <= 0;
                shift_din02_i_sub_2[i] <= 0;
                shift_din02_q_sub_1[i] <= 0;
                shift_din02_q_sub_2[i] <= 0;
            end
        end else begin
            if (m01_ready_valid) begin
                if (m01_cnt < 4) begin
                    for (i = 63; i >= 16; i = i - 1) begin
                        shift_din02_i_add_1[i-16] <= shift_din02_i_add_1[i];
                        shift_din02_i_sub_1[i-16] <= shift_din02_i_sub_1[i];
                        shift_din02_q_add_1[i-16] <= shift_din02_q_add_1[i];
                        shift_din02_q_sub_1[i-16] <= shift_din02_q_sub_1[i];
                    end
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din02_i_add_1[48+i] <= shift_din01_i_add[m01_cnt * ARRAY_IN + i] + shift_din01_i_add_delay[112 + i];
                        shift_din02_i_sub_1[48+i] <= shift_din01_i_add[m01_cnt * ARRAY_IN + i] - shift_din01_i_add_delay[112 + i];
                        shift_din02_q_add_1[48+i] <= shift_din01_q_add[m01_cnt * ARRAY_IN + i] + shift_din01_q_add_delay[112 + i];
                        shift_din02_q_sub_1[48+i] <= shift_din01_q_add[m01_cnt * ARRAY_IN + i] - shift_din01_q_add_delay[112 + i];
                    end
                end else if (m01_cnt < 8) begin
                    for (i = 63; i >= 16; i = i - 1) begin
                        shift_din02_i_add_2[i-16] <= shift_din02_i_add_2[i];
                        shift_din02_i_sub_2[i-16] <= shift_din02_i_sub_2[i];
                        shift_din02_q_add_2[i-16] <= shift_din02_q_add_2[i];
                        shift_din02_q_sub_2[i-16] <= shift_din02_q_sub_2[i];
                    end
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din02_i_add_2[48+i] <= shift_din01_i_add[m01_cnt * ARRAY_IN + i] + shift_din01_i_add_delay[112 + i];
                        shift_din02_i_sub_2[48+i] <= shift_din01_i_add[m01_cnt * ARRAY_IN + i] - shift_din01_i_add_delay[112 + i];
                        shift_din02_q_add_2[48+i] <= shift_din01_q_add[m01_cnt * ARRAY_IN + i] + shift_din01_q_add_delay[112 + i];
                        shift_din02_q_sub_2[48+i] <= shift_din01_q_add[m01_cnt * ARRAY_IN + i] - shift_din01_q_add_delay[112 + i];
                    end
                end else if ((m01_cnt >= 16) & (m01_cnt < 20)) begin
                    for (i = 63; i >= 16; i = i - 1) begin
                        shift_din02_i_add_1[i-16] <= shift_din02_i_add_1[i];
                        shift_din02_i_sub_1[i-16] <= shift_din02_i_sub_1[i];
                        shift_din02_q_add_1[i-16] <= shift_din02_q_add_1[i];
                        shift_din02_q_sub_1[i-16] <= shift_din02_q_sub_1[i];
                    end
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din02_i_add_1[48+i] <= shift_din01_i_sub[(m01_cnt-16) * ARRAY_IN + i] + shift_din01_i_sub_delay[((m01_cnt - 16) * ARRAY_IN) + i];
                        shift_din02_i_sub_1[48+i] <= shift_din01_i_sub[(m01_cnt-16) * ARRAY_IN + i] - shift_din01_i_sub_delay[((m01_cnt - 16) * ARRAY_IN) + i];
                        shift_din02_q_add_1[48+i] <= shift_din01_q_sub[(m01_cnt-16) * ARRAY_IN + i] + shift_din01_q_sub_delay[((m01_cnt - 16) * ARRAY_IN) + i];
                        shift_din02_q_sub_1[48+i] <= shift_din01_q_sub[(m01_cnt-16) * ARRAY_IN + i] - shift_din01_q_sub_delay[((m01_cnt - 16) * ARRAY_IN) + i];
                    end
                end else if ((m01_cnt >= 20) & (m01_cnt < 24)) begin
                    for (i = 63; i >= 16; i = i - 1) begin
                        shift_din02_i_add_2[i-16] <= shift_din02_i_add_2[i];
                        shift_din02_i_sub_2[i-16] <= shift_din02_i_sub_2[i];
                        shift_din02_q_add_2[i-16] <= shift_din02_q_add_2[i];
                        shift_din02_q_sub_2[i-16] <= shift_din02_q_sub_2[i];
                    end
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din02_i_add_2[48+i] <= shift_din01_i_sub[((m01_cnt-20) * ARRAY_IN +64)+ i] + shift_din01_i_sub_delay[((m01_cnt - 20) * ARRAY_IN + 64) + i];
                        shift_din02_i_sub_2[48+i] <= shift_din01_i_sub[((m01_cnt-20) * ARRAY_IN +64)+ i] - shift_din01_i_sub_delay[((m01_cnt - 20) * ARRAY_IN + 64) + i];
                        shift_din02_q_add_2[48+i] <= shift_din01_q_sub[((m01_cnt-20) * ARRAY_IN +64)+ i] + shift_din01_q_sub_delay[((m01_cnt - 20) * ARRAY_IN + 64) + i];
                        shift_din02_q_sub_2[48+i] <= shift_din01_q_sub[((m01_cnt-20) * ARRAY_IN +64)+ i] - shift_din01_q_sub_delay[((m01_cnt - 20) * ARRAY_IN + 64) + i];
                    end
                end
                m01_cnt <= m01_cnt + 1;  // m01_cnt를 증가시킵니다.
            end else begin
                m01_cnt <= 0;
            end
        end
    end

    always @(posedge clk, negedge rstn) begin
        if (~rstn) begin
            for (i = 63; i >= 0; i = i - 1) begin
                shift_din02_i_add_1_fac[i] <= 0;
                shift_din02_q_add_1_fac[i] <= 0;
                shift_din02_i_sub_1_fac[i] <= 0;
                shift_din02_i_sub_2_fac[i] <= 0;
                shift_din02_q_sub_1_fac[i] <= 0;
                shift_din02_q_sub_2_fac[i] <= 0;
            end
            for (i = 15; i >= 0; i = i - 1) begin
                shift_din02_i_1_fac[i] <= 0;
                shift_din02_i_2_fac[i] <= 0;
                shift_din02_q_1_fac[i] <= 0;
                shift_din02_q_2_fac[i] <= 0;
            end
        end else begin

            if ((m01_cnt >= 1) && (m01_cnt < 5)) begin
                for (i = 63; i >= 16; i = i - 1) begin
                    shift_din02_i_add_1_fac[i-16] <= shift_din02_i_add_1_fac[i];
                    shift_din02_i_sub_1_fac[i-16] <= shift_din02_i_sub_1_fac[i];
                    shift_din02_q_add_1_fac[i-16] <= shift_din02_q_add_1_fac[i];
                    shift_din02_q_sub_1_fac[i-16] <= shift_din02_q_sub_1_fac[i];
                end
                for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                    shift_din02_i_add_1_fac[48+i] <= (shift_din02_i_add_1[48 + i]*fac8_1_re[0]) - (shift_din02_q_add_1[48 + i]*fac8_1_im[0]);
                    shift_din02_i_sub_1_fac[48+i] <= (shift_din02_i_sub_1[48 + i]*fac8_1_re[2]) - (shift_din02_q_sub_1[48 + i]*fac8_1_im[2]);
                    shift_din02_q_add_1_fac[48+i] <= (shift_din02_q_add_1[48 + i]*fac8_1_re[0]) + (shift_din02_i_add_1[48 + i]*fac8_1_im[0]);
                    shift_din02_q_sub_1_fac[48+i] <= (shift_din02_q_sub_1[48 + i]*fac8_1_re[2]) + (shift_din02_i_sub_1[48 + i]*fac8_1_im[2]);
                end
            end else if ((m01_cnt >= 5) && (m01_cnt < 9)) begin
                for (i = 63; i >= 16; i = i - 1) begin
                    shift_din02_i_sub_2_fac[i-16] <= shift_din02_i_sub_2_fac[i];
                    shift_din02_q_sub_2_fac[i-16] <= shift_din02_q_sub_2_fac[i];
                end
                for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                    shift_din02_i_2_fac[i] <= (shift_din02_i_add_2[48 + i]*fac8_1_re[1]) - (shift_din02_q_add_2[48 + i]*fac8_1_im[1]);
                    shift_din02_i_sub_2_fac[48+i] <= (shift_din02_i_sub_2[48 + i]*fac8_1_re[3]) - (shift_din02_q_sub_2[48 + i]*fac8_1_im[3]);
                    shift_din02_q_2_fac[i] <= (shift_din02_q_add_2[48 + i]*fac8_1_re[1]) + (shift_din02_i_add_2[48 + i]*fac8_1_im[1]);
                    shift_din02_q_sub_2_fac[48+i] <= (shift_din02_q_sub_2[48 + i]*fac8_1_re[3]) + (shift_din02_i_sub_2[48 + i]*fac8_1_im[3]);
                    shift_din02_i_1_fac[i] <= shift_din02_i_add_1_fac[(m01_cnt - 5) * 16 + i];
                    shift_din02_q_1_fac[i] <= shift_din02_q_add_1_fac[(m01_cnt - 5) * 16 + i];
                end
            end else if ((m01_cnt >= 13) && (m01_cnt < 17)) begin
                for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                    shift_din02_i_1_fac[i] <= shift_din02_i_sub_1_fac[(m01_cnt - 13) * 16 + i];
                    shift_din02_q_1_fac[i] <= shift_din02_q_sub_1_fac[(m01_cnt - 13) * 16 + i];
                    shift_din02_i_2_fac[i] <= shift_din02_i_sub_2_fac[(m01_cnt - 13) * 16 + i];
                    shift_din02_q_2_fac[i] <= shift_din02_q_sub_2_fac[(m01_cnt - 13) * 16 + i];
                end
            end else if ((m01_cnt >= 17) && (m01_cnt < 21)) begin
                for (i = 63; i >= 16; i = i - 1) begin
                    shift_din02_i_add_1_fac[i-16] <= shift_din02_i_add_1_fac[i];
                    shift_din02_i_sub_1_fac[i-16] <= shift_din02_i_sub_1_fac[i];
                    shift_din02_q_add_1_fac[i-16] <= shift_din02_q_add_1_fac[i];
                    shift_din02_q_sub_1_fac[i-16] <= shift_din02_q_sub_1_fac[i];
                end
                for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                    shift_din02_i_add_1_fac[48+i] <= (shift_din02_i_add_1[48 + i]*fac8_1_re[4]) - (shift_din02_q_add_1[48 + i]*fac8_1_im[4]);
                    shift_din02_i_sub_1_fac[48+i] <= (shift_din02_i_sub_1[48 + i]*fac8_1_re[6]) - (shift_din02_q_sub_1[48 + i]*fac8_1_im[6]);
                    shift_din02_q_add_1_fac[48+i] <= (shift_din02_q_add_1[48 + i]*fac8_1_re[4]) + (shift_din02_i_add_1[48 + i]*fac8_1_im[4]);
                    shift_din02_q_sub_1_fac[48+i] <= (shift_din02_q_sub_1[48 + i]*fac8_1_re[6]) + (shift_din02_i_sub_1[48 + i]*fac8_1_im[6]);
                end
            end else if ((m01_cnt >= 21) && (m01_cnt < 25)) begin
                for (i = 63; i >= 16; i = i - 1) begin
                    shift_din02_i_sub_2_fac[i-16] <= shift_din02_i_sub_2_fac[i];
                    shift_din02_q_sub_2_fac[i-16] <= shift_din02_q_sub_2_fac[i];
                end
                for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                    shift_din02_i_2_fac[i] <= (shift_din02_i_add_2[48 + i]*fac8_1_re[5]) - (shift_din02_q_add_2[48 + i]*fac8_1_im[5]);
                    shift_din02_i_sub_2_fac[48+i] <= (shift_din02_i_sub_2[48 + i]*fac8_1_re[7]) - (shift_din02_q_sub_2[48 + i]*fac8_1_im[7]);
                    shift_din02_q_2_fac[i] <= (shift_din02_q_add_2[48 + i]*fac8_1_re[5]) + (shift_din02_i_add_2[48 + i]*fac8_1_im[5]);
                    shift_din02_q_sub_2_fac[48+i] <= (shift_din02_q_sub_2[48 + i]*fac8_1_re[7]) + (shift_din02_i_sub_2[48 + i]*fac8_1_im[7]);
                    shift_din02_i_1_fac[i] <= shift_din02_i_add_1_fac[(m01_cnt - 21) * 16 + i];
                    shift_din02_q_1_fac[i] <= shift_din02_q_add_1_fac[(m01_cnt - 21) * 16 + i];
                end
            end else if ((m01_cnt >= 29) && (m01_cnt < 33)) begin
                for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                    shift_din02_i_1_fac[i] <= shift_din02_i_sub_1_fac[(m01_cnt - 29) * 16 + i];
                    shift_din02_q_1_fac[i] <= shift_din02_q_sub_1_fac[(m01_cnt - 29) * 16 + i];
                    shift_din02_i_2_fac[i] <= shift_din02_i_sub_2_fac[(m01_cnt - 29) * 16 + i];
                    shift_din02_q_2_fac[i] <= shift_din02_q_sub_2_fac[(m01_cnt - 29) * 16 + i];
                end
            end
        end
    end

    always @(posedge clk, negedge rstn) begin
        if (~rstn) begin
            for (i = 0; i < 32; i = i + 1) begin
                shift_din10_i_add_1[i] <= 0;
                shift_din10_i_sub_1[i] <= 0;
                shift_din10_q_add_1[i] <= 0;
                shift_din10_q_sub_1[i] <= 0;
                shift_din10_i_add_2[i] <= 0;
                shift_din10_i_sub_2[i] <= 0;
                shift_din10_q_add_2[i] <= 0;
                shift_din10_q_sub_2[i] <= 0;
                shift_din10_i_add_3[i] <= 0;
                shift_din10_i_sub_3[i] <= 0;
                shift_din10_q_add_3[i] <= 0;
                shift_din10_q_sub_3[i] <= 0;
                shift_din10_i_add_4[i] <= 0;
                shift_din10_i_sub_4[i] <= 0;
                shift_din10_q_add_4[i] <= 0;
                shift_din10_q_sub_4[i] <= 0;
            end
        end else begin
            case (m01_cnt)
                6, 7, 22, 23: begin
                    for (i = 31; i >= 16; i = i - 1) begin
                        shift_din10_i_add_1[i-16] <= shift_din10_i_add_1[i];
                        shift_din10_i_sub_1[i-16] <= shift_din10_i_sub_1[i];
                        shift_din10_q_add_1[i-16] <= shift_din10_q_add_1[i];
                        shift_din10_q_sub_1[i-16] <= shift_din10_q_sub_1[i];
                    end
                    for (i = 0; i < 16; i = i + 1) begin
                        shift_din10_i_add_1[16+i] <= w_shift_din02_i_1_fac[i] + w_shift_din02_i_2_fac[i];
                        shift_din10_i_sub_1[16+i] <= w_shift_din02_i_1_fac[i] - w_shift_din02_i_2_fac[i];
                        shift_din10_q_add_1[16+i] <= w_shift_din02_q_1_fac[i] + w_shift_din02_q_2_fac[i];
                        shift_din10_q_sub_1[16+i] <= w_shift_din02_q_1_fac[i] - w_shift_din02_q_2_fac[i];
                    end
                end
                8, 9, 24, 25: begin
                    for (i = 31; i >= 16; i = i - 1) begin
                        shift_din10_i_add_2[i-16] <= shift_din10_i_add_2[i];
                        shift_din10_i_sub_2[i-16] <= shift_din10_i_sub_2[i];
                        shift_din10_q_add_2[i-16] <= shift_din10_q_add_2[i];
                        shift_din10_q_sub_2[i-16] <= shift_din10_q_sub_2[i];
                    end
                    for (i = 0; i < 16; i = i + 1) begin
                        shift_din10_i_add_2[16+i] <= w_shift_din02_i_1_fac[i] + w_shift_din02_i_2_fac[i];
                        shift_din10_i_sub_2[16+i] <= w_shift_din02_i_1_fac[i] - w_shift_din02_i_2_fac[i];
                        shift_din10_q_add_2[16+i] <= w_shift_din02_q_1_fac[i] + w_shift_din02_q_2_fac[i];
                        shift_din10_q_sub_2[16+i] <= w_shift_din02_q_1_fac[i] - w_shift_din02_q_2_fac[i];
                    end
                end
                14, 15, 30, 31: begin
                    for (i = 31; i >= 16; i = i - 1) begin
                        shift_din10_i_add_3[i-16] <= shift_din10_i_add_3[i];
                        shift_din10_i_sub_3[i-16] <= shift_din10_i_sub_3[i];
                        shift_din10_q_add_3[i-16] <= shift_din10_q_add_3[i];
                        shift_din10_q_sub_3[i-16] <= shift_din10_q_sub_3[i];
                    end
                    for (i = 0; i < 16; i = i + 1) begin
                        shift_din10_i_add_3[16+i] <= w_shift_din02_i_1_fac[i] + w_shift_din02_i_2_fac[i];
                        shift_din10_i_sub_3[16+i] <= w_shift_din02_i_1_fac[i] - w_shift_din02_i_2_fac[i];
                        shift_din10_q_add_3[16+i] <= w_shift_din02_q_1_fac[i] + w_shift_din02_q_2_fac[i];
                        shift_din10_q_sub_3[16+i] <= w_shift_din02_q_1_fac[i] - w_shift_din02_q_2_fac[i];
                    end
                end
                16, 17, 32, 33: begin
                    for (i = 31; i >= 16; i = i - 1) begin
                        shift_din10_i_add_4[i-16] <= shift_din10_i_add_4[i];
                        shift_din10_i_sub_4[i-16] <= shift_din10_i_sub_4[i];
                        shift_din10_q_add_4[i-16] <= shift_din10_q_add_4[i];
                        shift_din10_q_sub_4[i-16] <= shift_din10_q_sub_4[i];
                    end
                    for (i = 0; i < 16; i = i + 1) begin
                        shift_din10_i_add_4[16+i] <= w_shift_din02_i_1_fac[i] + w_shift_din02_i_2_fac[i];
                        shift_din10_i_sub_4[16+i] <= w_shift_din02_i_1_fac[i] - w_shift_din02_i_2_fac[i];
                        shift_din10_q_add_4[16+i] <= w_shift_din02_q_1_fac[i] + w_shift_din02_q_2_fac[i];
                        shift_din10_q_sub_4[16+i] <= w_shift_din02_q_1_fac[i] - w_shift_din02_q_2_fac[i];
                    end
                end
                default: begin
                end
            endcase
        end
    end

    reg signed [WIDTH_IN+4-1:0] temp_src_i;
    reg signed [WIDTH_IN+4-1:0] temp_src_q;

    always @(posedge clk, negedge rstn) begin
        if (~rstn) begin
            for (i = 15; i >= 0; i = i - 1) begin
                shift_din10_i_cbfp[i] <= 0;
                shift_din10_q_cbfp[i] <= 0;
            end
            temp_src_i = 0;
            temp_src_q = 0;
            cbfp_valid <= 0;
        end else begin
            cbfp_valid <= 0;
            if ((m01_cnt >= 7) && (m01_cnt < 39)) begin
                cbfp_valid <= 1;
                for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                    case (m01_cnt)
                        7, 8, 23, 24: begin
                            temp_src_i = shift_din10_i_add_1[16+i];
                            temp_src_q = shift_din10_q_add_1[16+i];
                        end
                        9, 10, 25, 26: begin
                            temp_src_i = shift_din10_i_add_2[16+i];
                            temp_src_q = shift_din10_q_add_2[16+i];
                        end
                        11, 27: begin
                            temp_src_i = shift_din10_i_sub_1[i];
                            temp_src_q = shift_din10_q_sub_1[i];
                        end
                        12, 28: begin
                            temp_src_i = shift_din10_i_sub_1[16+i];
                            temp_src_q = shift_din10_q_sub_1[16+i];
                        end
                        13, 29: begin
                            temp_src_i = shift_din10_i_sub_2[i];
                            temp_src_q = shift_din10_q_sub_2[i];
                        end
                        14, 30: begin
                            temp_src_i = shift_din10_i_sub_2[16+i];
                            temp_src_q = shift_din10_q_sub_2[16+i];
                        end
                        15, 16, 31, 32: begin
                            temp_src_i = shift_din10_i_add_3[16+i];
                            temp_src_q = shift_din10_q_add_3[16+i];
                        end
                        17, 18, 33, 34: begin
                            temp_src_i = shift_din10_i_add_4[16+i];
                            temp_src_q = shift_din10_q_add_4[16+i];
                        end
                        19, 35: begin
                            temp_src_i = shift_din10_i_sub_3[i];
                            temp_src_q = shift_din10_q_sub_3[i];
                        end
                        20, 36: begin
                            temp_src_i = shift_din10_i_sub_3[16+i];
                            temp_src_q = shift_din10_q_sub_3[16+i];
                        end
                        21, 37: begin
                            temp_src_i = shift_din10_i_sub_4[i];
                            temp_src_q = shift_din10_q_sub_4[i];
                        end
                        22, 38: begin
                            temp_src_i = shift_din10_i_sub_4[16+i];
                            temp_src_q = shift_din10_q_sub_4[16+i];
                        end
                        default: begin
                            temp_src_i = 0;
                            temp_src_q = 0;
                        end
                    endcase
                    shift_din10_i_cbfp[i] <= (temp_src_i * twf_m0_re[i]) - (temp_src_q * twf_m0_im[i]);
                    shift_din10_q_cbfp[i] <= (temp_src_q * twf_m0_re[i]) + (temp_src_i * twf_m0_im[i]);
                end
            end
        end
    end


endmodule
