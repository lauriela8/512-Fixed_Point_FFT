`timescale 1ns / 1ps

module FFT_Fixed #(
    parameter WIDTH_IN  = 9,
    parameter WIDTH_OUT = 13,
    parameter ARRAY_IN  = 16,
    parameter ARRAY_BTF = 16
) (
    input clk,
    input rstn,
    input din_valid,
    input logic signed [WIDTH_IN-1:0] din_i[0:ARRAY_IN-1],  // 실수부
    input logic signed [WIDTH_IN-1:0] din_q[0:ARRAY_IN-1],  // 허수부
    output do_en,
    output logic signed [WIDTH_OUT-1:0] do_re[0:ARRAY_BTF-1],
    output logic signed [WIDTH_OUT-1:0] do_im[0:ARRAY_BTF-1]
);

    wire signed [10:0] shift_din10_i[0:15];
    wire signed [10:0] shift_din10_q[0:15];
    wire m0_do_en;

    wire signed [11:0] shift_din20_i[0:15];
    wire signed [11:0] shift_din20_q[0:15];
    wire m1_do_en;

    wire [4:0] index_out_0[0:511];
    wire [4:0] index_out_1[0:511];

    Bfy_Module_0 #(
        .WIDTH_IN (9),
        .WIDTH_OUT(11),
        .ARRAY_IN (16),
        .ARRAY_BTF(16)
    ) BFY_M0 (
        .clk(clk),
        .rstn(rstn),
        .din_valid(din_valid),
        .din_i(din_i),  // 실수부
        .din_q(din_q),  // 허수부
        .do_en(m0_do_en),
        .do_re(shift_din10_i),
        .do_im(shift_din10_q),
        .index_out(index_out_0)
    );

    Bfy_Module_1 #(
        .WIDTH_IN (11),
        .WIDTH_OUT(12),
        .ARRAY_IN (16),
        .ARRAY_BTF(16)
    ) BFY_M1 (
        .clk(clk),
        .rstn(rstn),
        .din_valid(m0_do_en),
        .din_i(shift_din10_i),  // 실수부
        .din_q(shift_din10_q),  // 허수부
        .do_en(m1_do_en),
        .do_re(shift_din20_i),
        .do_im(shift_din20_q),
        .index_out(index_out_1)
    );

    Bfy_Module_2 #(
        .WIDTH_IN (12),
        .WIDTH_OUT(13),
        .ARRAY_IN (16),
        .ARRAY_BTF(16)
    ) BFY_M2 (
        .clk(clk),
        .rstn(rstn),
        .din_valid(m1_do_en),
        .din_i(shift_din20_i),  // 실수부
        .din_q(shift_din20_q),  // 허수부
        .index_0(index_out_0),
        .index_1(index_out_1),
        .do_en(do_en),
        .do_re(do_re),
        .do_im(do_im)
    );

endmodule
