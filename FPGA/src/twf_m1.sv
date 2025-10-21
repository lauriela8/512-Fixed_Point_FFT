`timescale 1ns/1ps

module twf_m1 (
    input clk,
    input rstn,
    input [5:0] addr,
    output logic signed [8:0] twf_m1_re,
    output logic signed [8:0] twf_m1_im
);
wire signed [8:0] reg_re [0:63];
wire signed [8:0] reg_im [0:63];

always @(posedge clk, negedge rstn) begin
    if (~rstn) begin
        twf_m1_re <= 0;
        twf_m1_im <= 0;
    end else begin
        twf_m1_re <= reg_re[addr];
        twf_m1_im <= reg_im[addr];
    end
end
    
assign reg_re[0] = 128; assign reg_im[0] = 0;
assign reg_re[1] = 128; assign reg_im[1] = 0;
assign reg_re[2] = 128; assign reg_im[2] = 0;
assign reg_re[3] = 128; assign reg_im[3] = 0;
assign reg_re[4] = 128; assign reg_im[4] = 0;
assign reg_re[5] = 128; assign reg_im[5] = 0;
assign reg_re[6] = 128; assign reg_im[6] = 0;
assign reg_re[7] = 128; assign reg_im[7] = 0;
assign reg_re[8] = 128; assign reg_im[8] = 0;
assign reg_re[9] = 118; assign reg_im[9] = -49;
assign reg_re[10] = 91; assign reg_im[10] = -91;
assign reg_re[11] = 49; assign reg_im[11] = -118;
assign reg_re[12] = 0; assign reg_im[12] = -128;
assign reg_re[13] = -49; assign reg_im[13] = -118;
assign reg_re[14] = -91; assign reg_im[14] = -91;
assign reg_re[15] = -118; assign reg_im[15] = -49;
assign reg_re[16] = 128; assign reg_im[16] = 0;
assign reg_re[17] = 126; assign reg_im[17] = -25;
assign reg_re[18] = 118; assign reg_im[18] = -49;
assign reg_re[19] = 106; assign reg_im[19] = -71;
assign reg_re[20] = 91; assign reg_im[20] = -91;
assign reg_re[21] = 71; assign reg_im[21] = -106;
assign reg_re[22] = 49; assign reg_im[22] = -118;
assign reg_re[23] = 25; assign reg_im[23] = -126;
assign reg_re[24] = 128; assign reg_im[24] = 0;
assign reg_re[25] = 106; assign reg_im[25] = -71;
assign reg_re[26] = 49; assign reg_im[26] = -118;
assign reg_re[27] = -25; assign reg_im[27] = -126;
assign reg_re[28] = -91; assign reg_im[28] = -91;
assign reg_re[29] = -126; assign reg_im[29] = -25;
assign reg_re[30] = -118; assign reg_im[30] = 49;
assign reg_re[31] = -71; assign reg_im[31] = 106;
assign reg_re[32] = 128; assign reg_im[32] = 0;
assign reg_re[33] = 127; assign reg_im[33] = -13;
assign reg_re[34] = 126; assign reg_im[34] = -25;
assign reg_re[35] = 122; assign reg_im[35] = -37;
assign reg_re[36] = 118; assign reg_im[36] = -49;
assign reg_re[37] = 113; assign reg_im[37] = -60;
assign reg_re[38] = 106; assign reg_im[38] = -71;
assign reg_re[39] = 99; assign reg_im[39] = -81;
assign reg_re[40] = 128; assign reg_im[40] = 0;
assign reg_re[41] = 113; assign reg_im[41] = -60;
assign reg_re[42] = 71; assign reg_im[42] = -106;
assign reg_re[43] = 13; assign reg_im[43] = -127;
assign reg_re[44] = -49; assign reg_im[44] = -118;
assign reg_re[45] = -99; assign reg_im[45] = -81;
assign reg_re[46] = -126; assign reg_im[46] = -25;
assign reg_re[47] = -122; assign reg_im[47] = 37;
assign reg_re[48] = 128; assign reg_im[48] = 0;
assign reg_re[49] = 122; assign reg_im[49] = -37;
assign reg_re[50] = 106; assign reg_im[50] = -71;
assign reg_re[51] = 81; assign reg_im[51] = -99;
assign reg_re[52] = 49; assign reg_im[52] = -118;
assign reg_re[53] = 13; assign reg_im[53] = -127;
assign reg_re[54] = -25; assign reg_im[54] = -126;
assign reg_re[55] = -60; assign reg_im[55] = -113;
assign reg_re[56] = 128; assign reg_im[56] = 0;
assign reg_re[57] = 99; assign reg_im[57] = -81;
assign reg_re[58] = 25; assign reg_im[58] = -126;
assign reg_re[59] = -60; assign reg_im[59] = -113;
assign reg_re[60] = -118; assign reg_im[60] = -49;
assign reg_re[61] = -122; assign reg_im[61] = 37;
assign reg_re[62] = -71; assign reg_im[62] = 106;
assign reg_re[63] = 13; assign reg_im[63] = 127;

endmodule
