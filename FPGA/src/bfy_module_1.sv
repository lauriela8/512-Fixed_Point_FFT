`timescale 1ns / 1ps

module Bfy_Module_1 #(
    parameter WIDTH_IN  = 11,
    parameter WIDTH_OUT = 12,
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

    reg signed [WIDTH_IN-1:0] shift_din10_i[0:31];
    reg signed [WIDTH_IN-1:0] shift_din10_q[0:31];

    reg signed [WIDTH_IN:0] shift_din11_i_add_1[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_add_2[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_add_3[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_add_4[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_add_5[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_add_6[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_add_7[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_add_8[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_sub_1[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_sub_2[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_sub_3[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_sub_4[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_sub_5[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_sub_6[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_sub_7[0:15];
    reg signed [WIDTH_IN:0] shift_din11_i_sub_8[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_add_1[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_add_2[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_add_3[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_add_4[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_add_5[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_add_6[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_add_7[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_add_8[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_sub_1[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_sub_2[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_sub_3[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_sub_4[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_sub_5[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_sub_6[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_sub_7[0:15];
    reg signed [WIDTH_IN:0] shift_din11_q_sub_8[0:15];

    reg signed [WIDTH_IN+1:0] shift_din12_i_add_1[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_2[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_3[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_4[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_5[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_6[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_7[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_8[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_9[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_10[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_11[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_12[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_13[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_14[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_15[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_add_16[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_1[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_2[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_3[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_4[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_5[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_6[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_7[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_8[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_9[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_10[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_11[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_12[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_13[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_14[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_15[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_i_sub_16[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_1[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_2[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_3[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_4[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_5[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_6[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_7[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_8[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_9[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_10[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_11[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_12[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_13[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_14[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_15[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_add_16[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_1[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_2[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_3[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_4[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_5[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_6[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_7[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_8[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_9[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_10[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_11[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_12[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_13[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_14[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_15[0:7];
    reg signed [WIDTH_IN+1:0] shift_din12_q_sub_16[0:7];

    reg signed [WIDTH_IN+12:0] shift_din12_i_add_1_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_2_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_3_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_4_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_5_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_6_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_7_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_8_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_9_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_10_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_11_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_12_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_13_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_14_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_15_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_add_16_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_1_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_2_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_3_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_4_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_5_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_6_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_7_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_8_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_9_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_10_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_11_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_12_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_13_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_14_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_15_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_i_sub_16_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_1_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_2_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_3_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_4_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_5_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_6_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_7_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_8_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_9_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_10_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_11_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_12_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_13_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_14_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_15_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_add_16_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_1_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_2_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_3_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_4_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_5_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_6_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_7_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_8_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_9_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_10_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_11_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_12_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_13_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_14_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_15_fac[0:7];
    reg signed [WIDTH_IN+12:0] shift_din12_q_sub_16_fac[0:7];

    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_1_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_2_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_3_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_4_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_5_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_6_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_7_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_8_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_9_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_10_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_11_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_12_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_13_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_14_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_15_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_add_16_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_1_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_2_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_3_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_4_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_5_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_6_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_7_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_8_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_9_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_10_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_11_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_12_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_13_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_14_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_15_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_i_sub_16_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_1_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_2_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_3_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_4_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_5_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_6_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_7_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_8_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_9_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_10_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_11_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_12_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_13_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_14_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_15_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_add_16_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_1_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_2_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_3_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_4_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_5_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_6_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_7_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_8_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_9_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_10_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_11_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_12_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_13_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_14_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_15_fac[0:7];
    wire signed [WIDTH_IN+2:0] w_shift_din12_q_sub_16_fac[0:7];

    reg signed [WIDTH_IN+3:0] shift_din20_i_add_1[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_2[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_3[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_4[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_5[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_6[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_7[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_8[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_9[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_10[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_11[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_12[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_13[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_14[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_15[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_16[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_1[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_2[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_3[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_4[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_5[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_6[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_7[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_8[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_9[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_10[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_11[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_12[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_13[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_14[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_15[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_16[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_17[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_18[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_19[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_20[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_21[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_22[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_23[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_24[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_25[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_26[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_27[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_28[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_29[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_30[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_31[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_add_32[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_17[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_18[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_19[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_20[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_21[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_22[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_23[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_24[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_25[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_26[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_27[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_28[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_29[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_30[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_31[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_i_sub_32[0:3];

    reg signed [WIDTH_IN+3:0] shift_din20_q_add_1[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_2[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_3[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_4[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_5[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_6[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_7[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_8[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_9[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_10[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_11[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_12[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_13[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_14[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_15[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_16[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_1[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_2[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_3[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_4[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_5[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_6[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_7[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_8[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_9[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_10[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_11[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_12[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_13[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_14[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_15[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_16[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_17[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_18[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_19[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_20[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_21[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_22[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_23[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_24[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_25[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_26[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_27[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_28[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_29[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_30[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_31[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_add_32[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_17[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_18[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_19[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_20[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_21[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_22[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_23[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_24[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_25[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_26[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_27[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_28[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_29[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_30[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_31[0:3];
    reg signed [WIDTH_IN+3:0] shift_din20_q_sub_32[0:3];

    reg signed [WIDTH_IN+14-1:0] shift_din20_i_cbfp[0:15];
    reg signed [WIDTH_IN+14-1:0] shift_din20_q_cbfp[0:15];

    reg [5:0] din_cnt;
    reg m10_valid;
    reg m11_valid;
    reg m12_valid;
    reg [5:0] m10_cnt;
    reg m11_ready_valid;
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

    wire signed [8:0] twf_m1_re[0:15];
    wire signed [8:0] twf_m1_im[0:15];

    wire [7:0] half;

    assign half = 8'b1000_0000;

    genvar k;
    for (k = 0; k <= 7; k = k + 1) begin
        assign w_shift_din12_i_add_1_fac[k] = (shift_din12_i_add_1_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_1_fac[k] = (shift_din12_i_sub_1_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_1_fac[k] = (shift_din12_q_add_1_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_1_fac[k] = (shift_din12_q_sub_1_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_2_fac[k] = (shift_din12_i_add_2_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_2_fac[k] = (shift_din12_i_sub_2_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_2_fac[k] = (shift_din12_q_add_2_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_2_fac[k] = (shift_din12_q_sub_2_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_3_fac[k] = (shift_din12_i_add_3_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_3_fac[k] = (shift_din12_i_sub_3_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_3_fac[k] = (shift_din12_q_add_3_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_3_fac[k] = (shift_din12_q_sub_3_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_4_fac[k] = (shift_din12_i_add_4_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_4_fac[k] = (shift_din12_i_sub_4_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_4_fac[k] = (shift_din12_q_add_4_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_4_fac[k] = (shift_din12_q_sub_4_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_5_fac[k] = (shift_din12_i_add_5_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_5_fac[k] = (shift_din12_i_sub_5_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_5_fac[k] = (shift_din12_q_add_5_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_5_fac[k] = (shift_din12_q_sub_5_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_6_fac[k] = (shift_din12_i_add_6_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_6_fac[k] = (shift_din12_i_sub_6_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_6_fac[k] = (shift_din12_q_add_6_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_6_fac[k] = (shift_din12_q_sub_6_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_7_fac[k] = (shift_din12_i_add_7_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_7_fac[k] = (shift_din12_i_sub_7_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_7_fac[k] = (shift_din12_q_add_7_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_7_fac[k] = (shift_din12_q_sub_7_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_8_fac[k] = (shift_din12_i_add_8_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_8_fac[k] = (shift_din12_i_sub_8_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_8_fac[k] = (shift_din12_q_add_8_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_8_fac[k] = (shift_din12_q_sub_8_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_9_fac[k] = (shift_din12_i_add_9_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_9_fac[k] = (shift_din12_i_sub_9_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_9_fac[k] = (shift_din12_q_add_9_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_9_fac[k] = (shift_din12_q_sub_9_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_10_fac[k] = (shift_din12_i_add_10_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_10_fac[k] = (shift_din12_i_sub_10_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_10_fac[k] = (shift_din12_q_add_10_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_10_fac[k] = (shift_din12_q_sub_10_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_11_fac[k] = (shift_din12_i_add_11_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_11_fac[k] = (shift_din12_i_sub_11_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_11_fac[k] = (shift_din12_q_add_11_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_11_fac[k] = (shift_din12_q_sub_11_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_12_fac[k] = (shift_din12_i_add_12_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_12_fac[k] = (shift_din12_i_sub_12_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_12_fac[k] = (shift_din12_q_add_12_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_12_fac[k] = (shift_din12_q_sub_12_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_13_fac[k] = (shift_din12_i_add_13_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_13_fac[k] = (shift_din12_i_sub_13_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_13_fac[k] = (shift_din12_q_add_13_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_13_fac[k] = (shift_din12_q_sub_13_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_14_fac[k] = (shift_din12_i_add_14_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_14_fac[k] = (shift_din12_i_sub_14_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_14_fac[k] = (shift_din12_q_add_14_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_14_fac[k] = (shift_din12_q_sub_14_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_15_fac[k] = (shift_din12_i_add_15_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_15_fac[k] = (shift_din12_i_sub_15_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_15_fac[k] = (shift_din12_q_add_15_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_15_fac[k] = (shift_din12_q_sub_15_fac[k] + half)>>>8;
        assign w_shift_din12_i_add_16_fac[k] = (shift_din12_i_add_16_fac[k] + half)>>>8;
        assign w_shift_din12_i_sub_16_fac[k] = (shift_din12_i_sub_16_fac[k] + half)>>>8;
        assign w_shift_din12_q_add_16_fac[k] = (shift_din12_q_add_16_fac[k] + half)>>>8;
        assign w_shift_din12_q_sub_16_fac[k] = (shift_din12_q_sub_16_fac[k] + half)>>>8;
    end

    for (k = 0; k < 16; k = k + 1) begin
        logic [5:0] addr;
        assign addr = (m10_cnt >= 4) ? ((m10_cnt - 4) * 16 + k) : 0;
        twf_m1 TWF_M1 (
            .clk(clk),
            .rstn(rstn),
            .addr(addr),
            .twf_m1_re(twf_m1_re[k]),
            .twf_m1_im(twf_m1_im[k])
        );
    end

    wire signed [11:0] shift_din20_i[0:15];
    wire signed [11:0] shift_din20_q[0:15];
    wire cbfp_out_valid;

    fft_cbfp_1 #(
        .WIDTH_IN (25),
        .WIDTH_OUT(12),
        .ARRAY_IN (16)
    ) CBFP_1 (
        // System & Control Signals
        .clk(clk),
        .rst_n(rstn),
        .i_valid(cbfp_valid),

        // Input Data (1 Block in Parallel)
        .din_i(shift_din20_i_cbfp),
        .din_q(shift_din20_q_cbfp),

        // Output Data (1 Block in Parallel)
        .dout_valid(cbfp_out_valid),
        .dout_i(shift_din20_i),
        .dout_q(shift_din20_q),
        .index_out(index_out)
    );


    assign do_en = cbfp_out_valid;
    assign do_re = shift_din20_i;
    assign do_im = shift_din20_q;

    integer i, j;

    always @(posedge clk, negedge rstn) begin // 16클락동안 데이터 저장 및 신호 관리
        if (~rstn) begin
            din_cnt <= 0;
            m10_valid <= 0;
            m11_valid <= 0;
            m12_valid <= 0;
            m11_ready_valid <= 0;
            for (i = 31; i >= 0; i = i - 1) begin
                shift_din10_i[i] <= 0;
                shift_din10_q[i] <= 0;
            end
        end else begin
            if (din_valid) begin
                if ((din_cnt < 2) | ((din_cnt >= 4) & (din_cnt < 6)) | ((din_cnt >= 8) & (din_cnt < 10))
                 | ((din_cnt >= 12) & (din_cnt < 14)) | ((din_cnt >= 16) & (din_cnt < 18)) | ((din_cnt >= 20) & (din_cnt < 22))
                 | ((din_cnt >= 24) & (din_cnt < 26)) | ((din_cnt >= 28) & (din_cnt < 30))) begin
                    for (i = 31; i >= 16; i = i - 1) begin
                        shift_din10_i[i-16] <= shift_din10_i[i];
                        shift_din10_q[i-16] <= shift_din10_q[i];
                    end
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din10_i[16+i] <= din_i[i];
                        shift_din10_q[16+i] <= din_q[i];
                    end
                    if (din_cnt == 4) begin
                        m12_valid <= 1;
                    end else if (din_cnt == 1) begin
                        m10_valid <= 1;
                    end
                end
                din_cnt <= din_cnt + 1;
                if (m10_cnt == 38) begin
                    m10_valid <= 0;
                end
            end else if (m10_cnt == 38) begin
                m10_valid <= 0;
            end else begin
                din_cnt   <= 0;
                m11_valid <= 0;
                m12_valid <= 0;
            end
        end
    end

    always @(posedge clk, negedge rstn) begin // 0_0step 계산 저장 및 연산
        if (~rstn) begin
            for (i = 15; i >= 0; i = i - 1) begin
                shift_din11_i_add_1[i] <= 0;
                shift_din11_i_sub_1[i] <= 0;
                shift_din11_q_add_1[i] <= 0;
                shift_din11_q_sub_1[i] <= 0;
                shift_din11_i_add_2[i] <= 0;
                shift_din11_i_sub_2[i] <= 0;
                shift_din11_q_add_2[i] <= 0;
                shift_din11_q_sub_2[i] <= 0;
                shift_din11_i_add_3[i] <= 0;
                shift_din11_i_sub_3[i] <= 0;
                shift_din11_q_add_3[i] <= 0;
                shift_din11_q_sub_3[i] <= 0;
                shift_din11_i_add_4[i] <= 0;
                shift_din11_i_sub_4[i] <= 0;
                shift_din11_q_add_4[i] <= 0;
                shift_din11_q_sub_4[i] <= 0;
                shift_din11_i_add_5[i] <= 0;
                shift_din11_i_sub_5[i] <= 0;
                shift_din11_q_add_5[i] <= 0;
                shift_din11_q_sub_5[i] <= 0;
                shift_din11_i_add_6[i] <= 0;
                shift_din11_i_sub_6[i] <= 0;
                shift_din11_q_add_6[i] <= 0;
                shift_din11_q_sub_6[i] <= 0;
                shift_din11_i_add_7[i] <= 0;
                shift_din11_i_sub_7[i] <= 0;
                shift_din11_q_add_7[i] <= 0;
                shift_din11_q_sub_7[i] <= 0;
                shift_din11_i_add_8[i] <= 0;
                shift_din11_i_sub_8[i] <= 0;
                shift_din11_q_add_8[i] <= 0;
                shift_din11_q_sub_8[i] <= 0;
            end
            m10_cnt <= 0;
        end else begin
            if (m10_valid) begin
                if (din_cnt == 2) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_1[i] <= shift_din10_i[(din_cnt - 2)*16 + i] + din_i[i];
                        shift_din11_i_sub_1[i] <= shift_din10_i[(din_cnt - 2)*16 + i] - din_i[i];
                        shift_din11_q_add_1[i] <= shift_din10_q[(din_cnt - 2)*16 + i] + din_q[i];
                        shift_din11_q_sub_1[i] <= shift_din10_q[(din_cnt - 2)*16 + i] - din_q[i];
                    end
                end else if (din_cnt == 3) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_2[i] <= shift_din10_i[(din_cnt - 2)*16 + i] + din_i[i];
                        shift_din11_i_sub_2[i] <= shift_din10_q[(din_cnt - 2)*16 + i] - din_q[i];
                        shift_din11_q_add_2[i] <= shift_din10_q[(din_cnt - 2)*16 + i] + din_q[i];
                        shift_din11_q_sub_2[i] <= -1*(shift_din10_i[(din_cnt - 2)*16 + i] - din_i[i]);
                    end
                end else if (din_cnt == 6) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_3[i] <= shift_din10_i[(din_cnt - 6)*16 + i] + din_i[i];
                        shift_din11_i_sub_3[i] <= shift_din10_i[(din_cnt - 6)*16 + i] - din_i[i];
                        shift_din11_q_add_3[i] <= shift_din10_q[(din_cnt - 6)*16 + i] + din_q[i];
                        shift_din11_q_sub_3[i] <= shift_din10_q[(din_cnt - 6)*16 + i] - din_q[i];
                    end
                end else if (din_cnt == 7) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_4[i] <= shift_din10_i[(din_cnt - 6)*16 + i] + din_i[i];
                        shift_din11_i_sub_4[i] <= shift_din10_q[(din_cnt - 6)*16 + i] - din_q[i];
                        shift_din11_q_add_4[i] <= shift_din10_q[(din_cnt - 6)*16 + i] + din_q[i];
                        shift_din11_q_sub_4[i] <= -1*(shift_din10_i[(din_cnt - 6)*16 + i] - din_i[i]);
                    end
                end else if (din_cnt == 10) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_5[i] <= shift_din10_i[(din_cnt - 10)*16 + i] + din_i[i];
                        shift_din11_i_sub_5[i] <= shift_din10_i[(din_cnt - 10)*16 + i] - din_i[i];
                        shift_din11_q_add_5[i] <= shift_din10_q[(din_cnt - 10)*16 + i] + din_q[i];
                        shift_din11_q_sub_5[i] <= shift_din10_q[(din_cnt - 10)*16 + i] - din_q[i];
                    end
                end else if (din_cnt == 11) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_6[i] <= shift_din10_i[(din_cnt - 10)*16 + i] + din_i[i];
                        shift_din11_i_sub_6[i] <= shift_din10_q[(din_cnt - 10)*16 + i] - din_q[i];
                        shift_din11_q_add_6[i] <= shift_din10_q[(din_cnt - 10)*16 + i] + din_q[i];
                        shift_din11_q_sub_6[i] <= -1*(shift_din10_i[(din_cnt - 10)*16 + i] - din_i[i]);
                    end
                end else if (din_cnt == 14) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_7[i] <= shift_din10_i[(din_cnt - 14)*16 + i] + din_i[i];
                        shift_din11_i_sub_7[i] <= shift_din10_i[(din_cnt - 14)*16 + i] - din_i[i];
                        shift_din11_q_add_7[i] <= shift_din10_q[(din_cnt - 14)*16 + i] + din_q[i];
                        shift_din11_q_sub_7[i] <= shift_din10_q[(din_cnt - 14)*16 + i] - din_q[i];
                    end
                end else if (din_cnt == 15) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_8[i] <= shift_din10_i[(din_cnt - 14)*16 + i] + din_i[i];
                        shift_din11_i_sub_8[i] <= shift_din10_q[(din_cnt - 14)*16 + i] - din_q[i];
                        shift_din11_q_add_8[i] <= shift_din10_q[(din_cnt - 14)*16 + i] + din_q[i];
                        shift_din11_q_sub_8[i] <= -1*(shift_din10_i[(din_cnt - 14)*16 + i] - din_i[i]);
                    end
                end else if (din_cnt == 18) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_1[i] <= shift_din10_i[(din_cnt - 18)*16 + i] + din_i[i];
                        shift_din11_i_sub_1[i] <= shift_din10_i[(din_cnt - 18)*16 + i] - din_i[i];
                        shift_din11_q_add_1[i] <= shift_din10_q[(din_cnt - 18)*16 + i] + din_q[i];
                        shift_din11_q_sub_1[i] <= shift_din10_q[(din_cnt - 18)*16 + i] - din_q[i];
                    end
                end else if (din_cnt == 19) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_2[i] <= shift_din10_i[(din_cnt - 18)*16 + i] + din_i[i];
                        shift_din11_i_sub_2[i] <= shift_din10_q[(din_cnt - 18)*16 + i] - din_q[i];
                        shift_din11_q_add_2[i] <= shift_din10_q[(din_cnt - 18)*16 + i] + din_q[i];
                        shift_din11_q_sub_2[i] <= -1*(shift_din10_i[(din_cnt - 18)*16 + i] - din_i[i]);
                    end
                end else if (din_cnt == 22) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_3[i] <= shift_din10_i[(din_cnt - 22)*16 + i] + din_i[i];
                        shift_din11_i_sub_3[i] <= shift_din10_i[(din_cnt - 22)*16 + i] - din_i[i];
                        shift_din11_q_add_3[i] <= shift_din10_q[(din_cnt - 22)*16 + i] + din_q[i];
                        shift_din11_q_sub_3[i] <= shift_din10_q[(din_cnt - 22)*16 + i] - din_q[i];
                    end
                end else if (din_cnt == 23) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_4[i] <= shift_din10_i[(din_cnt - 22)*16 + i] + din_i[i];
                        shift_din11_i_sub_4[i] <= shift_din10_q[(din_cnt - 22)*16 + i] - din_q[i];
                        shift_din11_q_add_4[i] <= shift_din10_q[(din_cnt - 22)*16 + i] + din_q[i];
                        shift_din11_q_sub_4[i] <= -1*(shift_din10_i[(din_cnt - 22)*16 + i] - din_i[i]);
                    end
                end else if (din_cnt == 26) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_5[i] <= shift_din10_i[(din_cnt - 26)*16 + i] + din_i[i];
                        shift_din11_i_sub_5[i] <= shift_din10_i[(din_cnt - 26)*16 + i] - din_i[i];
                        shift_din11_q_add_5[i] <= shift_din10_q[(din_cnt - 26)*16 + i] + din_q[i];
                        shift_din11_q_sub_5[i] <= shift_din10_q[(din_cnt - 26)*16 + i] - din_q[i];
                    end
                end else if (din_cnt == 27) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_6[i] <= shift_din10_i[(din_cnt - 26)*16 + i] + din_i[i];
                        shift_din11_i_sub_6[i] <= shift_din10_q[(din_cnt - 26)*16 + i] - din_q[i];
                        shift_din11_q_add_6[i] <= shift_din10_q[(din_cnt - 26)*16 + i] + din_q[i];
                        shift_din11_q_sub_6[i] <= -1*(shift_din10_i[(din_cnt - 26)*16 + i] - din_i[i]);
                    end
                end else if (din_cnt == 30) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_7[i] <= shift_din10_i[(din_cnt - 30)*16 + i] + din_i[i];
                        shift_din11_i_sub_7[i] <= shift_din10_i[(din_cnt - 30)*16 + i] - din_i[i];
                        shift_din11_q_add_7[i] <= shift_din10_q[(din_cnt - 30)*16 + i] + din_q[i];
                        shift_din11_q_sub_7[i] <= shift_din10_q[(din_cnt - 30)*16 + i] - din_q[i];
                    end
                end else if (din_cnt == 31) begin
                    for (i = 0; i <= ARRAY_IN - 1; i = i + 1) begin
                        shift_din11_i_add_8[i] <= shift_din10_i[(din_cnt - 30)*16 + i] + din_i[i];
                        shift_din11_i_sub_8[i] <= shift_din10_q[(din_cnt - 30)*16 + i] - din_q[i];
                        shift_din11_q_add_8[i] <= shift_din10_q[(din_cnt - 30)*16 + i] + din_q[i];
                        shift_din11_q_sub_8[i] <= -1*(shift_din10_i[(din_cnt - 30)*16 + i] - din_i[i]);
                    end
                end
                m10_cnt <= m10_cnt + 1;
            end else begin
                m10_cnt <= 0;
            end
        end
    end

    always @(posedge clk, negedge rstn) begin
        if (~rstn) begin
            for (i = 7; i >= 0; i = i - 1) begin
                shift_din12_i_add_1[i]  <= 0;
                shift_din12_i_sub_1[i]  <= 0;
                shift_din12_q_add_1[i]  <= 0;
                shift_din12_q_sub_1[i]  <= 0;
                shift_din12_i_add_2[i]  <= 0;
                shift_din12_i_sub_2[i]  <= 0;
                shift_din12_q_add_2[i]  <= 0;
                shift_din12_q_sub_2[i]  <= 0;
                shift_din12_i_add_3[i]  <= 0;
                shift_din12_i_sub_3[i]  <= 0;
                shift_din12_q_add_3[i]  <= 0;
                shift_din12_q_sub_3[i]  <= 0;
                shift_din12_i_add_4[i]  <= 0;
                shift_din12_i_sub_4[i]  <= 0;
                shift_din12_q_add_4[i]  <= 0;
                shift_din12_q_sub_4[i]  <= 0;
                shift_din12_i_add_5[i]  <= 0;
                shift_din12_i_sub_5[i]  <= 0;
                shift_din12_q_add_5[i]  <= 0;
                shift_din12_q_sub_5[i]  <= 0;
                shift_din12_i_add_6[i]  <= 0;
                shift_din12_i_sub_6[i]  <= 0;
                shift_din12_q_add_6[i]  <= 0;
                shift_din12_q_sub_6[i]  <= 0;
                shift_din12_i_add_7[i]  <= 0;
                shift_din12_i_sub_7[i]  <= 0;
                shift_din12_q_add_7[i]  <= 0;
                shift_din12_q_sub_7[i]  <= 0;
                shift_din12_i_add_8[i]  <= 0;
                shift_din12_i_sub_8[i]  <= 0;
                shift_din12_q_add_8[i]  <= 0;
                shift_din12_q_sub_8[i]  <= 0;
                shift_din12_i_add_9[i]  <= 0;
                shift_din12_i_sub_9[i]  <= 0;
                shift_din12_q_add_9[i]  <= 0;
                shift_din12_q_sub_9[i]  <= 0;
                shift_din12_i_add_10[i] <= 0;
                shift_din12_i_sub_10[i] <= 0;
                shift_din12_q_add_10[i] <= 0;
                shift_din12_q_sub_10[i] <= 0;
                shift_din12_i_add_11[i] <= 0;
                shift_din12_i_sub_11[i] <= 0;
                shift_din12_q_add_11[i] <= 0;
                shift_din12_q_sub_11[i] <= 0;
                shift_din12_i_add_12[i] <= 0;
                shift_din12_i_sub_12[i] <= 0;
                shift_din12_q_add_12[i] <= 0;
                shift_din12_q_sub_12[i] <= 0;
                shift_din12_i_add_13[i] <= 0;
                shift_din12_i_sub_13[i] <= 0;
                shift_din12_q_add_13[i] <= 0;
                shift_din12_q_sub_13[i] <= 0;
                shift_din12_i_add_14[i] <= 0;
                shift_din12_i_sub_14[i] <= 0;
                shift_din12_q_add_14[i] <= 0;
                shift_din12_q_sub_14[i] <= 0;
                shift_din12_i_add_15[i] <= 0;
                shift_din12_i_sub_15[i] <= 0;
                shift_din12_q_add_15[i] <= 0;
                shift_din12_q_sub_15[i] <= 0;
                shift_din12_i_add_16[i] <= 0;
                shift_din12_i_sub_16[i] <= 0;
                shift_din12_q_add_16[i] <= 0;
                shift_din12_q_sub_16[i] <= 0;
            end
        end else begin
            if (m10_cnt == 2) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_1[i] <= shift_din11_i_add_1[i] + shift_din11_i_add_2[i];
                    shift_din12_i_sub_1[i] <= shift_din11_i_add_1[i] - shift_din11_i_add_2[i];
                    shift_din12_q_add_1[i] <= shift_din11_q_add_1[i] + shift_din11_q_add_2[i];
                    shift_din12_q_sub_1[i] <= shift_din11_q_add_1[i] - shift_din11_q_add_2[i];
                    shift_din12_i_add_2[i] <= shift_din11_i_add_1[8+i] + shift_din11_i_add_2[8+i];
                    shift_din12_i_sub_2[i] <= shift_din11_i_add_1[8+i] - shift_din11_i_add_2[8+i];
                    shift_din12_q_add_2[i] <= shift_din11_q_add_1[8+i] + shift_din11_q_add_2[8+i];
                    shift_din12_q_sub_2[i] <= shift_din11_q_add_1[8+i] - shift_din11_q_add_2[8+i];
                end
            end else if (m10_cnt == 4) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_3[i] <= shift_din11_i_sub_1[i] + shift_din11_i_sub_2[i];
                    shift_din12_i_sub_3[i] <= shift_din11_i_sub_1[i] - shift_din11_i_sub_2[i];
                    shift_din12_q_add_3[i] <= shift_din11_q_sub_1[i] + shift_din11_q_sub_2[i];
                    shift_din12_q_sub_3[i] <= shift_din11_q_sub_1[i] - shift_din11_q_sub_2[i];
                    shift_din12_i_add_4[i] <= shift_din11_i_sub_1[8+i] + shift_din11_i_sub_2[8+i];
                    shift_din12_i_sub_4[i] <= shift_din11_i_sub_1[8+i] - shift_din11_i_sub_2[8+i];
                    shift_din12_q_add_4[i] <= shift_din11_q_sub_1[8+i] + shift_din11_q_sub_2[8+i];
                    shift_din12_q_sub_4[i] <= shift_din11_q_sub_1[8+i] - shift_din11_q_sub_2[8+i];
                end
            end else if (m10_cnt == 6) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_5[i] <= shift_din11_i_add_3[i] + shift_din11_i_add_4[i];
                    shift_din12_i_sub_5[i] <= shift_din11_i_add_3[i] - shift_din11_i_add_4[i];
                    shift_din12_q_add_5[i] <= shift_din11_q_add_3[i] + shift_din11_q_add_4[i];
                    shift_din12_q_sub_5[i] <= shift_din11_q_add_3[i] - shift_din11_q_add_4[i];
                    shift_din12_i_add_6[i] <= shift_din11_i_add_3[8+i] + shift_din11_i_add_4[8+i];
                    shift_din12_i_sub_6[i] <= shift_din11_i_add_3[8+i] - shift_din11_i_add_4[8+i];
                    shift_din12_q_add_6[i] <= shift_din11_q_add_3[8+i] + shift_din11_q_add_4[8+i];
                    shift_din12_q_sub_6[i] <= shift_din11_q_add_3[8+i] - shift_din11_q_add_4[8+i];
                end
            end else if (m10_cnt == 8) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_7[i] <= shift_din11_i_sub_3[i] + shift_din11_i_sub_4[i];
                    shift_din12_i_sub_7[i] <= shift_din11_i_sub_3[i] - shift_din11_i_sub_4[i];
                    shift_din12_q_add_7[i] <= shift_din11_q_sub_3[i] + shift_din11_q_sub_4[i];
                    shift_din12_q_sub_7[i] <= shift_din11_q_sub_3[i] - shift_din11_q_sub_4[i];
                    shift_din12_i_add_8[i] <= shift_din11_i_sub_3[8+i] + shift_din11_i_sub_4[8+i];
                    shift_din12_i_sub_8[i] <= shift_din11_i_sub_3[8+i] - shift_din11_i_sub_4[8+i];
                    shift_din12_q_add_8[i] <= shift_din11_q_sub_3[8+i] + shift_din11_q_sub_4[8+i];
                    shift_din12_q_sub_8[i] <= shift_din11_q_sub_3[8+i] - shift_din11_q_sub_4[8+i];
                end
            end else if (m10_cnt == 10) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_9[i] <= shift_din11_i_add_5[i] + shift_din11_i_add_6[i];
                    shift_din12_i_sub_9[i] <= shift_din11_i_add_5[i] - shift_din11_i_add_6[i];
                    shift_din12_q_add_9[i] <= shift_din11_q_add_5[i] + shift_din11_q_add_6[i];
                    shift_din12_q_sub_9[i] <= shift_din11_q_add_5[i] - shift_din11_q_add_6[i];
                    shift_din12_i_add_10[i] <= shift_din11_i_add_5[8+i] + shift_din11_i_add_6[8+i];
                    shift_din12_i_sub_10[i] <= shift_din11_i_add_5[8+i] - shift_din11_i_add_6[8+i];
                    shift_din12_q_add_10[i] <= shift_din11_q_add_5[8+i] + shift_din11_q_add_6[8+i];
                    shift_din12_q_sub_10[i] <= shift_din11_q_add_5[8+i] - shift_din11_q_add_6[8+i];
                end
            end else if (m10_cnt == 12) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_11[i] <= shift_din11_i_sub_5[i] + shift_din11_i_sub_6[i];
                    shift_din12_i_sub_11[i] <= shift_din11_i_sub_5[i] - shift_din11_i_sub_6[i];
                    shift_din12_q_add_11[i] <= shift_din11_q_sub_5[i] + shift_din11_q_sub_6[i];
                    shift_din12_q_sub_11[i] <= shift_din11_q_sub_5[i] - shift_din11_q_sub_6[i];
                    shift_din12_i_add_12[i] <= shift_din11_i_sub_5[8+i] + shift_din11_i_sub_6[8+i];
                    shift_din12_i_sub_12[i] <= shift_din11_i_sub_5[8+i] - shift_din11_i_sub_6[8+i];
                    shift_din12_q_add_12[i] <= shift_din11_q_sub_5[8+i] + shift_din11_q_sub_6[8+i];
                    shift_din12_q_sub_12[i] <= shift_din11_q_sub_5[8+i] - shift_din11_q_sub_6[8+i];
                end
            end else if (m10_cnt == 14) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_13[i] <= shift_din11_i_add_7[i] + shift_din11_i_add_8[i];
                    shift_din12_i_sub_13[i] <= shift_din11_i_add_7[i] - shift_din11_i_add_8[i];
                    shift_din12_q_add_13[i] <= shift_din11_q_add_7[i] + shift_din11_q_add_8[i];
                    shift_din12_q_sub_13[i] <= shift_din11_q_add_7[i] - shift_din11_q_add_8[i];
                    shift_din12_i_add_14[i] <= shift_din11_i_add_7[8+i] + shift_din11_i_add_8[8+i];
                    shift_din12_i_sub_14[i] <= shift_din11_i_add_7[8+i] - shift_din11_i_add_8[8+i];
                    shift_din12_q_add_14[i] <= shift_din11_q_add_7[8+i] + shift_din11_q_add_8[8+i];
                    shift_din12_q_sub_14[i] <= shift_din11_q_add_7[8+i] - shift_din11_q_add_8[8+i];
                end
            end else if (m10_cnt == 16) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_15[i] <= shift_din11_i_sub_7[i] + shift_din11_i_sub_8[i];
                    shift_din12_i_sub_15[i] <= shift_din11_i_sub_7[i] - shift_din11_i_sub_8[i];
                    shift_din12_q_add_15[i] <= shift_din11_q_sub_7[i] + shift_din11_q_sub_8[i];
                    shift_din12_q_sub_15[i] <= shift_din11_q_sub_7[i] - shift_din11_q_sub_8[i];
                    shift_din12_i_add_16[i] <= shift_din11_i_sub_7[8+i] + shift_din11_i_sub_8[8+i];
                    shift_din12_i_sub_16[i] <= shift_din11_i_sub_7[8+i] - shift_din11_i_sub_8[8+i];
                    shift_din12_q_add_16[i] <= shift_din11_q_sub_7[8+i] + shift_din11_q_sub_8[8+i];
                    shift_din12_q_sub_16[i] <= shift_din11_q_sub_7[8+i] - shift_din11_q_sub_8[8+i];
                end
            end else if (m10_cnt == 18) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_1[i] <= shift_din11_i_add_1[i] + shift_din11_i_add_2[i];
                    shift_din12_i_sub_1[i] <= shift_din11_i_add_1[i] - shift_din11_i_add_2[i];
                    shift_din12_q_add_1[i] <= shift_din11_q_add_1[i] + shift_din11_q_add_2[i];
                    shift_din12_q_sub_1[i] <= shift_din11_q_add_1[i] - shift_din11_q_add_2[i];
                    shift_din12_i_add_2[i] <= shift_din11_i_add_1[8+i] + shift_din11_i_add_2[8+i];
                    shift_din12_i_sub_2[i] <= shift_din11_i_add_1[8+i] - shift_din11_i_add_2[8+i];
                    shift_din12_q_add_2[i] <= shift_din11_q_add_1[8+i] + shift_din11_q_add_2[8+i];
                    shift_din12_q_sub_2[i] <= shift_din11_q_add_1[8+i] - shift_din11_q_add_2[8+i];
                end
            end else if (m10_cnt == 20) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_3[i] <= shift_din11_i_sub_1[i] + shift_din11_i_sub_2[i];
                    shift_din12_i_sub_3[i] <= shift_din11_i_sub_1[i] - shift_din11_i_sub_2[i];
                    shift_din12_q_add_3[i] <= shift_din11_q_sub_1[i] + shift_din11_q_sub_2[i];
                    shift_din12_q_sub_3[i] <= shift_din11_q_sub_1[i] - shift_din11_q_sub_2[i];
                    shift_din12_i_add_4[i] <= shift_din11_i_sub_1[8+i] + shift_din11_i_sub_2[8+i];
                    shift_din12_i_sub_4[i] <= shift_din11_i_sub_1[8+i] - shift_din11_i_sub_2[8+i];
                    shift_din12_q_add_4[i] <= shift_din11_q_sub_1[8+i] + shift_din11_q_sub_2[8+i];
                    shift_din12_q_sub_4[i] <= shift_din11_q_sub_1[8+i] - shift_din11_q_sub_2[8+i];
                end
            end else if (m10_cnt == 22) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_5[i] <= shift_din11_i_add_3[i] + shift_din11_i_add_4[i];
                    shift_din12_i_sub_5[i] <= shift_din11_i_add_3[i] - shift_din11_i_add_4[i];
                    shift_din12_q_add_5[i] <= shift_din11_q_add_3[i] + shift_din11_q_add_4[i];
                    shift_din12_q_sub_5[i] <= shift_din11_q_add_3[i] - shift_din11_q_add_4[i];
                    shift_din12_i_add_6[i] <= shift_din11_i_add_3[8+i] + shift_din11_i_add_4[8+i];
                    shift_din12_i_sub_6[i] <= shift_din11_i_add_3[8+i] - shift_din11_i_add_4[8+i];
                    shift_din12_q_add_6[i] <= shift_din11_q_add_3[8+i] + shift_din11_q_add_4[8+i];
                    shift_din12_q_sub_6[i] <= shift_din11_q_add_3[8+i] - shift_din11_q_add_4[8+i];
                end
            end else if (m10_cnt == 24) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_7[i] <= shift_din11_i_sub_3[i] + shift_din11_i_sub_4[i];
                    shift_din12_i_sub_7[i] <= shift_din11_i_sub_3[i] - shift_din11_i_sub_4[i];
                    shift_din12_q_add_7[i] <= shift_din11_q_sub_3[i] + shift_din11_q_sub_4[i];
                    shift_din12_q_sub_7[i] <= shift_din11_q_sub_3[i] - shift_din11_q_sub_4[i];
                    shift_din12_i_add_8[i] <= shift_din11_i_sub_3[8+i] + shift_din11_i_sub_4[8+i];
                    shift_din12_i_sub_8[i] <= shift_din11_i_sub_3[8+i] - shift_din11_i_sub_4[8+i];
                    shift_din12_q_add_8[i] <= shift_din11_q_sub_3[8+i] + shift_din11_q_sub_4[8+i];
                    shift_din12_q_sub_8[i] <= shift_din11_q_sub_3[8+i] - shift_din11_q_sub_4[8+i];
                end
            end else if (m10_cnt == 26) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_9[i] <= shift_din11_i_add_5[i] + shift_din11_i_add_6[i];
                    shift_din12_i_sub_9[i] <= shift_din11_i_add_5[i] - shift_din11_i_add_6[i];
                    shift_din12_q_add_9[i] <= shift_din11_q_add_5[i] + shift_din11_q_add_6[i];
                    shift_din12_q_sub_9[i] <= shift_din11_q_add_5[i] - shift_din11_q_add_6[i];
                    shift_din12_i_add_10[i] <= shift_din11_i_add_5[8+i] + shift_din11_i_add_6[8+i];
                    shift_din12_i_sub_10[i] <= shift_din11_i_add_5[8+i] - shift_din11_i_add_6[8+i];
                    shift_din12_q_add_10[i] <= shift_din11_q_add_5[8+i] + shift_din11_q_add_6[8+i];
                    shift_din12_q_sub_10[i] <= shift_din11_q_add_5[8+i] - shift_din11_q_add_6[8+i];
                end
            end else if (m10_cnt == 28) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_11[i] <= shift_din11_i_sub_5[i] + shift_din11_i_sub_6[i];
                    shift_din12_i_sub_11[i] <= shift_din11_i_sub_5[i] - shift_din11_i_sub_6[i];
                    shift_din12_q_add_11[i] <= shift_din11_q_sub_5[i] + shift_din11_q_sub_6[i];
                    shift_din12_q_sub_11[i] <= shift_din11_q_sub_5[i] - shift_din11_q_sub_6[i];
                    shift_din12_i_add_12[i] <= shift_din11_i_sub_5[8+i] + shift_din11_i_sub_6[8+i];
                    shift_din12_i_sub_12[i] <= shift_din11_i_sub_5[8+i] - shift_din11_i_sub_6[8+i];
                    shift_din12_q_add_12[i] <= shift_din11_q_sub_5[8+i] + shift_din11_q_sub_6[8+i];
                    shift_din12_q_sub_12[i] <= shift_din11_q_sub_5[8+i] - shift_din11_q_sub_6[8+i];
                end
            end else if (m10_cnt == 30) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_13[i] <= shift_din11_i_add_7[i] + shift_din11_i_add_8[i];
                    shift_din12_i_sub_13[i] <= shift_din11_i_add_7[i] - shift_din11_i_add_8[i];
                    shift_din12_q_add_13[i] <= shift_din11_q_add_7[i] + shift_din11_q_add_8[i];
                    shift_din12_q_sub_13[i] <= shift_din11_q_add_7[i] - shift_din11_q_add_8[i];
                    shift_din12_i_add_14[i] <= shift_din11_i_add_7[8+i] + shift_din11_i_add_8[8+i];
                    shift_din12_i_sub_14[i] <= shift_din11_i_add_7[8+i] - shift_din11_i_add_8[8+i];
                    shift_din12_q_add_14[i] <= shift_din11_q_add_7[8+i] + shift_din11_q_add_8[8+i];
                    shift_din12_q_sub_14[i] <= shift_din11_q_add_7[8+i] - shift_din11_q_add_8[8+i];
                end
            end else if (m10_cnt == 32) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_15[i] <= shift_din11_i_sub_7[i] + shift_din11_i_sub_8[i];
                    shift_din12_i_sub_15[i] <= shift_din11_i_sub_7[i] - shift_din11_i_sub_8[i];
                    shift_din12_q_add_15[i] <= shift_din11_q_sub_7[i] + shift_din11_q_sub_8[i];
                    shift_din12_q_sub_15[i] <= shift_din11_q_sub_7[i] - shift_din11_q_sub_8[i];
                    shift_din12_i_add_16[i] <= shift_din11_i_sub_7[8+i] + shift_din11_i_sub_8[8+i];
                    shift_din12_i_sub_16[i] <= shift_din11_i_sub_7[8+i] - shift_din11_i_sub_8[8+i];
                    shift_din12_q_add_16[i] <= shift_din11_q_sub_7[8+i] + shift_din11_q_sub_8[8+i];
                    shift_din12_q_sub_16[i] <= shift_din11_q_sub_7[8+i] - shift_din11_q_sub_8[8+i];
                end
            end
        end
    end

    always @(posedge clk, negedge rstn) begin
        if (~rstn) begin
            for (i = 7; i >= 0; i = i - 1) begin
                shift_din12_i_add_1_fac[i]  <= 0;
                shift_din12_i_sub_1_fac[i]  <= 0;
                shift_din12_q_add_1_fac[i]  <= 0;
                shift_din12_q_sub_1_fac[i]  <= 0;
                shift_din12_i_add_2_fac[i]  <= 0;
                shift_din12_i_sub_2_fac[i]  <= 0;
                shift_din12_q_add_2_fac[i]  <= 0;
                shift_din12_q_sub_2_fac[i]  <= 0;
                shift_din12_i_add_3_fac[i]  <= 0;
                shift_din12_i_sub_3_fac[i]  <= 0;
                shift_din12_q_add_3_fac[i]  <= 0;
                shift_din12_q_sub_3_fac[i]  <= 0;
                shift_din12_i_add_4_fac[i]  <= 0;
                shift_din12_i_sub_4_fac[i]  <= 0;
                shift_din12_q_add_4_fac[i]  <= 0;
                shift_din12_q_sub_4_fac[i]  <= 0;
                shift_din12_i_add_5_fac[i]  <= 0;
                shift_din12_i_sub_5_fac[i]  <= 0;
                shift_din12_q_add_5_fac[i]  <= 0;
                shift_din12_q_sub_5_fac[i]  <= 0;
                shift_din12_i_add_6_fac[i]  <= 0;
                shift_din12_i_sub_6_fac[i]  <= 0;
                shift_din12_q_add_6_fac[i]  <= 0;
                shift_din12_q_sub_6_fac[i]  <= 0;
                shift_din12_i_add_7_fac[i]  <= 0;
                shift_din12_i_sub_7_fac[i]  <= 0;
                shift_din12_q_add_7_fac[i]  <= 0;
                shift_din12_q_sub_7_fac[i]  <= 0;
                shift_din12_i_add_8_fac[i]  <= 0;
                shift_din12_i_sub_8_fac[i]  <= 0;
                shift_din12_q_add_8_fac[i]  <= 0;
                shift_din12_q_sub_8_fac[i]  <= 0;
                shift_din12_i_add_9_fac[i]  <= 0;
                shift_din12_i_sub_9_fac[i]  <= 0;
                shift_din12_q_add_9_fac[i]  <= 0;
                shift_din12_q_sub_9_fac[i]  <= 0;
                shift_din12_i_add_10_fac[i] <= 0;
                shift_din12_i_sub_10_fac[i] <= 0;
                shift_din12_q_add_10_fac[i] <= 0;
                shift_din12_q_sub_10_fac[i] <= 0;
                shift_din12_i_add_11_fac[i] <= 0;
                shift_din12_i_sub_11_fac[i] <= 0;
                shift_din12_q_add_11_fac[i] <= 0;
                shift_din12_q_sub_11_fac[i] <= 0;
                shift_din12_i_add_12_fac[i] <= 0;
                shift_din12_i_sub_12_fac[i] <= 0;
                shift_din12_q_add_12_fac[i] <= 0;
                shift_din12_q_sub_12_fac[i] <= 0;
                shift_din12_i_add_13_fac[i] <= 0;
                shift_din12_i_sub_13_fac[i] <= 0;
                shift_din12_q_add_13_fac[i] <= 0;
                shift_din12_q_sub_13_fac[i] <= 0;
                shift_din12_i_add_14_fac[i] <= 0;
                shift_din12_i_sub_14_fac[i] <= 0;
                shift_din12_q_add_14_fac[i] <= 0;
                shift_din12_q_sub_14_fac[i] <= 0;
                shift_din12_i_add_15_fac[i] <= 0;
                shift_din12_i_sub_15_fac[i] <= 0;
                shift_din12_q_add_15_fac[i] <= 0;
                shift_din12_q_sub_15_fac[i] <= 0;
                shift_din12_i_add_16_fac[i] <= 0;
                shift_din12_i_sub_16_fac[i] <= 0;
                shift_din12_q_add_16_fac[i] <= 0;
                shift_din12_q_sub_16_fac[i] <= 0;
            end
        end else begin
            if (m10_cnt == 3) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_1_fac[i] <= (shift_din12_i_add_1[i]*fac8_1_re[0]) - (shift_din12_q_add_1[i]*fac8_1_im[0]);
                    shift_din12_i_sub_1_fac[i] <= (shift_din12_i_sub_1[i]*fac8_1_re[2]) - (shift_din12_q_sub_1[i]*fac8_1_im[2]);
                    shift_din12_q_add_1_fac[i] <= (shift_din12_q_add_1[i]*fac8_1_re[0]) + (shift_din12_i_add_1[i]*fac8_1_im[0]);
                    shift_din12_q_sub_1_fac[i] <= (shift_din12_q_sub_1[i]*fac8_1_re[2]) + (shift_din12_i_sub_1[i]*fac8_1_im[2]);
                    shift_din12_i_add_2_fac[i] <= (shift_din12_i_add_2[i]*fac8_1_re[1]) - (shift_din12_q_add_2[i]*fac8_1_im[1]);
                    shift_din12_i_sub_2_fac[i] <= (shift_din12_i_sub_2[i]*fac8_1_re[3]) - (shift_din12_q_sub_2[i]*fac8_1_im[3]);
                    shift_din12_q_add_2_fac[i] <= (shift_din12_q_add_2[i]*fac8_1_re[1]) + (shift_din12_i_add_2[i]*fac8_1_im[1]);
                    shift_din12_q_sub_2_fac[i] <= (shift_din12_q_sub_2[i]*fac8_1_re[3]) + (shift_din12_i_sub_2[i]*fac8_1_im[3]);
                end
            end else if (m10_cnt == 5) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_3_fac[i] <= (shift_din12_i_add_3[i]*fac8_1_re[4]) - (shift_din12_q_add_3[i]*fac8_1_im[4]);
                    shift_din12_i_sub_3_fac[i] <= (shift_din12_i_sub_3[i]*fac8_1_re[6]) - (shift_din12_q_sub_3[i]*fac8_1_im[6]);
                    shift_din12_q_add_3_fac[i] <= (shift_din12_q_add_3[i]*fac8_1_re[4]) + (shift_din12_i_add_3[i]*fac8_1_im[4]);
                    shift_din12_q_sub_3_fac[i] <= (shift_din12_q_sub_3[i]*fac8_1_re[6]) + (shift_din12_i_sub_3[i]*fac8_1_im[6]);
                    shift_din12_i_add_4_fac[i] <= (shift_din12_i_add_4[i]*fac8_1_re[5]) - (shift_din12_q_add_4[i]*fac8_1_im[5]);
                    shift_din12_i_sub_4_fac[i] <= (shift_din12_i_sub_4[i]*fac8_1_re[7]) - (shift_din12_q_sub_4[i]*fac8_1_im[7]);
                    shift_din12_q_add_4_fac[i] <= (shift_din12_q_add_4[i]*fac8_1_re[5]) + (shift_din12_i_add_4[i]*fac8_1_im[5]);
                    shift_din12_q_sub_4_fac[i] <= (shift_din12_q_sub_4[i]*fac8_1_re[7]) + (shift_din12_i_sub_4[i]*fac8_1_im[7]);
                end
            end else if (m10_cnt == 7) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_5_fac[i] <= (shift_din12_i_add_5[i]*fac8_1_re[0]) - (shift_din12_q_add_5[i]*fac8_1_im[0]);
                    shift_din12_i_sub_5_fac[i] <= (shift_din12_i_sub_5[i]*fac8_1_re[2]) - (shift_din12_q_sub_5[i]*fac8_1_im[2]);
                    shift_din12_q_add_5_fac[i] <= (shift_din12_q_add_5[i]*fac8_1_re[0]) + (shift_din12_i_add_5[i]*fac8_1_im[0]);
                    shift_din12_q_sub_5_fac[i] <= (shift_din12_q_sub_5[i]*fac8_1_re[2]) + (shift_din12_i_sub_5[i]*fac8_1_im[2]);
                    shift_din12_i_add_6_fac[i] <= (shift_din12_i_add_6[i]*fac8_1_re[1]) - (shift_din12_q_add_6[i]*fac8_1_im[1]);
                    shift_din12_i_sub_6_fac[i] <= (shift_din12_i_sub_6[i]*fac8_1_re[3]) - (shift_din12_q_sub_6[i]*fac8_1_im[3]);
                    shift_din12_q_add_6_fac[i] <= (shift_din12_q_add_6[i]*fac8_1_re[1]) + (shift_din12_i_add_6[i]*fac8_1_im[1]);
                    shift_din12_q_sub_6_fac[i] <= (shift_din12_q_sub_6[i]*fac8_1_re[3]) + (shift_din12_i_sub_6[i]*fac8_1_im[3]);
                end
            end else if (m10_cnt == 9) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_7_fac[i] <= (shift_din12_i_add_7[i]*fac8_1_re[4]) - (shift_din12_q_add_7[i]*fac8_1_im[4]);
                    shift_din12_i_sub_7_fac[i] <= (shift_din12_i_sub_7[i]*fac8_1_re[6]) - (shift_din12_q_sub_7[i]*fac8_1_im[6]);
                    shift_din12_q_add_7_fac[i] <= (shift_din12_q_add_7[i]*fac8_1_re[4]) + (shift_din12_i_add_7[i]*fac8_1_im[4]);
                    shift_din12_q_sub_7_fac[i] <= (shift_din12_q_sub_7[i]*fac8_1_re[6]) + (shift_din12_i_sub_7[i]*fac8_1_im[6]);
                    shift_din12_i_add_8_fac[i] <= (shift_din12_i_add_8[i]*fac8_1_re[5]) - (shift_din12_q_add_8[i]*fac8_1_im[5]);
                    shift_din12_i_sub_8_fac[i] <= (shift_din12_i_sub_8[i]*fac8_1_re[7]) - (shift_din12_q_sub_8[i]*fac8_1_im[7]);
                    shift_din12_q_add_8_fac[i] <= (shift_din12_q_add_8[i]*fac8_1_re[5]) + (shift_din12_i_add_8[i]*fac8_1_im[5]);
                    shift_din12_q_sub_8_fac[i] <= (shift_din12_q_sub_8[i]*fac8_1_re[7]) + (shift_din12_i_sub_8[i]*fac8_1_im[7]);
                end
            end else if (m10_cnt == 11) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_9_fac[i] <= (shift_din12_i_add_9[i]*fac8_1_re[0]) - (shift_din12_q_add_9[i]*fac8_1_im[0]);
                    shift_din12_i_sub_9_fac[i] <= (shift_din12_i_sub_9[i]*fac8_1_re[2]) - (shift_din12_q_sub_9[i]*fac8_1_im[2]);
                    shift_din12_q_add_9_fac[i] <= (shift_din12_q_add_9[i]*fac8_1_re[0]) + (shift_din12_i_add_9[i]*fac8_1_im[0]);
                    shift_din12_q_sub_9_fac[i] <= (shift_din12_q_sub_9[i]*fac8_1_re[2]) + (shift_din12_i_sub_9[i]*fac8_1_im[2]);
                    shift_din12_i_add_10_fac[i] <= (shift_din12_i_add_10[i]*fac8_1_re[1]) - (shift_din12_q_add_10[i]*fac8_1_im[1]);
                    shift_din12_i_sub_10_fac[i] <= (shift_din12_i_sub_10[i]*fac8_1_re[3]) - (shift_din12_q_sub_10[i]*fac8_1_im[3]);
                    shift_din12_q_add_10_fac[i] <= (shift_din12_q_add_10[i]*fac8_1_re[1]) + (shift_din12_i_add_10[i]*fac8_1_im[1]);
                    shift_din12_q_sub_10_fac[i] <= (shift_din12_q_sub_10[i]*fac8_1_re[3]) + (shift_din12_i_sub_10[i]*fac8_1_im[3]);
                end
            end else if (m10_cnt == 13) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_11_fac[i] <= (shift_din12_i_add_11[i]*fac8_1_re[4]) - (shift_din12_q_add_11[i]*fac8_1_im[4]);
                    shift_din12_i_sub_11_fac[i] <= (shift_din12_i_sub_11[i]*fac8_1_re[6]) - (shift_din12_q_sub_11[i]*fac8_1_im[6]);
                    shift_din12_q_add_11_fac[i] <= (shift_din12_q_add_11[i]*fac8_1_re[4]) + (shift_din12_i_add_11[i]*fac8_1_im[4]);
                    shift_din12_q_sub_11_fac[i] <= (shift_din12_q_sub_11[i]*fac8_1_re[6]) + (shift_din12_i_sub_11[i]*fac8_1_im[6]);
                    shift_din12_i_add_12_fac[i] <= (shift_din12_i_add_12[i]*fac8_1_re[5]) - (shift_din12_q_add_12[i]*fac8_1_im[5]);
                    shift_din12_i_sub_12_fac[i] <= (shift_din12_i_sub_12[i]*fac8_1_re[7]) - (shift_din12_q_sub_12[i]*fac8_1_im[7]);
                    shift_din12_q_add_12_fac[i] <= (shift_din12_q_add_12[i]*fac8_1_re[5]) + (shift_din12_i_add_12[i]*fac8_1_im[5]);
                    shift_din12_q_sub_12_fac[i] <= (shift_din12_q_sub_12[i]*fac8_1_re[7]) + (shift_din12_i_sub_12[i]*fac8_1_im[7]);
                end
            end else if (m10_cnt == 15) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_13_fac[i] <= (shift_din12_i_add_13[i]*fac8_1_re[0]) - (shift_din12_q_add_13[i]*fac8_1_im[0]);
                    shift_din12_i_sub_13_fac[i] <= (shift_din12_i_sub_13[i]*fac8_1_re[2]) - (shift_din12_q_sub_13[i]*fac8_1_im[2]);
                    shift_din12_q_add_13_fac[i] <= (shift_din12_q_add_13[i]*fac8_1_re[0]) + (shift_din12_i_add_13[i]*fac8_1_im[0]);
                    shift_din12_q_sub_13_fac[i] <= (shift_din12_q_sub_13[i]*fac8_1_re[2]) + (shift_din12_i_sub_13[i]*fac8_1_im[2]);
                    shift_din12_i_add_14_fac[i] <= (shift_din12_i_add_14[i]*fac8_1_re[1]) - (shift_din12_q_add_14[i]*fac8_1_im[1]);
                    shift_din12_i_sub_14_fac[i] <= (shift_din12_i_sub_14[i]*fac8_1_re[3]) - (shift_din12_q_sub_14[i]*fac8_1_im[3]);
                    shift_din12_q_add_14_fac[i] <= (shift_din12_q_add_14[i]*fac8_1_re[1]) + (shift_din12_i_add_14[i]*fac8_1_im[1]);
                    shift_din12_q_sub_14_fac[i] <= (shift_din12_q_sub_14[i]*fac8_1_re[3]) + (shift_din12_i_sub_14[i]*fac8_1_im[3]);
                end
            end else if (m10_cnt == 17) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_15_fac[i] <= (shift_din12_i_add_15[i]*fac8_1_re[4]) - (shift_din12_q_add_15[i]*fac8_1_im[4]);
                    shift_din12_i_sub_15_fac[i] <= (shift_din12_i_sub_15[i]*fac8_1_re[6]) - (shift_din12_q_sub_15[i]*fac8_1_im[6]);
                    shift_din12_q_add_15_fac[i] <= (shift_din12_q_add_15[i]*fac8_1_re[4]) + (shift_din12_i_add_15[i]*fac8_1_im[4]);
                    shift_din12_q_sub_15_fac[i] <= (shift_din12_q_sub_15[i]*fac8_1_re[6]) + (shift_din12_i_sub_15[i]*fac8_1_im[6]);
                    shift_din12_i_add_16_fac[i] <= (shift_din12_i_add_16[i]*fac8_1_re[5]) - (shift_din12_q_add_16[i]*fac8_1_im[5]);
                    shift_din12_i_sub_16_fac[i] <= (shift_din12_i_sub_16[i]*fac8_1_re[7]) - (shift_din12_q_sub_16[i]*fac8_1_im[7]);
                    shift_din12_q_add_16_fac[i] <= (shift_din12_q_add_16[i]*fac8_1_re[5]) + (shift_din12_i_add_16[i]*fac8_1_im[5]);
                    shift_din12_q_sub_16_fac[i] <= (shift_din12_q_sub_16[i]*fac8_1_re[7]) + (shift_din12_i_sub_16[i]*fac8_1_im[7]);
                end
            end else if (m10_cnt == 19) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_1_fac[i] <= (shift_din12_i_add_1[i]*fac8_1_re[0]) - (shift_din12_q_add_1[i]*fac8_1_im[0]);
                    shift_din12_i_sub_1_fac[i] <= (shift_din12_i_sub_1[i]*fac8_1_re[2]) - (shift_din12_q_sub_1[i]*fac8_1_im[2]);
                    shift_din12_q_add_1_fac[i] <= (shift_din12_q_add_1[i]*fac8_1_re[0]) + (shift_din12_i_add_1[i]*fac8_1_im[0]);
                    shift_din12_q_sub_1_fac[i] <= (shift_din12_q_sub_1[i]*fac8_1_re[2]) + (shift_din12_i_sub_1[i]*fac8_1_im[2]);
                    shift_din12_i_add_2_fac[i] <= (shift_din12_i_add_2[i]*fac8_1_re[1]) - (shift_din12_q_add_2[i]*fac8_1_im[1]);
                    shift_din12_i_sub_2_fac[i] <= (shift_din12_i_sub_2[i]*fac8_1_re[3]) - (shift_din12_q_sub_2[i]*fac8_1_im[3]);
                    shift_din12_q_add_2_fac[i] <= (shift_din12_q_add_2[i]*fac8_1_re[1]) + (shift_din12_i_add_2[i]*fac8_1_im[1]);
                    shift_din12_q_sub_2_fac[i] <= (shift_din12_q_sub_2[i]*fac8_1_re[3]) + (shift_din12_i_sub_2[i]*fac8_1_im[3]);
                end
            end else if (m10_cnt == 21) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_3_fac[i] <= (shift_din12_i_add_3[i]*fac8_1_re[4]) - (shift_din12_q_add_3[i]*fac8_1_im[4]);
                    shift_din12_i_sub_3_fac[i] <= (shift_din12_i_sub_3[i]*fac8_1_re[6]) - (shift_din12_q_sub_3[i]*fac8_1_im[6]);
                    shift_din12_q_add_3_fac[i] <= (shift_din12_q_add_3[i]*fac8_1_re[4]) + (shift_din12_i_add_3[i]*fac8_1_im[4]);
                    shift_din12_q_sub_3_fac[i] <= (shift_din12_q_sub_3[i]*fac8_1_re[6]) + (shift_din12_i_sub_3[i]*fac8_1_im[6]);
                    shift_din12_i_add_4_fac[i] <= (shift_din12_i_add_4[i]*fac8_1_re[5]) - (shift_din12_q_add_4[i]*fac8_1_im[5]);
                    shift_din12_i_sub_4_fac[i] <= (shift_din12_i_sub_4[i]*fac8_1_re[7]) - (shift_din12_q_sub_4[i]*fac8_1_im[7]);
                    shift_din12_q_add_4_fac[i] <= (shift_din12_q_add_4[i]*fac8_1_re[5]) + (shift_din12_i_add_4[i]*fac8_1_im[5]);
                    shift_din12_q_sub_4_fac[i] <= (shift_din12_q_sub_4[i]*fac8_1_re[7]) + (shift_din12_i_sub_4[i]*fac8_1_im[7]);
                end
            end else if (m10_cnt == 23) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_5_fac[i] <= (shift_din12_i_add_5[i]*fac8_1_re[0]) - (shift_din12_q_add_5[i]*fac8_1_im[0]);
                    shift_din12_i_sub_5_fac[i] <= (shift_din12_i_sub_5[i]*fac8_1_re[2]) - (shift_din12_q_sub_5[i]*fac8_1_im[2]);
                    shift_din12_q_add_5_fac[i] <= (shift_din12_q_add_5[i]*fac8_1_re[0]) + (shift_din12_i_add_5[i]*fac8_1_im[0]);
                    shift_din12_q_sub_5_fac[i] <= (shift_din12_q_sub_5[i]*fac8_1_re[2]) + (shift_din12_i_sub_5[i]*fac8_1_im[2]);
                    shift_din12_i_add_6_fac[i] <= (shift_din12_i_add_6[i]*fac8_1_re[1]) - (shift_din12_q_add_6[i]*fac8_1_im[1]);
                    shift_din12_i_sub_6_fac[i] <= (shift_din12_i_sub_6[i]*fac8_1_re[3]) - (shift_din12_q_sub_6[i]*fac8_1_im[3]);
                    shift_din12_q_add_6_fac[i] <= (shift_din12_q_add_6[i]*fac8_1_re[1]) + (shift_din12_i_add_6[i]*fac8_1_im[1]);
                    shift_din12_q_sub_6_fac[i] <= (shift_din12_q_sub_6[i]*fac8_1_re[3]) + (shift_din12_i_sub_6[i]*fac8_1_im[3]);
                end
            end else if (m10_cnt == 25) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_7_fac[i] <= (shift_din12_i_add_7[i]*fac8_1_re[4]) - (shift_din12_q_add_7[i]*fac8_1_im[4]);
                    shift_din12_i_sub_7_fac[i] <= (shift_din12_i_sub_7[i]*fac8_1_re[6]) - (shift_din12_q_sub_7[i]*fac8_1_im[6]);
                    shift_din12_q_add_7_fac[i] <= (shift_din12_q_add_7[i]*fac8_1_re[4]) + (shift_din12_i_add_7[i]*fac8_1_im[4]);
                    shift_din12_q_sub_7_fac[i] <= (shift_din12_q_sub_7[i]*fac8_1_re[6]) + (shift_din12_i_sub_7[i]*fac8_1_im[6]);
                    shift_din12_i_add_8_fac[i] <= (shift_din12_i_add_8[i]*fac8_1_re[5]) - (shift_din12_q_add_8[i]*fac8_1_im[5]);
                    shift_din12_i_sub_8_fac[i] <= (shift_din12_i_sub_8[i]*fac8_1_re[7]) - (shift_din12_q_sub_8[i]*fac8_1_im[7]);
                    shift_din12_q_add_8_fac[i] <= (shift_din12_q_add_8[i]*fac8_1_re[5]) + (shift_din12_i_add_8[i]*fac8_1_im[5]);
                    shift_din12_q_sub_8_fac[i] <= (shift_din12_q_sub_8[i]*fac8_1_re[7]) + (shift_din12_i_sub_8[i]*fac8_1_im[7]);
                end
            end else if (m10_cnt == 27) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_9_fac[i] <= (shift_din12_i_add_9[i]*fac8_1_re[0]) - (shift_din12_q_add_9[i]*fac8_1_im[0]);
                    shift_din12_i_sub_9_fac[i] <= (shift_din12_i_sub_9[i]*fac8_1_re[2]) - (shift_din12_q_sub_9[i]*fac8_1_im[2]);
                    shift_din12_q_add_9_fac[i] <= (shift_din12_q_add_9[i]*fac8_1_re[0]) + (shift_din12_i_add_9[i]*fac8_1_im[0]);
                    shift_din12_q_sub_9_fac[i] <= (shift_din12_q_sub_9[i]*fac8_1_re[2]) + (shift_din12_i_sub_9[i]*fac8_1_im[2]);
                    shift_din12_i_add_10_fac[i] <= (shift_din12_i_add_10[i]*fac8_1_re[1]) - (shift_din12_q_add_10[i]*fac8_1_im[1]);
                    shift_din12_i_sub_10_fac[i] <= (shift_din12_i_sub_10[i]*fac8_1_re[3]) - (shift_din12_q_sub_10[i]*fac8_1_im[3]);
                    shift_din12_q_add_10_fac[i] <= (shift_din12_q_add_10[i]*fac8_1_re[1]) + (shift_din12_i_add_10[i]*fac8_1_im[1]);
                    shift_din12_q_sub_10_fac[i] <= (shift_din12_q_sub_10[i]*fac8_1_re[3]) + (shift_din12_i_sub_10[i]*fac8_1_im[3]);
                end
            end else if (m10_cnt == 29) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_11_fac[i] <= (shift_din12_i_add_11[i]*fac8_1_re[4]) - (shift_din12_q_add_11[i]*fac8_1_im[4]);
                    shift_din12_i_sub_11_fac[i] <= (shift_din12_i_sub_11[i]*fac8_1_re[6]) - (shift_din12_q_sub_11[i]*fac8_1_im[6]);
                    shift_din12_q_add_11_fac[i] <= (shift_din12_q_add_11[i]*fac8_1_re[4]) + (shift_din12_i_add_11[i]*fac8_1_im[4]);
                    shift_din12_q_sub_11_fac[i] <= (shift_din12_q_sub_11[i]*fac8_1_re[6]) + (shift_din12_i_sub_11[i]*fac8_1_im[6]);
                    shift_din12_i_add_12_fac[i] <= (shift_din12_i_add_12[i]*fac8_1_re[5]) - (shift_din12_q_add_12[i]*fac8_1_im[5]);
                    shift_din12_i_sub_12_fac[i] <= (shift_din12_i_sub_12[i]*fac8_1_re[7]) - (shift_din12_q_sub_12[i]*fac8_1_im[7]);
                    shift_din12_q_add_12_fac[i] <= (shift_din12_q_add_12[i]*fac8_1_re[5]) + (shift_din12_i_add_12[i]*fac8_1_im[5]);
                    shift_din12_q_sub_12_fac[i] <= (shift_din12_q_sub_12[i]*fac8_1_re[7]) + (shift_din12_i_sub_12[i]*fac8_1_im[7]);
                end
            end else if (m10_cnt == 31) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_13_fac[i] <= (shift_din12_i_add_13[i]*fac8_1_re[0]) - (shift_din12_q_add_13[i]*fac8_1_im[0]);
                    shift_din12_i_sub_13_fac[i] <= (shift_din12_i_sub_13[i]*fac8_1_re[2]) - (shift_din12_q_sub_13[i]*fac8_1_im[2]);
                    shift_din12_q_add_13_fac[i] <= (shift_din12_q_add_13[i]*fac8_1_re[0]) + (shift_din12_i_add_13[i]*fac8_1_im[0]);
                    shift_din12_q_sub_13_fac[i] <= (shift_din12_q_sub_13[i]*fac8_1_re[2]) + (shift_din12_i_sub_13[i]*fac8_1_im[2]);
                    shift_din12_i_add_14_fac[i] <= (shift_din12_i_add_14[i]*fac8_1_re[1]) - (shift_din12_q_add_14[i]*fac8_1_im[1]);
                    shift_din12_i_sub_14_fac[i] <= (shift_din12_i_sub_14[i]*fac8_1_re[3]) - (shift_din12_q_sub_14[i]*fac8_1_im[3]);
                    shift_din12_q_add_14_fac[i] <= (shift_din12_q_add_14[i]*fac8_1_re[1]) + (shift_din12_i_add_14[i]*fac8_1_im[1]);
                    shift_din12_q_sub_14_fac[i] <= (shift_din12_q_sub_14[i]*fac8_1_re[3]) + (shift_din12_i_sub_14[i]*fac8_1_im[3]);
                end
            end else if (m10_cnt == 33) begin
                for (i = 0; i <= 7; i = i + 1) begin
                    shift_din12_i_add_15_fac[i] <= (shift_din12_i_add_15[i]*fac8_1_re[4]) - (shift_din12_q_add_15[i]*fac8_1_im[4]);
                    shift_din12_i_sub_15_fac[i] <= (shift_din12_i_sub_15[i]*fac8_1_re[6]) - (shift_din12_q_sub_15[i]*fac8_1_im[6]);
                    shift_din12_q_add_15_fac[i] <= (shift_din12_q_add_15[i]*fac8_1_re[4]) + (shift_din12_i_add_15[i]*fac8_1_im[4]);
                    shift_din12_q_sub_15_fac[i] <= (shift_din12_q_sub_15[i]*fac8_1_re[6]) + (shift_din12_i_sub_15[i]*fac8_1_im[6]);
                    shift_din12_i_add_16_fac[i] <= (shift_din12_i_add_16[i]*fac8_1_re[5]) - (shift_din12_q_add_16[i]*fac8_1_im[5]);
                    shift_din12_i_sub_16_fac[i] <= (shift_din12_i_sub_16[i]*fac8_1_re[7]) - (shift_din12_q_sub_16[i]*fac8_1_im[7]);
                    shift_din12_q_add_16_fac[i] <= (shift_din12_q_add_16[i]*fac8_1_re[5]) + (shift_din12_i_add_16[i]*fac8_1_im[5]);
                    shift_din12_q_sub_16_fac[i] <= (shift_din12_q_sub_16[i]*fac8_1_re[7]) + (shift_din12_i_sub_16[i]*fac8_1_im[7]);
                end
            end
        end
    end

    always @(posedge clk, negedge rstn) begin
        if (~rstn) begin
            for (i = 3; i >= 0; i = i - 1) begin
                shift_din20_i_add_1[i]  <= 0;
                shift_din20_i_add_2[i]  <= 0;
                shift_din20_i_add_3[i]  <= 0;
                shift_din20_i_add_4[i]  <= 0;
                shift_din20_i_add_5[i]  <= 0;
                shift_din20_i_add_6[i]  <= 0;
                shift_din20_i_add_7[i]  <= 0;
                shift_din20_i_add_8[i]  <= 0;
                shift_din20_i_add_9[i]  <= 0;
                shift_din20_i_add_10[i] <= 0;
                shift_din20_i_add_11[i] <= 0;
                shift_din20_i_add_12[i] <= 0;
                shift_din20_i_add_13[i] <= 0;
                shift_din20_i_add_14[i] <= 0;
                shift_din20_i_add_15[i] <= 0;
                shift_din20_i_add_16[i] <= 0;
                shift_din20_i_sub_1[i]  <= 0;
                shift_din20_i_sub_2[i]  <= 0;
                shift_din20_i_sub_3[i]  <= 0;
                shift_din20_i_sub_4[i]  <= 0;
                shift_din20_i_sub_5[i]  <= 0;
                shift_din20_i_sub_6[i]  <= 0;
                shift_din20_i_sub_7[i]  <= 0;
                shift_din20_i_sub_8[i]  <= 0;
                shift_din20_i_sub_9[i]  <= 0;
                shift_din20_i_sub_10[i] <= 0;
                shift_din20_i_sub_11[i] <= 0;
                shift_din20_i_sub_12[i] <= 0;
                shift_din20_i_sub_13[i] <= 0;
                shift_din20_i_sub_14[i] <= 0;
                shift_din20_i_sub_15[i] <= 0;
                shift_din20_i_sub_16[i] <= 0;
                shift_din20_i_add_17[i] <= 0;
                shift_din20_i_add_18[i] <= 0;
                shift_din20_i_add_19[i] <= 0;
                shift_din20_i_add_20[i] <= 0;
                shift_din20_i_add_21[i] <= 0;
                shift_din20_i_add_22[i] <= 0;
                shift_din20_i_add_23[i] <= 0;
                shift_din20_i_add_24[i] <= 0;
                shift_din20_i_add_25[i] <= 0;
                shift_din20_i_add_26[i] <= 0;
                shift_din20_i_add_27[i] <= 0;
                shift_din20_i_add_28[i] <= 0;
                shift_din20_i_add_29[i] <= 0;
                shift_din20_i_add_30[i] <= 0;
                shift_din20_i_add_31[i] <= 0;
                shift_din20_i_add_32[i] <= 0;
                shift_din20_i_sub_17[i] <= 0;
                shift_din20_i_sub_18[i] <= 0;
                shift_din20_i_sub_19[i] <= 0;
                shift_din20_i_sub_20[i] <= 0;
                shift_din20_i_sub_21[i] <= 0;
                shift_din20_i_sub_22[i] <= 0;
                shift_din20_i_sub_23[i] <= 0;
                shift_din20_i_sub_24[i] <= 0;
                shift_din20_i_sub_25[i] <= 0;
                shift_din20_i_sub_26[i] <= 0;
                shift_din20_i_sub_27[i] <= 0;
                shift_din20_i_sub_28[i] <= 0;
                shift_din20_i_sub_29[i] <= 0;
                shift_din20_i_sub_30[i] <= 0;
                shift_din20_i_sub_31[i] <= 0;
                shift_din20_i_sub_32[i] <= 0;
                shift_din20_q_add_1[i]  <= 0;
                shift_din20_q_add_2[i]  <= 0;
                shift_din20_q_add_3[i]  <= 0;
                shift_din20_q_add_4[i]  <= 0;
                shift_din20_q_add_5[i]  <= 0;
                shift_din20_q_add_6[i]  <= 0;
                shift_din20_q_add_7[i]  <= 0;
                shift_din20_q_add_8[i]  <= 0;
                shift_din20_q_add_9[i]  <= 0;
                shift_din20_q_add_10[i] <= 0;
                shift_din20_q_add_11[i] <= 0;
                shift_din20_q_add_12[i] <= 0;
                shift_din20_q_add_13[i] <= 0;
                shift_din20_q_add_14[i] <= 0;
                shift_din20_q_add_15[i] <= 0;
                shift_din20_q_add_16[i] <= 0;
                shift_din20_q_sub_1[i]  <= 0;
                shift_din20_q_sub_2[i]  <= 0;
                shift_din20_q_sub_3[i]  <= 0;
                shift_din20_q_sub_4[i]  <= 0;
                shift_din20_q_sub_5[i]  <= 0;
                shift_din20_q_sub_6[i]  <= 0;
                shift_din20_q_sub_7[i]  <= 0;
                shift_din20_q_sub_8[i]  <= 0;
                shift_din20_q_sub_9[i]  <= 0;
                shift_din20_q_sub_10[i] <= 0;
                shift_din20_q_sub_11[i] <= 0;
                shift_din20_q_sub_12[i] <= 0;
                shift_din20_q_sub_13[i] <= 0;
                shift_din20_q_sub_14[i] <= 0;
                shift_din20_q_sub_15[i] <= 0;
                shift_din20_q_sub_16[i] <= 0;
                shift_din20_q_add_17[i] <= 0;
                shift_din20_q_add_18[i] <= 0;
                shift_din20_q_add_19[i] <= 0;
                shift_din20_q_add_20[i] <= 0;
                shift_din20_q_add_21[i] <= 0;
                shift_din20_q_add_22[i] <= 0;
                shift_din20_q_add_23[i] <= 0;
                shift_din20_q_add_24[i] <= 0;
                shift_din20_q_add_25[i] <= 0;
                shift_din20_q_add_26[i] <= 0;
                shift_din20_q_add_27[i] <= 0;
                shift_din20_q_add_28[i] <= 0;
                shift_din20_q_add_29[i] <= 0;
                shift_din20_q_add_30[i] <= 0;
                shift_din20_q_add_31[i] <= 0;
                shift_din20_q_add_32[i] <= 0;
                shift_din20_q_sub_17[i] <= 0;
                shift_din20_q_sub_18[i] <= 0;
                shift_din20_q_sub_19[i] <= 0;
                shift_din20_q_sub_20[i] <= 0;
                shift_din20_q_sub_21[i] <= 0;
                shift_din20_q_sub_22[i] <= 0;
                shift_din20_q_sub_23[i] <= 0;
                shift_din20_q_sub_24[i] <= 0;
                shift_din20_q_sub_25[i] <= 0;
                shift_din20_q_sub_26[i] <= 0;
                shift_din20_q_sub_27[i] <= 0;
                shift_din20_q_sub_28[i] <= 0;
                shift_din20_q_sub_29[i] <= 0;
                shift_din20_q_sub_30[i] <= 0;
                shift_din20_q_sub_31[i] <= 0;
                shift_din20_q_sub_32[i] <= 0;
            end
        end else begin

            if (m10_cnt == 4) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_1[i] <= w_shift_din12_i_add_1_fac[i] + w_shift_din12_i_add_2_fac[i];
                    shift_din20_i_sub_1[i] <= w_shift_din12_i_add_1_fac[i] - w_shift_din12_i_add_2_fac[i];
                    shift_din20_q_add_1[i] <= w_shift_din12_q_add_1_fac[i] + w_shift_din12_q_add_2_fac[i];
                    shift_din20_q_sub_1[i] <= w_shift_din12_q_add_1_fac[i] - w_shift_din12_q_add_2_fac[i];
                    shift_din20_i_add_2[i] <= w_shift_din12_i_add_1_fac[4+i] + w_shift_din12_i_add_2_fac[4+i];
                    shift_din20_i_sub_2[i] <= w_shift_din12_i_add_1_fac[4+i] - w_shift_din12_i_add_2_fac[4+i];
                    shift_din20_q_add_2[i] <= w_shift_din12_q_add_1_fac[4+i] + w_shift_din12_q_add_2_fac[4+i];
                    shift_din20_q_sub_2[i] <= w_shift_din12_q_add_1_fac[4+i] - w_shift_din12_q_add_2_fac[4+i];
                end
            end else if (m10_cnt == 5) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_3[i] <= w_shift_din12_i_sub_1_fac[i] + w_shift_din12_i_sub_2_fac[i];
                    shift_din20_i_sub_3[i] <= w_shift_din12_i_sub_1_fac[i] - w_shift_din12_i_sub_2_fac[i];
                    shift_din20_q_add_3[i] <= w_shift_din12_q_sub_1_fac[i] + w_shift_din12_q_sub_2_fac[i];
                    shift_din20_q_sub_3[i] <= w_shift_din12_q_sub_1_fac[i] - w_shift_din12_q_sub_2_fac[i];
                    shift_din20_i_add_4[i] <= w_shift_din12_i_sub_1_fac[4+i] + w_shift_din12_i_sub_2_fac[4+i];
                    shift_din20_i_sub_4[i] <= w_shift_din12_i_sub_1_fac[4+i] - w_shift_din12_i_sub_2_fac[4+i];
                    shift_din20_q_add_4[i] <= w_shift_din12_q_sub_1_fac[4+i] + w_shift_din12_q_sub_2_fac[4+i];
                    shift_din20_q_sub_4[i] <= w_shift_din12_q_sub_1_fac[4+i] - w_shift_din12_q_sub_2_fac[4+i];
                end
            end else if (m10_cnt == 6) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_5[i] <= w_shift_din12_i_add_3_fac[i] + w_shift_din12_i_add_4_fac[i];
                    shift_din20_i_sub_5[i] <= w_shift_din12_i_add_3_fac[i] - w_shift_din12_i_add_4_fac[i];
                    shift_din20_q_add_5[i] <= w_shift_din12_q_add_3_fac[i] + w_shift_din12_q_add_4_fac[i];
                    shift_din20_q_sub_5[i] <= w_shift_din12_q_add_3_fac[i] - w_shift_din12_q_add_4_fac[i];
                    shift_din20_i_add_6[i] <= w_shift_din12_i_add_3_fac[4+i] + w_shift_din12_i_add_4_fac[4+i];
                    shift_din20_i_sub_6[i] <= w_shift_din12_i_add_3_fac[4+i] - w_shift_din12_i_add_4_fac[4+i];
                    shift_din20_q_add_6[i] <= w_shift_din12_q_add_3_fac[4+i] + w_shift_din12_q_add_4_fac[4+i];
                    shift_din20_q_sub_6[i] <= w_shift_din12_q_add_3_fac[4+i] - w_shift_din12_q_add_4_fac[4+i];
                end
            end else if (m10_cnt == 7) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_7[i] <= w_shift_din12_i_sub_3_fac[i] + w_shift_din12_i_sub_4_fac[i];
                    shift_din20_i_sub_7[i] <= w_shift_din12_i_sub_3_fac[i] - w_shift_din12_i_sub_4_fac[i];
                    shift_din20_q_add_7[i] <= w_shift_din12_q_sub_3_fac[i] + w_shift_din12_q_sub_4_fac[i];
                    shift_din20_q_sub_7[i] <= w_shift_din12_q_sub_3_fac[i] - w_shift_din12_q_sub_4_fac[i];
                    shift_din20_i_add_8[i] <= w_shift_din12_i_sub_3_fac[4+i] + w_shift_din12_i_sub_4_fac[4+i];
                    shift_din20_i_sub_8[i] <= w_shift_din12_i_sub_3_fac[4+i] - w_shift_din12_i_sub_4_fac[4+i];
                    shift_din20_q_add_8[i] <= w_shift_din12_q_sub_3_fac[4+i] + w_shift_din12_q_sub_4_fac[4+i];
                    shift_din20_q_sub_8[i] <= w_shift_din12_q_sub_3_fac[4+i] - w_shift_din12_q_sub_4_fac[4+i];
                end
            end else if (m10_cnt == 8) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_9[i] <= w_shift_din12_i_add_5_fac[i] + w_shift_din12_i_add_6_fac[i];
                    shift_din20_i_sub_9[i] <= w_shift_din12_i_add_5_fac[i] - w_shift_din12_i_add_6_fac[i];
                    shift_din20_q_add_9[i] <= w_shift_din12_q_add_5_fac[i] + w_shift_din12_q_add_6_fac[i];
                    shift_din20_q_sub_9[i] <= w_shift_din12_q_add_5_fac[i] - w_shift_din12_q_add_6_fac[i];
                    shift_din20_i_add_10[i] <= w_shift_din12_i_add_5_fac[4+i] + w_shift_din12_i_add_6_fac[4+i];
                    shift_din20_i_sub_10[i] <= w_shift_din12_i_add_5_fac[4+i] - w_shift_din12_i_add_6_fac[4+i];
                    shift_din20_q_add_10[i] <= w_shift_din12_q_add_5_fac[4+i] + w_shift_din12_q_add_6_fac[4+i];
                    shift_din20_q_sub_10[i] <= w_shift_din12_q_add_5_fac[4+i] - w_shift_din12_q_add_6_fac[4+i];
                end
            end else if (m10_cnt == 9) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_11[i] <= w_shift_din12_i_sub_5_fac[i] + w_shift_din12_i_sub_6_fac[i];
                    shift_din20_i_sub_11[i] <= w_shift_din12_i_sub_5_fac[i] - w_shift_din12_i_sub_6_fac[i];
                    shift_din20_q_add_11[i] <= w_shift_din12_q_sub_5_fac[i] + w_shift_din12_q_sub_6_fac[i];
                    shift_din20_q_sub_11[i] <= w_shift_din12_q_sub_5_fac[i] - w_shift_din12_q_sub_6_fac[i];
                    shift_din20_i_add_12[i] <= w_shift_din12_i_sub_5_fac[4+i] + w_shift_din12_i_sub_6_fac[4+i];
                    shift_din20_i_sub_12[i] <= w_shift_din12_i_sub_5_fac[4+i] - w_shift_din12_i_sub_6_fac[4+i];
                    shift_din20_q_add_12[i] <= w_shift_din12_q_sub_5_fac[4+i] + w_shift_din12_q_sub_6_fac[4+i];
                    shift_din20_q_sub_12[i] <= w_shift_din12_q_sub_5_fac[4+i] - w_shift_din12_q_sub_6_fac[4+i];
                end
            end else if (m10_cnt == 10) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_13[i] <= w_shift_din12_i_add_7_fac[i] + w_shift_din12_i_add_8_fac[i];
                    shift_din20_i_sub_13[i] <= w_shift_din12_i_add_7_fac[i] - w_shift_din12_i_add_8_fac[i];
                    shift_din20_q_add_13[i] <= w_shift_din12_q_add_7_fac[i] + w_shift_din12_q_add_8_fac[i];
                    shift_din20_q_sub_13[i] <= w_shift_din12_q_add_7_fac[i] - w_shift_din12_q_add_8_fac[i];
                    shift_din20_i_add_14[i] <= w_shift_din12_i_add_7_fac[4+i] + w_shift_din12_i_add_8_fac[4+i];
                    shift_din20_i_sub_14[i] <= w_shift_din12_i_add_7_fac[4+i] - w_shift_din12_i_add_8_fac[4+i];
                    shift_din20_q_add_14[i] <= w_shift_din12_q_add_7_fac[4+i] + w_shift_din12_q_add_8_fac[4+i];
                    shift_din20_q_sub_14[i] <= w_shift_din12_q_add_7_fac[4+i] - w_shift_din12_q_add_8_fac[4+i];
                end
            end else if (m10_cnt == 11) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_15[i] <= w_shift_din12_i_sub_7_fac[i] + w_shift_din12_i_sub_8_fac[i];
                    shift_din20_i_sub_15[i] <= w_shift_din12_i_sub_7_fac[i] - w_shift_din12_i_sub_8_fac[i];
                    shift_din20_q_add_15[i] <= w_shift_din12_q_sub_7_fac[i] + w_shift_din12_q_sub_8_fac[i];
                    shift_din20_q_sub_15[i] <= w_shift_din12_q_sub_7_fac[i] - w_shift_din12_q_sub_8_fac[i];
                    shift_din20_i_add_16[i] <= w_shift_din12_i_sub_7_fac[4+i] + w_shift_din12_i_sub_8_fac[4+i];
                    shift_din20_i_sub_16[i] <= w_shift_din12_i_sub_7_fac[4+i] - w_shift_din12_i_sub_8_fac[4+i];
                    shift_din20_q_add_16[i] <= w_shift_din12_q_sub_7_fac[4+i] + w_shift_din12_q_sub_8_fac[4+i];
                    shift_din20_q_sub_16[i] <= w_shift_din12_q_sub_7_fac[4+i] - w_shift_din12_q_sub_8_fac[4+i];
                end
            end else if (m10_cnt == 12) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_17[i] <= w_shift_din12_i_add_9_fac[i] + w_shift_din12_i_add_10_fac[i];
                    shift_din20_i_sub_17[i] <= w_shift_din12_i_add_9_fac[i] - w_shift_din12_i_add_10_fac[i];
                    shift_din20_q_add_17[i] <= w_shift_din12_q_add_9_fac[i] + w_shift_din12_q_add_10_fac[i];
                    shift_din20_q_sub_17[i] <= w_shift_din12_q_add_9_fac[i] - w_shift_din12_q_add_10_fac[i];
                    shift_din20_i_add_18[i] <= w_shift_din12_i_add_9_fac[4+i] + w_shift_din12_i_add_10_fac[4+i];
                    shift_din20_i_sub_18[i] <= w_shift_din12_i_add_9_fac[4+i] - w_shift_din12_i_add_10_fac[4+i];
                    shift_din20_q_add_18[i] <= w_shift_din12_q_add_9_fac[4+i] + w_shift_din12_q_add_10_fac[4+i];
                    shift_din20_q_sub_18[i] <= w_shift_din12_q_add_9_fac[4+i] - w_shift_din12_q_add_10_fac[4+i];
                end
            end else if (m10_cnt == 13) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_19[i] <= w_shift_din12_i_sub_9_fac[i] + w_shift_din12_i_sub_10_fac[i];
                    shift_din20_i_sub_19[i] <= w_shift_din12_i_sub_9_fac[i] - w_shift_din12_i_sub_10_fac[i];
                    shift_din20_q_add_19[i] <= w_shift_din12_q_sub_9_fac[i] + w_shift_din12_q_sub_10_fac[i];
                    shift_din20_q_sub_19[i] <= w_shift_din12_q_sub_9_fac[i] - w_shift_din12_q_sub_10_fac[i];
                    shift_din20_i_add_20[i] <= w_shift_din12_i_sub_9_fac[4+i] + w_shift_din12_i_sub_10_fac[4+i];
                    shift_din20_i_sub_20[i] <= w_shift_din12_i_sub_9_fac[4+i] - w_shift_din12_i_sub_10_fac[4+i];
                    shift_din20_q_add_20[i] <= w_shift_din12_q_sub_9_fac[4+i] + w_shift_din12_q_sub_10_fac[4+i];
                    shift_din20_q_sub_20[i] <= w_shift_din12_q_sub_9_fac[4+i] - w_shift_din12_q_sub_10_fac[4+i];
                end
            end else if (m10_cnt == 14) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_21[i] <= w_shift_din12_i_add_11_fac[i] + w_shift_din12_i_add_12_fac[i];
                    shift_din20_i_sub_21[i] <= w_shift_din12_i_add_11_fac[i] - w_shift_din12_i_add_12_fac[i];
                    shift_din20_q_add_21[i] <= w_shift_din12_q_add_11_fac[i] + w_shift_din12_q_add_12_fac[i];
                    shift_din20_q_sub_21[i] <= w_shift_din12_q_add_11_fac[i] - w_shift_din12_q_add_12_fac[i];
                    shift_din20_i_add_22[i] <= w_shift_din12_i_add_11_fac[4+i] + w_shift_din12_i_add_12_fac[4+i];
                    shift_din20_i_sub_22[i] <= w_shift_din12_i_add_11_fac[4+i] - w_shift_din12_i_add_12_fac[4+i];
                    shift_din20_q_add_22[i] <= w_shift_din12_q_add_11_fac[4+i] + w_shift_din12_q_add_12_fac[4+i];
                    shift_din20_q_sub_22[i] <= w_shift_din12_q_add_11_fac[4+i] - w_shift_din12_q_add_12_fac[4+i];
                end
            end else if (m10_cnt == 15) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_23[i] <= w_shift_din12_i_sub_11_fac[i] + w_shift_din12_i_sub_12_fac[i];
                    shift_din20_i_sub_23[i] <= w_shift_din12_i_sub_11_fac[i] - w_shift_din12_i_sub_12_fac[i];
                    shift_din20_q_add_23[i] <= w_shift_din12_q_sub_11_fac[i] + w_shift_din12_q_sub_12_fac[i];
                    shift_din20_q_sub_23[i] <= w_shift_din12_q_sub_11_fac[i] - w_shift_din12_q_sub_12_fac[i];
                    shift_din20_i_add_24[i] <= w_shift_din12_i_sub_11_fac[4+i] + w_shift_din12_i_sub_12_fac[4+i];
                    shift_din20_i_sub_24[i] <= w_shift_din12_i_sub_11_fac[4+i] - w_shift_din12_i_sub_12_fac[4+i];
                    shift_din20_q_add_24[i] <= w_shift_din12_q_sub_11_fac[4+i] + w_shift_din12_q_sub_12_fac[4+i];
                    shift_din20_q_sub_24[i] <= w_shift_din12_q_sub_11_fac[4+i] - w_shift_din12_q_sub_12_fac[4+i];
                end
            end else if (m10_cnt == 16) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_25[i] <= w_shift_din12_i_add_13_fac[i] + w_shift_din12_i_add_14_fac[i];
                    shift_din20_i_sub_25[i] <= w_shift_din12_i_add_13_fac[i] - w_shift_din12_i_add_14_fac[i];
                    shift_din20_q_add_25[i] <= w_shift_din12_q_add_13_fac[i] + w_shift_din12_q_add_14_fac[i];
                    shift_din20_q_sub_25[i] <= w_shift_din12_q_add_13_fac[i] - w_shift_din12_q_add_14_fac[i];
                    shift_din20_i_add_26[i] <= w_shift_din12_i_add_13_fac[4+i] + w_shift_din12_i_add_14_fac[4+i];
                    shift_din20_i_sub_26[i] <= w_shift_din12_i_add_13_fac[4+i] - w_shift_din12_i_add_14_fac[4+i];
                    shift_din20_q_add_26[i] <= w_shift_din12_q_add_13_fac[4+i] + w_shift_din12_q_add_14_fac[4+i];
                    shift_din20_q_sub_26[i] <= w_shift_din12_q_add_13_fac[4+i] - w_shift_din12_q_add_14_fac[4+i];
                end
            end else if (m10_cnt == 17) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_27[i] <= w_shift_din12_i_sub_13_fac[i] + w_shift_din12_i_sub_14_fac[i];
                    shift_din20_i_sub_27[i] <= w_shift_din12_i_sub_13_fac[i] - w_shift_din12_i_sub_14_fac[i];
                    shift_din20_q_add_27[i] <= w_shift_din12_q_sub_13_fac[i] + w_shift_din12_q_sub_14_fac[i];
                    shift_din20_q_sub_27[i] <= w_shift_din12_q_sub_13_fac[i] - w_shift_din12_q_sub_14_fac[i];
                    shift_din20_i_add_28[i] <= w_shift_din12_i_sub_13_fac[4+i] + w_shift_din12_i_sub_14_fac[4+i];
                    shift_din20_i_sub_28[i] <= w_shift_din12_i_sub_13_fac[4+i] - w_shift_din12_i_sub_14_fac[4+i];
                    shift_din20_q_add_28[i] <= w_shift_din12_q_sub_13_fac[4+i] + w_shift_din12_q_sub_14_fac[4+i];
                    shift_din20_q_sub_28[i] <= w_shift_din12_q_sub_13_fac[4+i] - w_shift_din12_q_sub_14_fac[4+i];
                end
            end else if (m10_cnt == 18) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_29[i] <= w_shift_din12_i_add_15_fac[i] + w_shift_din12_i_add_16_fac[i];
                    shift_din20_i_sub_29[i] <= w_shift_din12_i_add_15_fac[i] - w_shift_din12_i_add_16_fac[i];
                    shift_din20_q_add_29[i] <= w_shift_din12_q_add_15_fac[i] + w_shift_din12_q_add_16_fac[i];
                    shift_din20_q_sub_29[i] <= w_shift_din12_q_add_15_fac[i] - w_shift_din12_q_add_16_fac[i];
                    shift_din20_i_add_30[i] <= w_shift_din12_i_add_15_fac[4+i] + w_shift_din12_i_add_16_fac[4+i];
                    shift_din20_i_sub_30[i] <= w_shift_din12_i_add_15_fac[4+i] - w_shift_din12_i_add_16_fac[4+i];
                    shift_din20_q_add_30[i] <= w_shift_din12_q_add_15_fac[4+i] + w_shift_din12_q_add_16_fac[4+i];
                    shift_din20_q_sub_30[i] <= w_shift_din12_q_add_15_fac[4+i] - w_shift_din12_q_add_16_fac[4+i];
                end
            end else if (m10_cnt == 19) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_31[i] <= w_shift_din12_i_sub_15_fac[i] + w_shift_din12_i_sub_16_fac[i];
                    shift_din20_i_sub_31[i] <= w_shift_din12_i_sub_15_fac[i] - w_shift_din12_i_sub_16_fac[i];
                    shift_din20_q_add_31[i] <= w_shift_din12_q_sub_15_fac[i] + w_shift_din12_q_sub_16_fac[i];
                    shift_din20_q_sub_31[i] <= w_shift_din12_q_sub_15_fac[i] - w_shift_din12_q_sub_16_fac[i];
                    shift_din20_i_add_32[i] <= w_shift_din12_i_sub_15_fac[4+i] + w_shift_din12_i_sub_16_fac[4+i];
                    shift_din20_i_sub_32[i] <= w_shift_din12_i_sub_15_fac[4+i] - w_shift_din12_i_sub_16_fac[4+i];
                    shift_din20_q_add_32[i] <= w_shift_din12_q_sub_15_fac[4+i] + w_shift_din12_q_sub_16_fac[4+i];
                    shift_din20_q_sub_32[i] <= w_shift_din12_q_sub_15_fac[4+i] - w_shift_din12_q_sub_16_fac[4+i];
                end
            end else if (m10_cnt == 20) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_1[i] <= w_shift_din12_i_add_1_fac[i] + w_shift_din12_i_add_2_fac[i];
                    shift_din20_i_sub_1[i] <= w_shift_din12_i_add_1_fac[i] - w_shift_din12_i_add_2_fac[i];
                    shift_din20_q_add_1[i] <= w_shift_din12_q_add_1_fac[i] + w_shift_din12_q_add_2_fac[i];
                    shift_din20_q_sub_1[i] <= w_shift_din12_q_add_1_fac[i] - w_shift_din12_q_add_2_fac[i];
                    shift_din20_i_add_2[i] <= w_shift_din12_i_add_1_fac[4+i] + w_shift_din12_i_add_2_fac[4+i];
                    shift_din20_i_sub_2[i] <= w_shift_din12_i_add_1_fac[4+i] - w_shift_din12_i_add_2_fac[4+i];
                    shift_din20_q_add_2[i] <= w_shift_din12_q_add_1_fac[4+i] + w_shift_din12_q_add_2_fac[4+i];
                    shift_din20_q_sub_2[i] <= w_shift_din12_q_add_1_fac[4+i] - w_shift_din12_q_add_2_fac[4+i];
                end
            end else if (m10_cnt == 21) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_3[i] <= w_shift_din12_i_sub_1_fac[i] + w_shift_din12_i_sub_2_fac[i];
                    shift_din20_i_sub_3[i] <= w_shift_din12_i_sub_1_fac[i] - w_shift_din12_i_sub_2_fac[i];
                    shift_din20_q_add_3[i] <= w_shift_din12_q_sub_1_fac[i] + w_shift_din12_q_sub_2_fac[i];
                    shift_din20_q_sub_3[i] <= w_shift_din12_q_sub_1_fac[i] - w_shift_din12_q_sub_2_fac[i];
                    shift_din20_i_add_4[i] <= w_shift_din12_i_sub_1_fac[4+i] + w_shift_din12_i_sub_2_fac[4+i];
                    shift_din20_i_sub_4[i] <= w_shift_din12_i_sub_1_fac[4+i] - w_shift_din12_i_sub_2_fac[4+i];
                    shift_din20_q_add_4[i] <= w_shift_din12_q_sub_1_fac[4+i] + w_shift_din12_q_sub_2_fac[4+i];
                    shift_din20_q_sub_4[i] <= w_shift_din12_q_sub_1_fac[4+i] - w_shift_din12_q_sub_2_fac[4+i];
                end
            end else if (m10_cnt == 22) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_5[i] <= w_shift_din12_i_add_3_fac[i] + w_shift_din12_i_add_4_fac[i];
                    shift_din20_i_sub_5[i] <= w_shift_din12_i_add_3_fac[i] - w_shift_din12_i_add_4_fac[i];
                    shift_din20_q_add_5[i] <= w_shift_din12_q_add_3_fac[i] + w_shift_din12_q_add_4_fac[i];
                    shift_din20_q_sub_5[i] <= w_shift_din12_q_add_3_fac[i] - w_shift_din12_q_add_4_fac[i];
                    shift_din20_i_add_6[i] <= w_shift_din12_i_add_3_fac[4+i] + w_shift_din12_i_add_4_fac[4+i];
                    shift_din20_i_sub_6[i] <= w_shift_din12_i_add_3_fac[4+i] - w_shift_din12_i_add_4_fac[4+i];
                    shift_din20_q_add_6[i] <= w_shift_din12_q_add_3_fac[4+i] + w_shift_din12_q_add_4_fac[4+i];
                    shift_din20_q_sub_6[i] <= w_shift_din12_q_add_3_fac[4+i] - w_shift_din12_q_add_4_fac[4+i];
                end
            end else if (m10_cnt == 23) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_7[i] <= w_shift_din12_i_sub_3_fac[i] + w_shift_din12_i_sub_4_fac[i];
                    shift_din20_i_sub_7[i] <= w_shift_din12_i_sub_3_fac[i] - w_shift_din12_i_sub_4_fac[i];
                    shift_din20_q_add_7[i] <= w_shift_din12_q_sub_3_fac[i] + w_shift_din12_q_sub_4_fac[i];
                    shift_din20_q_sub_7[i] <= w_shift_din12_q_sub_3_fac[i] - w_shift_din12_q_sub_4_fac[i];
                    shift_din20_i_add_8[i] <= w_shift_din12_i_sub_3_fac[4+i] + w_shift_din12_i_sub_4_fac[4+i];
                    shift_din20_i_sub_8[i] <= w_shift_din12_i_sub_3_fac[4+i] - w_shift_din12_i_sub_4_fac[4+i];
                    shift_din20_q_add_8[i] <= w_shift_din12_q_sub_3_fac[4+i] + w_shift_din12_q_sub_4_fac[4+i];
                    shift_din20_q_sub_8[i] <= w_shift_din12_q_sub_3_fac[4+i] - w_shift_din12_q_sub_4_fac[4+i];
                end
            end else if (m10_cnt == 24) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_9[i] <= w_shift_din12_i_add_5_fac[i] + w_shift_din12_i_add_6_fac[i];
                    shift_din20_i_sub_9[i] <= w_shift_din12_i_add_5_fac[i] - w_shift_din12_i_add_6_fac[i];
                    shift_din20_q_add_9[i] <= w_shift_din12_q_add_5_fac[i] + w_shift_din12_q_add_6_fac[i];
                    shift_din20_q_sub_9[i] <= w_shift_din12_q_add_5_fac[i] - w_shift_din12_q_add_6_fac[i];
                    shift_din20_i_add_10[i] <= w_shift_din12_i_add_5_fac[4+i] + w_shift_din12_i_add_6_fac[4+i];
                    shift_din20_i_sub_10[i] <= w_shift_din12_i_add_5_fac[4+i] - w_shift_din12_i_add_6_fac[4+i];
                    shift_din20_q_add_10[i] <= w_shift_din12_q_add_5_fac[4+i] + w_shift_din12_q_add_6_fac[4+i];
                    shift_din20_q_sub_10[i] <= w_shift_din12_q_add_5_fac[4+i] - w_shift_din12_q_add_6_fac[4+i];
                end
            end else if (m10_cnt == 25) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_11[i] <= w_shift_din12_i_sub_5_fac[i] + w_shift_din12_i_sub_6_fac[i];
                    shift_din20_i_sub_11[i] <= w_shift_din12_i_sub_5_fac[i] - w_shift_din12_i_sub_6_fac[i];
                    shift_din20_q_add_11[i] <= w_shift_din12_q_sub_5_fac[i] + w_shift_din12_q_sub_6_fac[i];
                    shift_din20_q_sub_11[i] <= w_shift_din12_q_sub_5_fac[i] - w_shift_din12_q_sub_6_fac[i];
                    shift_din20_i_add_12[i] <= w_shift_din12_i_sub_5_fac[4+i] + w_shift_din12_i_sub_6_fac[4+i];
                    shift_din20_i_sub_12[i] <= w_shift_din12_i_sub_5_fac[4+i] - w_shift_din12_i_sub_6_fac[4+i];
                    shift_din20_q_add_12[i] <= w_shift_din12_q_sub_5_fac[4+i] + w_shift_din12_q_sub_6_fac[4+i];
                    shift_din20_q_sub_12[i] <= w_shift_din12_q_sub_5_fac[4+i] - w_shift_din12_q_sub_6_fac[4+i];
                end
            end else if (m10_cnt == 26) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_13[i] <= w_shift_din12_i_add_7_fac[i] + w_shift_din12_i_add_8_fac[i];
                    shift_din20_i_sub_13[i] <= w_shift_din12_i_add_7_fac[i] - w_shift_din12_i_add_8_fac[i];
                    shift_din20_q_add_13[i] <= w_shift_din12_q_add_7_fac[i] + w_shift_din12_q_add_8_fac[i];
                    shift_din20_q_sub_13[i] <= w_shift_din12_q_add_7_fac[i] - w_shift_din12_q_add_8_fac[i];
                    shift_din20_i_add_14[i] <= w_shift_din12_i_add_7_fac[4+i] + w_shift_din12_i_add_8_fac[4+i];
                    shift_din20_i_sub_14[i] <= w_shift_din12_i_add_7_fac[4+i] - w_shift_din12_i_add_8_fac[4+i];
                    shift_din20_q_add_14[i] <= w_shift_din12_q_add_7_fac[4+i] + w_shift_din12_q_add_8_fac[4+i];
                    shift_din20_q_sub_14[i] <= w_shift_din12_q_add_7_fac[4+i] - w_shift_din12_q_add_8_fac[4+i];
                end
            end else if (m10_cnt == 27) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_15[i] <= w_shift_din12_i_sub_7_fac[i] + w_shift_din12_i_sub_8_fac[i];
                    shift_din20_i_sub_15[i] <= w_shift_din12_i_sub_7_fac[i] - w_shift_din12_i_sub_8_fac[i];
                    shift_din20_q_add_15[i] <= w_shift_din12_q_sub_7_fac[i] + w_shift_din12_q_sub_8_fac[i];
                    shift_din20_q_sub_15[i] <= w_shift_din12_q_sub_7_fac[i] - w_shift_din12_q_sub_8_fac[i];
                    shift_din20_i_add_16[i] <= w_shift_din12_i_sub_7_fac[4+i] + w_shift_din12_i_sub_8_fac[4+i];
                    shift_din20_i_sub_16[i] <= w_shift_din12_i_sub_7_fac[4+i] - w_shift_din12_i_sub_8_fac[4+i];
                    shift_din20_q_add_16[i] <= w_shift_din12_q_sub_7_fac[4+i] + w_shift_din12_q_sub_8_fac[4+i];
                    shift_din20_q_sub_16[i] <= w_shift_din12_q_sub_7_fac[4+i] - w_shift_din12_q_sub_8_fac[4+i];
                end
            end else if (m10_cnt == 28) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_17[i] <= w_shift_din12_i_add_9_fac[i] + w_shift_din12_i_add_10_fac[i];
                    shift_din20_i_sub_17[i] <= w_shift_din12_i_add_9_fac[i] - w_shift_din12_i_add_10_fac[i];
                    shift_din20_q_add_17[i] <= w_shift_din12_q_add_9_fac[i] + w_shift_din12_q_add_10_fac[i];
                    shift_din20_q_sub_17[i] <= w_shift_din12_q_add_9_fac[i] - w_shift_din12_q_add_10_fac[i];
                    shift_din20_i_add_18[i] <= w_shift_din12_i_add_9_fac[4+i] + w_shift_din12_i_add_10_fac[4+i];
                    shift_din20_i_sub_18[i] <= w_shift_din12_i_add_9_fac[4+i] - w_shift_din12_i_add_10_fac[4+i];
                    shift_din20_q_add_18[i] <= w_shift_din12_q_add_9_fac[4+i] + w_shift_din12_q_add_10_fac[4+i];
                    shift_din20_q_sub_18[i] <= w_shift_din12_q_add_9_fac[4+i] - w_shift_din12_q_add_10_fac[4+i];
                end
            end else if (m10_cnt == 29) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_19[i] <= w_shift_din12_i_sub_9_fac[i] + w_shift_din12_i_sub_10_fac[i];
                    shift_din20_i_sub_19[i] <= w_shift_din12_i_sub_9_fac[i] - w_shift_din12_i_sub_10_fac[i];
                    shift_din20_q_add_19[i] <= w_shift_din12_q_sub_9_fac[i] + w_shift_din12_q_sub_10_fac[i];
                    shift_din20_q_sub_19[i] <= w_shift_din12_q_sub_9_fac[i] - w_shift_din12_q_sub_10_fac[i];
                    shift_din20_i_add_20[i] <= w_shift_din12_i_sub_9_fac[4+i] + w_shift_din12_i_sub_10_fac[4+i];
                    shift_din20_i_sub_20[i] <= w_shift_din12_i_sub_9_fac[4+i] - w_shift_din12_i_sub_10_fac[4+i];
                    shift_din20_q_add_20[i] <= w_shift_din12_q_sub_9_fac[4+i] + w_shift_din12_q_sub_10_fac[4+i];
                    shift_din20_q_sub_20[i] <= w_shift_din12_q_sub_9_fac[4+i] - w_shift_din12_q_sub_10_fac[4+i];
                end
            end else if (m10_cnt == 30) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_21[i] <= w_shift_din12_i_add_11_fac[i] + w_shift_din12_i_add_12_fac[i];
                    shift_din20_i_sub_21[i] <= w_shift_din12_i_add_11_fac[i] - w_shift_din12_i_add_12_fac[i];
                    shift_din20_q_add_21[i] <= w_shift_din12_q_add_11_fac[i] + w_shift_din12_q_add_12_fac[i];
                    shift_din20_q_sub_21[i] <= w_shift_din12_q_add_11_fac[i] - w_shift_din12_q_add_12_fac[i];
                    shift_din20_i_add_22[i] <= w_shift_din12_i_add_11_fac[4+i] + w_shift_din12_i_add_12_fac[4+i];
                    shift_din20_i_sub_22[i] <= w_shift_din12_i_add_11_fac[4+i] - w_shift_din12_i_add_12_fac[4+i];
                    shift_din20_q_add_22[i] <= w_shift_din12_q_add_11_fac[4+i] + w_shift_din12_q_add_12_fac[4+i];
                    shift_din20_q_sub_22[i] <= w_shift_din12_q_add_11_fac[4+i] - w_shift_din12_q_add_12_fac[4+i];
                end
            end else if (m10_cnt == 31) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_23[i] <= w_shift_din12_i_sub_11_fac[i] + w_shift_din12_i_sub_12_fac[i];
                    shift_din20_i_sub_23[i] <= w_shift_din12_i_sub_11_fac[i] - w_shift_din12_i_sub_12_fac[i];
                    shift_din20_q_add_23[i] <= w_shift_din12_q_sub_11_fac[i] + w_shift_din12_q_sub_12_fac[i];
                    shift_din20_q_sub_23[i] <= w_shift_din12_q_sub_11_fac[i] - w_shift_din12_q_sub_12_fac[i];
                    shift_din20_i_add_24[i] <= w_shift_din12_i_sub_11_fac[4+i] + w_shift_din12_i_sub_12_fac[4+i];
                    shift_din20_i_sub_24[i] <= w_shift_din12_i_sub_11_fac[4+i] - w_shift_din12_i_sub_12_fac[4+i];
                    shift_din20_q_add_24[i] <= w_shift_din12_q_sub_11_fac[4+i] + w_shift_din12_q_sub_12_fac[4+i];
                    shift_din20_q_sub_24[i] <= w_shift_din12_q_sub_11_fac[4+i] - w_shift_din12_q_sub_12_fac[4+i];
                end
            end else if (m10_cnt == 32) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_25[i] <= w_shift_din12_i_add_13_fac[i] + w_shift_din12_i_add_14_fac[i];
                    shift_din20_i_sub_25[i] <= w_shift_din12_i_add_13_fac[i] - w_shift_din12_i_add_14_fac[i];
                    shift_din20_q_add_25[i] <= w_shift_din12_q_add_13_fac[i] + w_shift_din12_q_add_14_fac[i];
                    shift_din20_q_sub_25[i] <= w_shift_din12_q_add_13_fac[i] - w_shift_din12_q_add_14_fac[i];
                    shift_din20_i_add_26[i] <= w_shift_din12_i_add_13_fac[4+i] + w_shift_din12_i_add_14_fac[4+i];
                    shift_din20_i_sub_26[i] <= w_shift_din12_i_add_13_fac[4+i] - w_shift_din12_i_add_14_fac[4+i];
                    shift_din20_q_add_26[i] <= w_shift_din12_q_add_13_fac[4+i] + w_shift_din12_q_add_14_fac[4+i];
                    shift_din20_q_sub_26[i] <= w_shift_din12_q_add_13_fac[4+i] - w_shift_din12_q_add_14_fac[4+i];
                end
            end else if (m10_cnt == 33) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_27[i] <= w_shift_din12_i_sub_13_fac[i] + w_shift_din12_i_sub_14_fac[i];
                    shift_din20_i_sub_27[i] <= w_shift_din12_i_sub_13_fac[i] - w_shift_din12_i_sub_14_fac[i];
                    shift_din20_q_add_27[i] <= w_shift_din12_q_sub_13_fac[i] + w_shift_din12_q_sub_14_fac[i];
                    shift_din20_q_sub_27[i] <= w_shift_din12_q_sub_13_fac[i] - w_shift_din12_q_sub_14_fac[i];
                    shift_din20_i_add_28[i] <= w_shift_din12_i_sub_13_fac[4+i] + w_shift_din12_i_sub_14_fac[4+i];
                    shift_din20_i_sub_28[i] <= w_shift_din12_i_sub_13_fac[4+i] - w_shift_din12_i_sub_14_fac[4+i];
                    shift_din20_q_add_28[i] <= w_shift_din12_q_sub_13_fac[4+i] + w_shift_din12_q_sub_14_fac[4+i];
                    shift_din20_q_sub_28[i] <= w_shift_din12_q_sub_13_fac[4+i] - w_shift_din12_q_sub_14_fac[4+i];
                end
            end else if (m10_cnt == 34) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_29[i] <= w_shift_din12_i_add_15_fac[i] + w_shift_din12_i_add_16_fac[i];
                    shift_din20_i_sub_29[i] <= w_shift_din12_i_add_15_fac[i] - w_shift_din12_i_add_16_fac[i];
                    shift_din20_q_add_29[i] <= w_shift_din12_q_add_15_fac[i] + w_shift_din12_q_add_16_fac[i];
                    shift_din20_q_sub_29[i] <= w_shift_din12_q_add_15_fac[i] - w_shift_din12_q_add_16_fac[i];
                    shift_din20_i_add_30[i] <= w_shift_din12_i_add_15_fac[4+i] + w_shift_din12_i_add_16_fac[4+i];
                    shift_din20_i_sub_30[i] <= w_shift_din12_i_add_15_fac[4+i] - w_shift_din12_i_add_16_fac[4+i];
                    shift_din20_q_add_30[i] <= w_shift_din12_q_add_15_fac[4+i] + w_shift_din12_q_add_16_fac[4+i];
                    shift_din20_q_sub_30[i] <= w_shift_din12_q_add_15_fac[4+i] - w_shift_din12_q_add_16_fac[4+i];
                end
            end else if (m10_cnt == 35) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_add_31[i] <= w_shift_din12_i_sub_15_fac[i] + w_shift_din12_i_sub_16_fac[i];
                    shift_din20_i_sub_31[i] <= w_shift_din12_i_sub_15_fac[i] - w_shift_din12_i_sub_16_fac[i];
                    shift_din20_q_add_31[i] <= w_shift_din12_q_sub_15_fac[i] + w_shift_din12_q_sub_16_fac[i];
                    shift_din20_q_sub_31[i] <= w_shift_din12_q_sub_15_fac[i] - w_shift_din12_q_sub_16_fac[i];
                    shift_din20_i_add_32[i] <= w_shift_din12_i_sub_15_fac[4+i] + w_shift_din12_i_sub_16_fac[4+i];
                    shift_din20_i_sub_32[i] <= w_shift_din12_i_sub_15_fac[4+i] - w_shift_din12_i_sub_16_fac[4+i];
                    shift_din20_q_add_32[i] <= w_shift_din12_q_sub_15_fac[4+i] + w_shift_din12_q_sub_16_fac[4+i];
                    shift_din20_q_sub_32[i] <= w_shift_din12_q_sub_15_fac[4+i] - w_shift_din12_q_sub_16_fac[4+i];
                end
            end
        end
    end

    always @(posedge clk, negedge rstn) begin
        if (~rstn) begin
            for (i = 15; i >= 0; i = i - 1) begin
                shift_din20_i_cbfp[i] <= 0;
                shift_din20_q_cbfp[i] <= 0;
            end
            cbfp_valid <= 0;
        end else begin
            if (m10_cnt == 5) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_1[i]*twf_m1_re[i]) - (shift_din20_q_add_1[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_2[i]*twf_m1_re[4+i]) - (shift_din20_q_add_2[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_1[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_1[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_2[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_2[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_1[i]*twf_m1_re[i]) + (shift_din20_i_add_1[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_2[i]*twf_m1_re[4+i]) + (shift_din20_i_add_2[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_1[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_1[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_2[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_2[i]*twf_m1_im[12+i]);
                end
                cbfp_valid <= 1;
            end else if (m10_cnt == 6) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_3[i]*twf_m1_re[i]) - (shift_din20_q_add_3[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_4[i]*twf_m1_re[4+i]) - (shift_din20_q_add_4[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_3[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_3[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_4[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_4[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_3[i]*twf_m1_re[i]) + (shift_din20_i_add_3[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_4[i]*twf_m1_re[4+i]) + (shift_din20_i_add_4[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_3[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_3[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_4[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_4[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 7) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_5[i]*twf_m1_re[i]) - (shift_din20_q_add_5[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_6[i]*twf_m1_re[4+i]) - (shift_din20_q_add_6[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_5[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_5[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_6[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_6[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_5[i]*twf_m1_re[i]) + (shift_din20_i_add_5[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_6[i]*twf_m1_re[4+i]) + (shift_din20_i_add_6[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_5[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_5[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_6[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_6[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 8) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_7[i]*twf_m1_re[i]) - (shift_din20_q_add_7[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_8[i]*twf_m1_re[4+i]) - (shift_din20_q_add_8[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_7[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_7[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_8[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_8[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_7[i]*twf_m1_re[i]) + (shift_din20_i_add_7[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_8[i]*twf_m1_re[4+i]) + (shift_din20_i_add_8[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_7[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_7[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_8[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_8[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 9) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_9[i]*twf_m1_re[i]) - (shift_din20_q_add_9[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_10[i]*twf_m1_re[4+i]) - (shift_din20_q_add_10[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_9[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_9[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_10[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_10[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_9[i]*twf_m1_re[i]) + (shift_din20_i_add_9[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_10[i]*twf_m1_re[4+i]) + (shift_din20_i_add_10[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_9[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_9[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_10[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_10[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 10) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_11[i]*twf_m1_re[i]) - (shift_din20_q_add_11[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_12[i]*twf_m1_re[4+i]) - (shift_din20_q_add_12[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_11[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_11[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_12[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_12[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_11[i]*twf_m1_re[i]) + (shift_din20_i_add_11[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_12[i]*twf_m1_re[4+i]) + (shift_din20_i_add_12[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_11[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_11[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_12[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_12[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 11) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_13[i]*twf_m1_re[i]) - (shift_din20_q_add_13[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_14[i]*twf_m1_re[4+i]) - (shift_din20_q_add_14[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_13[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_13[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_14[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_14[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_13[i]*twf_m1_re[i]) + (shift_din20_i_add_13[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_14[i]*twf_m1_re[4+i]) + (shift_din20_i_add_14[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_13[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_13[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_14[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_14[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 12) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_15[i]*twf_m1_re[i]) - (shift_din20_q_add_15[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_16[i]*twf_m1_re[4+i]) - (shift_din20_q_add_16[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_15[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_15[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_16[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_16[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_15[i]*twf_m1_re[i]) + (shift_din20_i_add_15[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_16[i]*twf_m1_re[4+i]) + (shift_din20_i_add_16[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_15[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_15[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_16[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_16[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 13) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_17[i]*twf_m1_re[i]) - (shift_din20_q_add_17[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_18[i]*twf_m1_re[4+i]) - (shift_din20_q_add_18[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_17[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_17[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_18[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_18[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_17[i]*twf_m1_re[i]) + (shift_din20_i_add_17[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_18[i]*twf_m1_re[4+i]) + (shift_din20_i_add_18[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_17[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_17[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_18[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_18[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 14) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_19[i]*twf_m1_re[i]) - (shift_din20_q_add_19[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_20[i]*twf_m1_re[4+i]) - (shift_din20_q_add_20[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_19[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_19[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_20[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_20[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_19[i]*twf_m1_re[i]) + (shift_din20_i_add_19[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_20[i]*twf_m1_re[4+i]) + (shift_din20_i_add_20[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_19[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_19[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_20[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_20[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 15) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_21[i]*twf_m1_re[i]) - (shift_din20_q_add_21[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_22[i]*twf_m1_re[4+i]) - (shift_din20_q_add_22[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_21[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_21[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_22[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_22[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_21[i]*twf_m1_re[i]) + (shift_din20_i_add_21[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_22[i]*twf_m1_re[4+i]) + (shift_din20_i_add_22[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_21[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_21[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_22[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_22[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 16) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_23[i]*twf_m1_re[i]) - (shift_din20_q_add_23[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_24[i]*twf_m1_re[4+i]) - (shift_din20_q_add_24[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_23[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_23[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_24[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_24[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_23[i]*twf_m1_re[i]) + (shift_din20_i_add_23[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_24[i]*twf_m1_re[4+i]) + (shift_din20_i_add_24[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_23[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_23[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_24[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_24[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 17) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_25[i]*twf_m1_re[i]) - (shift_din20_q_add_25[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_26[i]*twf_m1_re[4+i]) - (shift_din20_q_add_26[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_25[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_25[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_26[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_26[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_25[i]*twf_m1_re[i]) + (shift_din20_i_add_25[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_26[i]*twf_m1_re[4+i]) + (shift_din20_i_add_26[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_25[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_25[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_26[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_26[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 18) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_27[i]*twf_m1_re[i]) - (shift_din20_q_add_27[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_28[i]*twf_m1_re[4+i]) - (shift_din20_q_add_28[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_27[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_27[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_28[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_28[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_27[i]*twf_m1_re[i]) + (shift_din20_i_add_27[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_28[i]*twf_m1_re[4+i]) + (shift_din20_i_add_28[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_27[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_27[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_28[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_28[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 19) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_29[i]*twf_m1_re[i]) - (shift_din20_q_add_29[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_30[i]*twf_m1_re[4+i]) - (shift_din20_q_add_30[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_29[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_29[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_30[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_30[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_29[i]*twf_m1_re[i]) + (shift_din20_i_add_29[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_30[i]*twf_m1_re[4+i]) + (shift_din20_i_add_30[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_29[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_29[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_30[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_30[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 20) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_31[i]*twf_m1_re[i]) - (shift_din20_q_add_31[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_32[i]*twf_m1_re[4+i]) - (shift_din20_q_add_32[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_31[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_31[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_32[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_32[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_31[i]*twf_m1_re[i]) + (shift_din20_i_add_31[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_32[i]*twf_m1_re[4+i]) + (shift_din20_i_add_32[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_31[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_31[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_32[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_32[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 21) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    // m10_cnt 21부터 1, 2로 초기화
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_1[i]*twf_m1_re[i]) - (shift_din20_q_add_1[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_2[i]*twf_m1_re[4+i]) - (shift_din20_q_add_2[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_1[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_1[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_2[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_2[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_1[i]*twf_m1_re[i]) + (shift_din20_i_add_1[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_2[i]*twf_m1_re[4+i]) + (shift_din20_i_add_2[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_1[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_1[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_2[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_2[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 22) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_3[i]*twf_m1_re[i]) - (shift_din20_q_add_3[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_4[i]*twf_m1_re[4+i]) - (shift_din20_q_add_4[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_3[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_3[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_4[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_4[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_3[i]*twf_m1_re[i]) + (shift_din20_i_add_3[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_4[i]*twf_m1_re[4+i]) + (shift_din20_i_add_4[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_3[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_3[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_4[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_4[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 23) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_5[i]*twf_m1_re[i]) - (shift_din20_q_add_5[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_6[i]*twf_m1_re[4+i]) - (shift_din20_q_add_6[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_5[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_5[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_6[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_6[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_5[i]*twf_m1_re[i]) + (shift_din20_i_add_5[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_6[i]*twf_m1_re[4+i]) + (shift_din20_i_add_6[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_5[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_5[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_6[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_6[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 24) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_7[i]*twf_m1_re[i]) - (shift_din20_q_add_7[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_8[i]*twf_m1_re[4+i]) - (shift_din20_q_add_8[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_7[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_7[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_8[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_8[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_7[i]*twf_m1_re[i]) + (shift_din20_i_add_7[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_8[i]*twf_m1_re[4+i]) + (shift_din20_i_add_8[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_7[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_7[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_8[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_8[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 25) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_9[i]*twf_m1_re[i]) - (shift_din20_q_add_9[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_10[i]*twf_m1_re[4+i]) - (shift_din20_q_add_10[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_9[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_9[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_10[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_10[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_9[i]*twf_m1_re[i]) + (shift_din20_i_add_9[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_10[i]*twf_m1_re[4+i]) + (shift_din20_i_add_10[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_9[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_9[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_10[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_10[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 26) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_11[i]*twf_m1_re[i]) - (shift_din20_q_add_11[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_12[i]*twf_m1_re[4+i]) - (shift_din20_q_add_12[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_11[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_11[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_12[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_12[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_11[i]*twf_m1_re[i]) + (shift_din20_i_add_11[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_12[i]*twf_m1_re[4+i]) + (shift_din20_i_add_12[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_11[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_11[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_12[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_12[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 27) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_13[i]*twf_m1_re[i]) - (shift_din20_q_add_13[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_14[i]*twf_m1_re[4+i]) - (shift_din20_q_add_14[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_13[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_13[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_14[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_14[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_13[i]*twf_m1_re[i]) + (shift_din20_i_add_13[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_14[i]*twf_m1_re[4+i]) + (shift_din20_i_add_14[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_13[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_13[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_14[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_14[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 28) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_15[i]*twf_m1_re[i]) - (shift_din20_q_add_15[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_16[i]*twf_m1_re[4+i]) - (shift_din20_q_add_16[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_15[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_15[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_16[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_16[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_15[i]*twf_m1_re[i]) + (shift_din20_i_add_15[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_16[i]*twf_m1_re[4+i]) + (shift_din20_i_add_16[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_15[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_15[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_16[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_16[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 29) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_17[i]*twf_m1_re[i]) - (shift_din20_q_add_17[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_18[i]*twf_m1_re[4+i]) - (shift_din20_q_add_18[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_17[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_17[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_18[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_18[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_17[i]*twf_m1_re[i]) + (shift_din20_i_add_17[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_18[i]*twf_m1_re[4+i]) + (shift_din20_i_add_18[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_17[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_17[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_18[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_18[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 30) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_19[i]*twf_m1_re[i]) - (shift_din20_q_add_19[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_20[i]*twf_m1_re[4+i]) - (shift_din20_q_add_20[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_19[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_19[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_20[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_20[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_19[i]*twf_m1_re[i]) + (shift_din20_i_add_19[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_20[i]*twf_m1_re[4+i]) + (shift_din20_i_add_20[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_19[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_19[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_20[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_20[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 31) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_21[i]*twf_m1_re[i]) - (shift_din20_q_add_21[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_22[i]*twf_m1_re[4+i]) - (shift_din20_q_add_22[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_21[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_21[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_22[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_22[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_21[i]*twf_m1_re[i]) + (shift_din20_i_add_21[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_22[i]*twf_m1_re[4+i]) + (shift_din20_i_add_22[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_21[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_21[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_22[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_22[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 32) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_23[i]*twf_m1_re[i]) - (shift_din20_q_add_23[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_24[i]*twf_m1_re[4+i]) - (shift_din20_q_add_24[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_23[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_23[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_24[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_24[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_23[i]*twf_m1_re[i]) + (shift_din20_i_add_23[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_24[i]*twf_m1_re[4+i]) + (shift_din20_i_add_24[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_23[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_23[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_24[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_24[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 33) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_25[i]*twf_m1_re[i]) - (shift_din20_q_add_25[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_26[i]*twf_m1_re[4+i]) - (shift_din20_q_add_26[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_25[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_25[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_26[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_26[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_25[i]*twf_m1_re[i]) + (shift_din20_i_add_25[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_26[i]*twf_m1_re[4+i]) + (shift_din20_i_add_26[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_25[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_25[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_26[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_26[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 34) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_27[i]*twf_m1_re[i]) - (shift_din20_q_add_27[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_28[i]*twf_m1_re[4+i]) - (shift_din20_q_add_28[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_27[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_27[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_28[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_28[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_27[i]*twf_m1_re[i]) + (shift_din20_i_add_27[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_28[i]*twf_m1_re[4+i]) + (shift_din20_i_add_28[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_27[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_27[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_28[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_28[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 35) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_29[i]*twf_m1_re[i]) - (shift_din20_q_add_29[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_30[i]*twf_m1_re[4+i]) - (shift_din20_q_add_30[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_29[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_29[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_30[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_30[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_29[i]*twf_m1_re[i]) + (shift_din20_i_add_29[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_30[i]*twf_m1_re[4+i]) + (shift_din20_i_add_30[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_29[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_29[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_30[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_30[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt == 36) begin
                for (i = 0; i <= 3; i = i + 1) begin
                    shift_din20_i_cbfp[i] <= (shift_din20_i_add_31[i]*twf_m1_re[i]) - (shift_din20_q_add_31[i]*twf_m1_im[i]);
                    shift_din20_i_cbfp[4+i] <= (shift_din20_i_add_32[i]*twf_m1_re[4+i]) - (shift_din20_q_add_32[i]*twf_m1_im[4+i]);
                    shift_din20_i_cbfp[8+i] <= (shift_din20_i_sub_31[i]*twf_m1_re[8+i]) - (shift_din20_q_sub_31[i]*twf_m1_im[8+i]);
                    shift_din20_i_cbfp[12+i] <= (shift_din20_i_sub_32[i]*twf_m1_re[12+i]) - (shift_din20_q_sub_32[i]*twf_m1_im[12+i]);
                    shift_din20_q_cbfp[i] <= (shift_din20_q_add_31[i]*twf_m1_re[i]) + (shift_din20_i_add_31[i]*twf_m1_im[i]);
                    shift_din20_q_cbfp[4+i] <= (shift_din20_q_add_32[i]*twf_m1_re[4+i]) + (shift_din20_i_add_32[i]*twf_m1_im[4+i]);
                    shift_din20_q_cbfp[8+i] <= (shift_din20_q_sub_31[i]*twf_m1_re[8+i]) + (shift_din20_i_sub_31[i]*twf_m1_im[8+i]);
                    shift_din20_q_cbfp[12+i] <= (shift_din20_q_sub_32[i]*twf_m1_re[12+i]) + (shift_din20_i_sub_32[i]*twf_m1_im[12+i]);
                end
            end else if (m10_cnt >= 37) begin
                cbfp_valid <= 0;
            end
        end
    end

endmodule
