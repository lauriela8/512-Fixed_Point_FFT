
`timescale 1ns / 1ps

// ROM 데이터로 FFT_Fixed 모듈을 무한 반복 테스트하는 최상위 모듈
module FFT_Top_With_ROM (
    input logic clk_in1_n,
    input logic clk_in1_p,
    input logic rstn
);

    // ## 1. 상태 머신 및 제어 신호 선언 ##

    // 상태 정의
    localparam S_SEND = 2'b00;  // 데이터 전송 상태
    localparam S_WAIT_EN = 2'b01;  // fft_do_en 대기 상태
    localparam S_DELAY = 2'b10;  // 8클럭 지연 상태

    reg [1:0] state;  // 현재 상태를 저장할 레지스터

    // 카운터
    reg [4:0] cycle_cnt;  // 데이터 전송용 카운터 (0-31)
    reg [5:0] delay_cnt;  // 8클럭 지연용 카운터 (0-7)

    // FFT_Fixed로 연결될 신호
    logic din_valid;
    logic signed [8:0] din_i[0:15];
    logic signed [8:0] din_q[0:15];

    // FFT_Fixed의 출력 신호
    wire fft_do_en;
    wire signed [12:0] fft_do_re[0:15];
    wire signed [12:0] fft_do_im[0:15];


    // ## 2. ROM 데이터 내장 ##
    wire signed [8:0] rom_data_re[0:511];
    wire signed [8:0] rom_data_im[0:511];

    // 여기에 cos_rom의 512개 assign 구문을 모두 붙여넣어야 합니다.
    assign rom_data_re[0] = 63;
    assign rom_data_im[0] = 0;
    assign rom_data_re[1] = 64;
    assign rom_data_im[1] = 0;
    assign rom_data_re[2] = 64;
    assign rom_data_im[2] = 0;
    assign rom_data_re[3] = 64;
    assign rom_data_im[3] = 0;
    assign rom_data_re[4] = 64;
    assign rom_data_im[4] = 0;
    assign rom_data_re[5] = 64;
    assign rom_data_im[5] = 0;
    assign rom_data_re[6] = 64;
    assign rom_data_im[6] = 0;
    assign rom_data_re[7] = 64;
    assign rom_data_im[7] = 0;
    assign rom_data_re[8] = 64;
    assign rom_data_im[8] = 0;
    assign rom_data_re[9] = 64;
    assign rom_data_im[9] = 0;
    assign rom_data_re[10] = 64;
    assign rom_data_im[10] = 0;
    assign rom_data_re[11] = 63;
    assign rom_data_im[11] = 0;
    assign rom_data_re[12] = 63;
    assign rom_data_im[12] = 0;
    assign rom_data_re[13] = 63;
    assign rom_data_im[13] = 0;
    assign rom_data_re[14] = 63;
    assign rom_data_im[14] = 0;
    assign rom_data_re[15] = 63;
    assign rom_data_im[15] = 0;
    assign rom_data_re[16] = 63;
    assign rom_data_im[16] = 0;
    assign rom_data_re[17] = 63;
    assign rom_data_im[17] = 0;
    assign rom_data_re[18] = 62;
    assign rom_data_im[18] = 0;
    assign rom_data_re[19] = 62;
    assign rom_data_im[19] = 0;
    assign rom_data_re[20] = 62;
    assign rom_data_im[20] = 0;
    assign rom_data_re[21] = 62;
    assign rom_data_im[21] = 0;
    assign rom_data_re[22] = 62;
    assign rom_data_im[22] = 0;
    assign rom_data_re[23] = 61;
    assign rom_data_im[23] = 0;
    assign rom_data_re[24] = 61;
    assign rom_data_im[24] = 0;
    assign rom_data_re[25] = 61;
    assign rom_data_im[25] = 0;
    assign rom_data_re[26] = 61;
    assign rom_data_im[26] = 0;
    assign rom_data_re[27] = 61;
    assign rom_data_im[27] = 0;
    assign rom_data_re[28] = 60;
    assign rom_data_im[28] = 0;
    assign rom_data_re[29] = 60;
    assign rom_data_im[29] = 0;
    assign rom_data_re[30] = 60;
    assign rom_data_im[30] = 0;
    assign rom_data_re[31] = 59;
    assign rom_data_im[31] = 0;
    assign rom_data_re[32] = 59;
    assign rom_data_im[32] = 0;
    assign rom_data_re[33] = 59;
    assign rom_data_im[33] = 0;
    assign rom_data_re[34] = 59;
    assign rom_data_im[34] = 0;
    assign rom_data_re[35] = 58;
    assign rom_data_im[35] = 0;
    assign rom_data_re[36] = 58;
    assign rom_data_im[36] = 0;
    assign rom_data_re[37] = 58;
    assign rom_data_im[37] = 0;
    assign rom_data_re[38] = 57;
    assign rom_data_im[38] = 0;
    assign rom_data_re[39] = 57;
    assign rom_data_im[39] = 0;
    assign rom_data_re[40] = 56;
    assign rom_data_im[40] = 0;
    assign rom_data_re[41] = 56;
    assign rom_data_im[41] = 0;
    assign rom_data_re[42] = 56;
    assign rom_data_im[42] = 0;
    assign rom_data_re[43] = 55;
    assign rom_data_im[43] = 0;
    assign rom_data_re[44] = 55;
    assign rom_data_im[44] = 0;
    assign rom_data_re[45] = 54;
    assign rom_data_im[45] = 0;
    assign rom_data_re[46] = 54;
    assign rom_data_im[46] = 0;
    assign rom_data_re[47] = 54;
    assign rom_data_im[47] = 0;
    assign rom_data_re[48] = 53;
    assign rom_data_im[48] = 0;
    assign rom_data_re[49] = 53;
    assign rom_data_im[49] = 0;
    assign rom_data_re[50] = 52;
    assign rom_data_im[50] = 0;
    assign rom_data_re[51] = 52;
    assign rom_data_im[51] = 0;
    assign rom_data_re[52] = 51;
    assign rom_data_im[52] = 0;
    assign rom_data_re[53] = 51;
    assign rom_data_im[53] = 0;
    assign rom_data_re[54] = 50;
    assign rom_data_im[54] = 0;
    assign rom_data_re[55] = 50;
    assign rom_data_im[55] = 0;
    assign rom_data_re[56] = 49;
    assign rom_data_im[56] = 0;
    assign rom_data_re[57] = 49;
    assign rom_data_im[57] = 0;
    assign rom_data_re[58] = 48;
    assign rom_data_im[58] = 0;
    assign rom_data_re[59] = 48;
    assign rom_data_im[59] = 0;
    assign rom_data_re[60] = 47;
    assign rom_data_im[60] = 0;
    assign rom_data_re[61] = 47;
    assign rom_data_im[61] = 0;
    assign rom_data_re[62] = 46;
    assign rom_data_im[62] = 0;
    assign rom_data_re[63] = 46;
    assign rom_data_im[63] = 0;
    assign rom_data_re[64] = 45;
    assign rom_data_im[64] = 0;
    assign rom_data_re[65] = 45;
    assign rom_data_im[65] = 0;
    assign rom_data_re[66] = 44;
    assign rom_data_im[66] = 0;
    assign rom_data_re[67] = 44;
    assign rom_data_im[67] = 0;
    assign rom_data_re[68] = 43;
    assign rom_data_im[68] = 0;
    assign rom_data_re[69] = 42;
    assign rom_data_im[69] = 0;
    assign rom_data_re[70] = 42;
    assign rom_data_im[70] = 0;
    assign rom_data_re[71] = 41;
    assign rom_data_im[71] = 0;
    assign rom_data_re[72] = 41;
    assign rom_data_im[72] = 0;
    assign rom_data_re[73] = 40;
    assign rom_data_im[73] = 0;
    assign rom_data_re[74] = 39;
    assign rom_data_im[74] = 0;
    assign rom_data_re[75] = 39;
    assign rom_data_im[75] = 0;
    assign rom_data_re[76] = 38;
    assign rom_data_im[76] = 0;
    assign rom_data_re[77] = 37;
    assign rom_data_im[77] = 0;
    assign rom_data_re[78] = 37;
    assign rom_data_im[78] = 0;
    assign rom_data_re[79] = 36;
    assign rom_data_im[79] = 0;
    assign rom_data_re[80] = 36;
    assign rom_data_im[80] = 0;
    assign rom_data_re[81] = 35;
    assign rom_data_im[81] = 0;
    assign rom_data_re[82] = 34;
    assign rom_data_im[82] = 0;
    assign rom_data_re[83] = 34;
    assign rom_data_im[83] = 0;
    assign rom_data_re[84] = 33;
    assign rom_data_im[84] = 0;
    assign rom_data_re[85] = 32;
    assign rom_data_im[85] = 0;
    assign rom_data_re[86] = 32;
    assign rom_data_im[86] = 0;
    assign rom_data_re[87] = 31;
    assign rom_data_im[87] = 0;
    assign rom_data_re[88] = 30;
    assign rom_data_im[88] = 0;
    assign rom_data_re[89] = 29;
    assign rom_data_im[89] = 0;
    assign rom_data_re[90] = 29;
    assign rom_data_im[90] = 0;
    assign rom_data_re[91] = 28;
    assign rom_data_im[91] = 0;
    assign rom_data_re[92] = 27;
    assign rom_data_im[92] = 0;
    assign rom_data_re[93] = 27;
    assign rom_data_im[93] = 0;
    assign rom_data_re[94] = 26;
    assign rom_data_im[94] = 0;
    assign rom_data_re[95] = 25;
    assign rom_data_im[95] = 0;
    assign rom_data_re[96] = 24;
    assign rom_data_im[96] = 0;
    assign rom_data_re[97] = 24;
    assign rom_data_im[97] = 0;
    assign rom_data_re[98] = 23;
    assign rom_data_im[98] = 0;
    assign rom_data_re[99] = 22;
    assign rom_data_im[99] = 0;
    assign rom_data_re[100] = 22;
    assign rom_data_im[100] = 0;
    assign rom_data_re[101] = 21;
    assign rom_data_im[101] = 0;
    assign rom_data_re[102] = 20;
    assign rom_data_im[102] = 0;
    assign rom_data_re[103] = 19;
    assign rom_data_im[103] = 0;
    assign rom_data_re[104] = 19;
    assign rom_data_im[104] = 0;
    assign rom_data_re[105] = 18;
    assign rom_data_im[105] = 0;
    assign rom_data_re[106] = 17;
    assign rom_data_im[106] = 0;
    assign rom_data_re[107] = 16;
    assign rom_data_im[107] = 0;
    assign rom_data_re[108] = 16;
    assign rom_data_im[108] = 0;
    assign rom_data_re[109] = 15;
    assign rom_data_im[109] = 0;
    assign rom_data_re[110] = 14;
    assign rom_data_im[110] = 0;
    assign rom_data_re[111] = 13;
    assign rom_data_im[111] = 0;
    assign rom_data_re[112] = 12;
    assign rom_data_im[112] = 0;
    assign rom_data_re[113] = 12;
    assign rom_data_im[113] = 0;
    assign rom_data_re[114] = 11;
    assign rom_data_im[114] = 0;
    assign rom_data_re[115] = 10;
    assign rom_data_im[115] = 0;
    assign rom_data_re[116] = 9;
    assign rom_data_im[116] = 0;
    assign rom_data_re[117] = 9;
    assign rom_data_im[117] = 0;
    assign rom_data_re[118] = 8;
    assign rom_data_im[118] = 0;
    assign rom_data_re[119] = 7;
    assign rom_data_im[119] = 0;
    assign rom_data_re[120] = 6;
    assign rom_data_im[120] = 0;
    assign rom_data_re[121] = 5;
    assign rom_data_im[121] = 0;
    assign rom_data_re[122] = 5;
    assign rom_data_im[122] = 0;
    assign rom_data_re[123] = 4;
    assign rom_data_im[123] = 0;
    assign rom_data_re[124] = 3;
    assign rom_data_im[124] = 0;
    assign rom_data_re[125] = 2;
    assign rom_data_im[125] = 0;
    assign rom_data_re[126] = 2;
    assign rom_data_im[126] = 0;
    assign rom_data_re[127] = 1;
    assign rom_data_im[127] = 0;
    assign rom_data_re[128] = 0;
    assign rom_data_im[128] = 0;
    assign rom_data_re[129] = -1;
    assign rom_data_im[129] = 0;
    assign rom_data_re[130] = -2;
    assign rom_data_im[130] = 0;
    assign rom_data_re[131] = -2;
    assign rom_data_im[131] = 0;
    assign rom_data_re[132] = -3;
    assign rom_data_im[132] = 0;
    assign rom_data_re[133] = -4;
    assign rom_data_im[133] = 0;
    assign rom_data_re[134] = -5;
    assign rom_data_im[134] = 0;
    assign rom_data_re[135] = -5;
    assign rom_data_im[135] = 0;
    assign rom_data_re[136] = -6;
    assign rom_data_im[136] = 0;
    assign rom_data_re[137] = -7;
    assign rom_data_im[137] = 0;
    assign rom_data_re[138] = -8;
    assign rom_data_im[138] = 0;
    assign rom_data_re[139] = -9;
    assign rom_data_im[139] = 0;
    assign rom_data_re[140] = -9;
    assign rom_data_im[140] = 0;
    assign rom_data_re[141] = -10;
    assign rom_data_im[141] = 0;
    assign rom_data_re[142] = -11;
    assign rom_data_im[142] = 0;
    assign rom_data_re[143] = -12;
    assign rom_data_im[143] = 0;
    assign rom_data_re[144] = -12;
    assign rom_data_im[144] = 0;
    assign rom_data_re[145] = -13;
    assign rom_data_im[145] = 0;
    assign rom_data_re[146] = -14;
    assign rom_data_im[146] = 0;
    assign rom_data_re[147] = -15;
    assign rom_data_im[147] = 0;
    assign rom_data_re[148] = -16;
    assign rom_data_im[148] = 0;
    assign rom_data_re[149] = -16;
    assign rom_data_im[149] = 0;
    assign rom_data_re[150] = -17;
    assign rom_data_im[150] = 0;
    assign rom_data_re[151] = -18;
    assign rom_data_im[151] = 0;
    assign rom_data_re[152] = -19;
    assign rom_data_im[152] = 0;
    assign rom_data_re[153] = -19;
    assign rom_data_im[153] = 0;
    assign rom_data_re[154] = -20;
    assign rom_data_im[154] = 0;
    assign rom_data_re[155] = -21;
    assign rom_data_im[155] = 0;
    assign rom_data_re[156] = -22;
    assign rom_data_im[156] = 0;
    assign rom_data_re[157] = -22;
    assign rom_data_im[157] = 0;
    assign rom_data_re[158] = -23;
    assign rom_data_im[158] = 0;
    assign rom_data_re[159] = -24;
    assign rom_data_im[159] = 0;
    assign rom_data_re[160] = -24;
    assign rom_data_im[160] = 0;
    assign rom_data_re[161] = -25;
    assign rom_data_im[161] = 0;
    assign rom_data_re[162] = -26;
    assign rom_data_im[162] = 0;
    assign rom_data_re[163] = -27;
    assign rom_data_im[163] = 0;
    assign rom_data_re[164] = -27;
    assign rom_data_im[164] = 0;
    assign rom_data_re[165] = -28;
    assign rom_data_im[165] = 0;
    assign rom_data_re[166] = -29;
    assign rom_data_im[166] = 0;
    assign rom_data_re[167] = -29;
    assign rom_data_im[167] = 0;
    assign rom_data_re[168] = -30;
    assign rom_data_im[168] = 0;
    assign rom_data_re[169] = -31;
    assign rom_data_im[169] = 0;
    assign rom_data_re[170] = -32;
    assign rom_data_im[170] = 0;
    assign rom_data_re[171] = -32;
    assign rom_data_im[171] = 0;
    assign rom_data_re[172] = -33;
    assign rom_data_im[172] = 0;
    assign rom_data_re[173] = -34;
    assign rom_data_im[173] = 0;
    assign rom_data_re[174] = -34;
    assign rom_data_im[174] = 0;
    assign rom_data_re[175] = -35;
    assign rom_data_im[175] = 0;
    assign rom_data_re[176] = -36;
    assign rom_data_im[176] = 0;
    assign rom_data_re[177] = -36;
    assign rom_data_im[177] = 0;
    assign rom_data_re[178] = -37;
    assign rom_data_im[178] = 0;
    assign rom_data_re[179] = -37;
    assign rom_data_im[179] = 0;
    assign rom_data_re[180] = -38;
    assign rom_data_im[180] = 0;
    assign rom_data_re[181] = -39;
    assign rom_data_im[181] = 0;
    assign rom_data_re[182] = -39;
    assign rom_data_im[182] = 0;
    assign rom_data_re[183] = -40;
    assign rom_data_im[183] = 0;
    assign rom_data_re[184] = -41;
    assign rom_data_im[184] = 0;
    assign rom_data_re[185] = -41;
    assign rom_data_im[185] = 0;
    assign rom_data_re[186] = -42;
    assign rom_data_im[186] = 0;
    assign rom_data_re[187] = -42;
    assign rom_data_im[187] = 0;
    assign rom_data_re[188] = -43;
    assign rom_data_im[188] = 0;
    assign rom_data_re[189] = -44;
    assign rom_data_im[189] = 0;
    assign rom_data_re[190] = -44;
    assign rom_data_im[190] = 0;
    assign rom_data_re[191] = -45;
    assign rom_data_im[191] = 0;
    assign rom_data_re[192] = -45;
    assign rom_data_im[192] = 0;
    assign rom_data_re[193] = -46;
    assign rom_data_im[193] = 0;
    assign rom_data_re[194] = -46;
    assign rom_data_im[194] = 0;
    assign rom_data_re[195] = -47;
    assign rom_data_im[195] = 0;
    assign rom_data_re[196] = -47;
    assign rom_data_im[196] = 0;
    assign rom_data_re[197] = -48;
    assign rom_data_im[197] = 0;
    assign rom_data_re[198] = -48;
    assign rom_data_im[198] = 0;
    assign rom_data_re[199] = -49;
    assign rom_data_im[199] = 0;
    assign rom_data_re[200] = -49;
    assign rom_data_im[200] = 0;
    assign rom_data_re[201] = -50;
    assign rom_data_im[201] = 0;
    assign rom_data_re[202] = -50;
    assign rom_data_im[202] = 0;
    assign rom_data_re[203] = -51;
    assign rom_data_im[203] = 0;
    assign rom_data_re[204] = -51;
    assign rom_data_im[204] = 0;
    assign rom_data_re[205] = -52;
    assign rom_data_im[205] = 0;
    assign rom_data_re[206] = -52;
    assign rom_data_im[206] = 0;
    assign rom_data_re[207] = -53;
    assign rom_data_im[207] = 0;
    assign rom_data_re[208] = -53;
    assign rom_data_im[208] = 0;
    assign rom_data_re[209] = -54;
    assign rom_data_im[209] = 0;
    assign rom_data_re[210] = -54;
    assign rom_data_im[210] = 0;
    assign rom_data_re[211] = -54;
    assign rom_data_im[211] = 0;
    assign rom_data_re[212] = -55;
    assign rom_data_im[212] = 0;
    assign rom_data_re[213] = -55;
    assign rom_data_im[213] = 0;
    assign rom_data_re[214] = -56;
    assign rom_data_im[214] = 0;
    assign rom_data_re[215] = -56;
    assign rom_data_im[215] = 0;
    assign rom_data_re[216] = -56;
    assign rom_data_im[216] = 0;
    assign rom_data_re[217] = -57;
    assign rom_data_im[217] = 0;
    assign rom_data_re[218] = -57;
    assign rom_data_im[218] = 0;
    assign rom_data_re[219] = -58;
    assign rom_data_im[219] = 0;
    assign rom_data_re[220] = -58;
    assign rom_data_im[220] = 0;
    assign rom_data_re[221] = -58;
    assign rom_data_im[221] = 0;
    assign rom_data_re[222] = -59;
    assign rom_data_im[222] = 0;
    assign rom_data_re[223] = -59;
    assign rom_data_im[223] = 0;
    assign rom_data_re[224] = -59;
    assign rom_data_im[224] = 0;
    assign rom_data_re[225] = -59;
    assign rom_data_im[225] = 0;
    assign rom_data_re[226] = -60;
    assign rom_data_im[226] = 0;
    assign rom_data_re[227] = -60;
    assign rom_data_im[227] = 0;
    assign rom_data_re[228] = -60;
    assign rom_data_im[228] = 0;
    assign rom_data_re[229] = -61;
    assign rom_data_im[229] = 0;
    assign rom_data_re[230] = -61;
    assign rom_data_im[230] = 0;
    assign rom_data_re[231] = -61;
    assign rom_data_im[231] = 0;
    assign rom_data_re[232] = -61;
    assign rom_data_im[232] = 0;
    assign rom_data_re[233] = -61;
    assign rom_data_im[233] = 0;
    assign rom_data_re[234] = -62;
    assign rom_data_im[234] = 0;
    assign rom_data_re[235] = -62;
    assign rom_data_im[235] = 0;
    assign rom_data_re[236] = -62;
    assign rom_data_im[236] = 0;
    assign rom_data_re[237] = -62;
    assign rom_data_im[237] = 0;
    assign rom_data_re[238] = -62;
    assign rom_data_im[238] = 0;
    assign rom_data_re[239] = -63;
    assign rom_data_im[239] = 0;
    assign rom_data_re[240] = -63;
    assign rom_data_im[240] = 0;
    assign rom_data_re[241] = -63;
    assign rom_data_im[241] = 0;
    assign rom_data_re[242] = -63;
    assign rom_data_im[242] = 0;
    assign rom_data_re[243] = -63;
    assign rom_data_im[243] = 0;
    assign rom_data_re[244] = -63;
    assign rom_data_im[244] = 0;
    assign rom_data_re[245] = -63;
    assign rom_data_im[245] = 0;
    assign rom_data_re[246] = -64;
    assign rom_data_im[246] = 0;
    assign rom_data_re[247] = -64;
    assign rom_data_im[247] = 0;
    assign rom_data_re[248] = -64;
    assign rom_data_im[248] = 0;
    assign rom_data_re[249] = -64;
    assign rom_data_im[249] = 0;
    assign rom_data_re[250] = -64;
    assign rom_data_im[250] = 0;
    assign rom_data_re[251] = -64;
    assign rom_data_im[251] = 0;
    assign rom_data_re[252] = -64;
    assign rom_data_im[252] = 0;
    assign rom_data_re[253] = -64;
    assign rom_data_im[253] = 0;
    assign rom_data_re[254] = -64;
    assign rom_data_im[254] = 0;
    assign rom_data_re[255] = -64;
    assign rom_data_im[255] = 0;
    assign rom_data_re[256] = -64;
    assign rom_data_im[256] = 0;
    assign rom_data_re[257] = -64;
    assign rom_data_im[257] = 0;
    assign rom_data_re[258] = -64;
    assign rom_data_im[258] = 0;
    assign rom_data_re[259] = -64;
    assign rom_data_im[259] = 0;
    assign rom_data_re[260] = -64;
    assign rom_data_im[260] = 0;
    assign rom_data_re[261] = -64;
    assign rom_data_im[261] = 0;
    assign rom_data_re[262] = -64;
    assign rom_data_im[262] = 0;
    assign rom_data_re[263] = -64;
    assign rom_data_im[263] = 0;
    assign rom_data_re[264] = -64;
    assign rom_data_im[264] = 0;
    assign rom_data_re[265] = -64;
    assign rom_data_im[265] = 0;
    assign rom_data_re[266] = -64;
    assign rom_data_im[266] = 0;
    assign rom_data_re[267] = -63;
    assign rom_data_im[267] = 0;
    assign rom_data_re[268] = -63;
    assign rom_data_im[268] = 0;
    assign rom_data_re[269] = -63;
    assign rom_data_im[269] = 0;
    assign rom_data_re[270] = -63;
    assign rom_data_im[270] = 0;
    assign rom_data_re[271] = -63;
    assign rom_data_im[271] = 0;
    assign rom_data_re[272] = -63;
    assign rom_data_im[272] = 0;
    assign rom_data_re[273] = -63;
    assign rom_data_im[273] = 0;
    assign rom_data_re[274] = -62;
    assign rom_data_im[274] = 0;
    assign rom_data_re[275] = -62;
    assign rom_data_im[275] = 0;
    assign rom_data_re[276] = -62;
    assign rom_data_im[276] = 0;
    assign rom_data_re[277] = -62;
    assign rom_data_im[277] = 0;
    assign rom_data_re[278] = -62;
    assign rom_data_im[278] = 0;
    assign rom_data_re[279] = -61;
    assign rom_data_im[279] = 0;
    assign rom_data_re[280] = -61;
    assign rom_data_im[280] = 0;
    assign rom_data_re[281] = -61;
    assign rom_data_im[281] = 0;
    assign rom_data_re[282] = -61;
    assign rom_data_im[282] = 0;
    assign rom_data_re[283] = -61;
    assign rom_data_im[283] = 0;
    assign rom_data_re[284] = -60;
    assign rom_data_im[284] = 0;
    assign rom_data_re[285] = -60;
    assign rom_data_im[285] = 0;
    assign rom_data_re[286] = -60;
    assign rom_data_im[286] = 0;
    assign rom_data_re[287] = -59;
    assign rom_data_im[287] = 0;
    assign rom_data_re[288] = -59;
    assign rom_data_im[288] = 0;
    assign rom_data_re[289] = -59;
    assign rom_data_im[289] = 0;
    assign rom_data_re[290] = -59;
    assign rom_data_im[290] = 0;
    assign rom_data_re[291] = -58;
    assign rom_data_im[291] = 0;
    assign rom_data_re[292] = -58;
    assign rom_data_im[292] = 0;
    assign rom_data_re[293] = -58;
    assign rom_data_im[293] = 0;
    assign rom_data_re[294] = -57;
    assign rom_data_im[294] = 0;
    assign rom_data_re[295] = -57;
    assign rom_data_im[295] = 0;
    assign rom_data_re[296] = -56;
    assign rom_data_im[296] = 0;
    assign rom_data_re[297] = -56;
    assign rom_data_im[297] = 0;
    assign rom_data_re[298] = -56;
    assign rom_data_im[298] = 0;
    assign rom_data_re[299] = -55;
    assign rom_data_im[299] = 0;
    assign rom_data_re[300] = -55;
    assign rom_data_im[300] = 0;
    assign rom_data_re[301] = -54;
    assign rom_data_im[301] = 0;
    assign rom_data_re[302] = -54;
    assign rom_data_im[302] = 0;
    assign rom_data_re[303] = -54;
    assign rom_data_im[303] = 0;
    assign rom_data_re[304] = -53;
    assign rom_data_im[304] = 0;
    assign rom_data_re[305] = -53;
    assign rom_data_im[305] = 0;
    assign rom_data_re[306] = -52;
    assign rom_data_im[306] = 0;
    assign rom_data_re[307] = -52;
    assign rom_data_im[307] = 0;
    assign rom_data_re[308] = -51;
    assign rom_data_im[308] = 0;
    assign rom_data_re[309] = -51;
    assign rom_data_im[309] = 0;
    assign rom_data_re[310] = -50;
    assign rom_data_im[310] = 0;
    assign rom_data_re[311] = -50;
    assign rom_data_im[311] = 0;
    assign rom_data_re[312] = -49;
    assign rom_data_im[312] = 0;
    assign rom_data_re[313] = -49;
    assign rom_data_im[313] = 0;
    assign rom_data_re[314] = -48;
    assign rom_data_im[314] = 0;
    assign rom_data_re[315] = -48;
    assign rom_data_im[315] = 0;
    assign rom_data_re[316] = -47;
    assign rom_data_im[316] = 0;
    assign rom_data_re[317] = -47;
    assign rom_data_im[317] = 0;
    assign rom_data_re[318] = -46;
    assign rom_data_im[318] = 0;
    assign rom_data_re[319] = -46;
    assign rom_data_im[319] = 0;
    assign rom_data_re[320] = -45;
    assign rom_data_im[320] = 0;
    assign rom_data_re[321] = -45;
    assign rom_data_im[321] = 0;
    assign rom_data_re[322] = -44;
    assign rom_data_im[322] = 0;
    assign rom_data_re[323] = -44;
    assign rom_data_im[323] = 0;
    assign rom_data_re[324] = -43;
    assign rom_data_im[324] = 0;
    assign rom_data_re[325] = -42;
    assign rom_data_im[325] = 0;
    assign rom_data_re[326] = -42;
    assign rom_data_im[326] = 0;
    assign rom_data_re[327] = -41;
    assign rom_data_im[327] = 0;
    assign rom_data_re[328] = -41;
    assign rom_data_im[328] = 0;
    assign rom_data_re[329] = -40;
    assign rom_data_im[329] = 0;
    assign rom_data_re[330] = -39;
    assign rom_data_im[330] = 0;
    assign rom_data_re[331] = -39;
    assign rom_data_im[331] = 0;
    assign rom_data_re[332] = -38;
    assign rom_data_im[332] = 0;
    assign rom_data_re[333] = -37;
    assign rom_data_im[333] = 0;
    assign rom_data_re[334] = -37;
    assign rom_data_im[334] = 0;
    assign rom_data_re[335] = -36;
    assign rom_data_im[335] = 0;
    assign rom_data_re[336] = -36;
    assign rom_data_im[336] = 0;
    assign rom_data_re[337] = -35;
    assign rom_data_im[337] = 0;
    assign rom_data_re[338] = -34;
    assign rom_data_im[338] = 0;
    assign rom_data_re[339] = -34;
    assign rom_data_im[339] = 0;
    assign rom_data_re[340] = -33;
    assign rom_data_im[340] = 0;
    assign rom_data_re[341] = -32;
    assign rom_data_im[341] = 0;
    assign rom_data_re[342] = -32;
    assign rom_data_im[342] = 0;
    assign rom_data_re[343] = -31;
    assign rom_data_im[343] = 0;
    assign rom_data_re[344] = -30;
    assign rom_data_im[344] = 0;
    assign rom_data_re[345] = -29;
    assign rom_data_im[345] = 0;
    assign rom_data_re[346] = -29;
    assign rom_data_im[346] = 0;
    assign rom_data_re[347] = -28;
    assign rom_data_im[347] = 0;
    assign rom_data_re[348] = -27;
    assign rom_data_im[348] = 0;
    assign rom_data_re[349] = -27;
    assign rom_data_im[349] = 0;
    assign rom_data_re[350] = -26;
    assign rom_data_im[350] = 0;
    assign rom_data_re[351] = -25;
    assign rom_data_im[351] = 0;
    assign rom_data_re[352] = -24;
    assign rom_data_im[352] = 0;
    assign rom_data_re[353] = -24;
    assign rom_data_im[353] = 0;
    assign rom_data_re[354] = -23;
    assign rom_data_im[354] = 0;
    assign rom_data_re[355] = -22;
    assign rom_data_im[355] = 0;
    assign rom_data_re[356] = -22;
    assign rom_data_im[356] = 0;
    assign rom_data_re[357] = -21;
    assign rom_data_im[357] = 0;
    assign rom_data_re[358] = -20;
    assign rom_data_im[358] = 0;
    assign rom_data_re[359] = -19;
    assign rom_data_im[359] = 0;
    assign rom_data_re[360] = -19;
    assign rom_data_im[360] = 0;
    assign rom_data_re[361] = -18;
    assign rom_data_im[361] = 0;
    assign rom_data_re[362] = -17;
    assign rom_data_im[362] = 0;
    assign rom_data_re[363] = -16;
    assign rom_data_im[363] = 0;
    assign rom_data_re[364] = -16;
    assign rom_data_im[364] = 0;
    assign rom_data_re[365] = -15;
    assign rom_data_im[365] = 0;
    assign rom_data_re[366] = -14;
    assign rom_data_im[366] = 0;
    assign rom_data_re[367] = -13;
    assign rom_data_im[367] = 0;
    assign rom_data_re[368] = -12;
    assign rom_data_im[368] = 0;
    assign rom_data_re[369] = -12;
    assign rom_data_im[369] = 0;
    assign rom_data_re[370] = -11;
    assign rom_data_im[370] = 0;
    assign rom_data_re[371] = -10;
    assign rom_data_im[371] = 0;
    assign rom_data_re[372] = -9;
    assign rom_data_im[372] = 0;
    assign rom_data_re[373] = -9;
    assign rom_data_im[373] = 0;
    assign rom_data_re[374] = -8;
    assign rom_data_im[374] = 0;
    assign rom_data_re[375] = -7;
    assign rom_data_im[375] = 0;
    assign rom_data_re[376] = -6;
    assign rom_data_im[376] = 0;
    assign rom_data_re[377] = -5;
    assign rom_data_im[377] = 0;
    assign rom_data_re[378] = -5;
    assign rom_data_im[378] = 0;
    assign rom_data_re[379] = -4;
    assign rom_data_im[379] = 0;
    assign rom_data_re[380] = -3;
    assign rom_data_im[380] = 0;
    assign rom_data_re[381] = -2;
    assign rom_data_im[381] = 0;
    assign rom_data_re[382] = -2;
    assign rom_data_im[382] = 0;
    assign rom_data_re[383] = -1;
    assign rom_data_im[383] = 0;
    assign rom_data_re[384] = 0;
    assign rom_data_im[384] = 0;
    assign rom_data_re[385] = 1;
    assign rom_data_im[385] = 0;
    assign rom_data_re[386] = 2;
    assign rom_data_im[386] = 0;
    assign rom_data_re[387] = 2;
    assign rom_data_im[387] = 0;
    assign rom_data_re[388] = 3;
    assign rom_data_im[388] = 0;
    assign rom_data_re[389] = 4;
    assign rom_data_im[389] = 0;
    assign rom_data_re[390] = 5;
    assign rom_data_im[390] = 0;
    assign rom_data_re[391] = 5;
    assign rom_data_im[391] = 0;
    assign rom_data_re[392] = 6;
    assign rom_data_im[392] = 0;
    assign rom_data_re[393] = 7;
    assign rom_data_im[393] = 0;
    assign rom_data_re[394] = 8;
    assign rom_data_im[394] = 0;
    assign rom_data_re[395] = 9;
    assign rom_data_im[395] = 0;
    assign rom_data_re[396] = 9;
    assign rom_data_im[396] = 0;
    assign rom_data_re[397] = 10;
    assign rom_data_im[397] = 0;
    assign rom_data_re[398] = 11;
    assign rom_data_im[398] = 0;
    assign rom_data_re[399] = 12;
    assign rom_data_im[399] = 0;
    assign rom_data_re[400] = 12;
    assign rom_data_im[400] = 0;
    assign rom_data_re[401] = 13;
    assign rom_data_im[401] = 0;
    assign rom_data_re[402] = 14;
    assign rom_data_im[402] = 0;
    assign rom_data_re[403] = 15;
    assign rom_data_im[403] = 0;
    assign rom_data_re[404] = 16;
    assign rom_data_im[404] = 0;
    assign rom_data_re[405] = 16;
    assign rom_data_im[405] = 0;
    assign rom_data_re[406] = 17;
    assign rom_data_im[406] = 0;
    assign rom_data_re[407] = 18;
    assign rom_data_im[407] = 0;
    assign rom_data_re[408] = 19;
    assign rom_data_im[408] = 0;
    assign rom_data_re[409] = 19;
    assign rom_data_im[409] = 0;
    assign rom_data_re[410] = 20;
    assign rom_data_im[410] = 0;
    assign rom_data_re[411] = 21;
    assign rom_data_im[411] = 0;
    assign rom_data_re[412] = 22;
    assign rom_data_im[412] = 0;
    assign rom_data_re[413] = 22;
    assign rom_data_im[413] = 0;
    assign rom_data_re[414] = 23;
    assign rom_data_im[414] = 0;
    assign rom_data_re[415] = 24;
    assign rom_data_im[415] = 0;
    assign rom_data_re[416] = 24;
    assign rom_data_im[416] = 0;
    assign rom_data_re[417] = 25;
    assign rom_data_im[417] = 0;
    assign rom_data_re[418] = 26;
    assign rom_data_im[418] = 0;
    assign rom_data_re[419] = 27;
    assign rom_data_im[419] = 0;
    assign rom_data_re[420] = 27;
    assign rom_data_im[420] = 0;
    assign rom_data_re[421] = 28;
    assign rom_data_im[421] = 0;
    assign rom_data_re[422] = 29;
    assign rom_data_im[422] = 0;
    assign rom_data_re[423] = 29;
    assign rom_data_im[423] = 0;
    assign rom_data_re[424] = 30;
    assign rom_data_im[424] = 0;
    assign rom_data_re[425] = 31;
    assign rom_data_im[425] = 0;
    assign rom_data_re[426] = 32;
    assign rom_data_im[426] = 0;
    assign rom_data_re[427] = 32;
    assign rom_data_im[427] = 0;
    assign rom_data_re[428] = 33;
    assign rom_data_im[428] = 0;
    assign rom_data_re[429] = 34;
    assign rom_data_im[429] = 0;
    assign rom_data_re[430] = 34;
    assign rom_data_im[430] = 0;
    assign rom_data_re[431] = 35;
    assign rom_data_im[431] = 0;
    assign rom_data_re[432] = 36;
    assign rom_data_im[432] = 0;
    assign rom_data_re[433] = 36;
    assign rom_data_im[433] = 0;
    assign rom_data_re[434] = 37;
    assign rom_data_im[434] = 0;
    assign rom_data_re[435] = 37;
    assign rom_data_im[435] = 0;
    assign rom_data_re[436] = 38;
    assign rom_data_im[436] = 0;
    assign rom_data_re[437] = 39;
    assign rom_data_im[437] = 0;
    assign rom_data_re[438] = 39;
    assign rom_data_im[438] = 0;
    assign rom_data_re[439] = 40;
    assign rom_data_im[439] = 0;
    assign rom_data_re[440] = 41;
    assign rom_data_im[440] = 0;
    assign rom_data_re[441] = 41;
    assign rom_data_im[441] = 0;
    assign rom_data_re[442] = 42;
    assign rom_data_im[442] = 0;
    assign rom_data_re[443] = 42;
    assign rom_data_im[443] = 0;
    assign rom_data_re[444] = 43;
    assign rom_data_im[444] = 0;
    assign rom_data_re[445] = 44;
    assign rom_data_im[445] = 0;
    assign rom_data_re[446] = 44;
    assign rom_data_im[446] = 0;
    assign rom_data_re[447] = 45;
    assign rom_data_im[447] = 0;
    assign rom_data_re[448] = 45;
    assign rom_data_im[448] = 0;
    assign rom_data_re[449] = 46;
    assign rom_data_im[449] = 0;
    assign rom_data_re[450] = 46;
    assign rom_data_im[450] = 0;
    assign rom_data_re[451] = 47;
    assign rom_data_im[451] = 0;
    assign rom_data_re[452] = 47;
    assign rom_data_im[452] = 0;
    assign rom_data_re[453] = 48;
    assign rom_data_im[453] = 0;
    assign rom_data_re[454] = 48;
    assign rom_data_im[454] = 0;
    assign rom_data_re[455] = 49;
    assign rom_data_im[455] = 0;
    assign rom_data_re[456] = 49;
    assign rom_data_im[456] = 0;
    assign rom_data_re[457] = 50;
    assign rom_data_im[457] = 0;
    assign rom_data_re[458] = 50;
    assign rom_data_im[458] = 0;
    assign rom_data_re[459] = 51;
    assign rom_data_im[459] = 0;
    assign rom_data_re[460] = 51;
    assign rom_data_im[460] = 0;
    assign rom_data_re[461] = 52;
    assign rom_data_im[461] = 0;
    assign rom_data_re[462] = 52;
    assign rom_data_im[462] = 0;
    assign rom_data_re[463] = 53;
    assign rom_data_im[463] = 0;
    assign rom_data_re[464] = 53;
    assign rom_data_im[464] = 0;
    assign rom_data_re[465] = 54;
    assign rom_data_im[465] = 0;
    assign rom_data_re[466] = 54;
    assign rom_data_im[466] = 0;
    assign rom_data_re[467] = 54;
    assign rom_data_im[467] = 0;
    assign rom_data_re[468] = 55;
    assign rom_data_im[468] = 0;
    assign rom_data_re[469] = 55;
    assign rom_data_im[469] = 0;
    assign rom_data_re[470] = 56;
    assign rom_data_im[470] = 0;
    assign rom_data_re[471] = 56;
    assign rom_data_im[471] = 0;
    assign rom_data_re[472] = 56;
    assign rom_data_im[472] = 0;
    assign rom_data_re[473] = 57;
    assign rom_data_im[473] = 0;
    assign rom_data_re[474] = 57;
    assign rom_data_im[474] = 0;
    assign rom_data_re[475] = 58;
    assign rom_data_im[475] = 0;
    assign rom_data_re[476] = 58;
    assign rom_data_im[476] = 0;
    assign rom_data_re[477] = 58;
    assign rom_data_im[477] = 0;
    assign rom_data_re[478] = 59;
    assign rom_data_im[478] = 0;
    assign rom_data_re[479] = 59;
    assign rom_data_im[479] = 0;
    assign rom_data_re[480] = 59;
    assign rom_data_im[480] = 0;
    assign rom_data_re[481] = 59;
    assign rom_data_im[481] = 0;
    assign rom_data_re[482] = 60;
    assign rom_data_im[482] = 0;
    assign rom_data_re[483] = 60;
    assign rom_data_im[483] = 0;
    assign rom_data_re[484] = 60;
    assign rom_data_im[484] = 0;
    assign rom_data_re[485] = 61;
    assign rom_data_im[485] = 0;
    assign rom_data_re[486] = 61;
    assign rom_data_im[486] = 0;
    assign rom_data_re[487] = 61;
    assign rom_data_im[487] = 0;
    assign rom_data_re[488] = 61;
    assign rom_data_im[488] = 0;
    assign rom_data_re[489] = 61;
    assign rom_data_im[489] = 0;
    assign rom_data_re[490] = 62;
    assign rom_data_im[490] = 0;
    assign rom_data_re[491] = 62;
    assign rom_data_im[491] = 0;
    assign rom_data_re[492] = 62;
    assign rom_data_im[492] = 0;
    assign rom_data_re[493] = 62;
    assign rom_data_im[493] = 0;
    assign rom_data_re[494] = 62;
    assign rom_data_im[494] = 0;
    assign rom_data_re[495] = 63;
    assign rom_data_im[495] = 0;
    assign rom_data_re[496] = 63;
    assign rom_data_im[496] = 0;
    assign rom_data_re[497] = 63;
    assign rom_data_im[497] = 0;
    assign rom_data_re[498] = 63;
    assign rom_data_im[498] = 0;
    assign rom_data_re[499] = 63;
    assign rom_data_im[499] = 0;
    assign rom_data_re[500] = 63;
    assign rom_data_im[500] = 0;
    assign rom_data_re[501] = 63;
    assign rom_data_im[501] = 0;
    assign rom_data_re[502] = 64;
    assign rom_data_im[502] = 0;
    assign rom_data_re[503] = 64;
    assign rom_data_im[503] = 0;
    assign rom_data_re[504] = 64;
    assign rom_data_im[504] = 0;
    assign rom_data_re[505] = 64;
    assign rom_data_im[505] = 0;
    assign rom_data_re[506] = 64;
    assign rom_data_im[506] = 0;
    assign rom_data_re[507] = 64;
    assign rom_data_im[507] = 0;
    assign rom_data_re[508] = 64;
    assign rom_data_im[508] = 0;
    assign rom_data_re[509] = 64;
    assign rom_data_im[509] = 0;
    assign rom_data_re[510] = 64;
    assign rom_data_im[510] = 0;
    assign rom_data_re[511] = 64;
    assign rom_data_im[511] = 0;

    // u_fft_fixed의 출력을 모듈의 출력 포트로 연결
    assign sys_rst = rstn & locked;


    // ## 3. 상태 머신 및 카운터 제어 로직 ##
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            state     <= S_SEND;  // 리셋 시 데이터 전송부터 시작
            cycle_cnt <= 0;
            delay_cnt <= 0;
        end else begin
            case (state)
                S_SEND: begin
                    // 32클럭 동안 데이터 전송
                    if (cycle_cnt == 31) begin
                        state     <= S_WAIT_EN; // 전송 완료 후 대기 상태로 전환
                        cycle_cnt <= 0;         // 다음 전송을 위해 카운터 리셋
                    end else begin
                        cycle_cnt <= cycle_cnt + 1;
                    end
                end
                S_WAIT_EN: begin
                    state     <= S_DELAY;
                    delay_cnt <= 0;  // 지연 카운트 시작
                end
                S_DELAY: begin
                    // 8클럭 동안 지연
                    if (delay_cnt == 6) begin
                        state     <= S_SEND;    // 지연 완료 후 다시 전송 상태로 전환
                        delay_cnt <= 0;
                    end else begin
                        delay_cnt <= delay_cnt + 1;
                    end
                end

                default: begin
                    state <= S_SEND;
                end
            endcase
        end
    end


    // ## 4. 데이터 경로 로직 ##

    // din_valid는 S_SEND 상태일 때만 1이 됨
    assign din_valid = (state == S_SEND);

    // 병렬 데이터 생성 (이전과 동일)
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : data_gen_loop
            wire [8:0] rom_addr = cycle_cnt * 16 + i;
            assign din_i[i] = rom_data_re[rom_addr];
            assign din_q[i] = rom_data_im[rom_addr];
        end
    endgenerate

    clk_wiz_0 CLK_WIZ (
        // Clock out ports
        .clk(clk),
        .locked(locked),
        // Status and control signals
        .resetn(sys_rst),
        // Clock in ports
        .clk_in1_p(clk_in1_p),
        .clk_in1_n(clk_in1_n)
    );

    // ## 5. FFT_Fixed 모듈 인스턴스화 ##
    FFT_Fixed #(
        .WIDTH_IN (9),
        .WIDTH_OUT(13),
        .ARRAY_IN (16),
        .ARRAY_BTF(16)
    ) u_fft_fixed (
        .clk(clk),
        .rstn(sys_rst),
        .din_valid(din_valid),
        .din_i(din_i),
        .din_q(din_q),
        .do_en(fft_do_en),  // FSM을 제어할 출력 신호
        .do_re(fft_do_re),
        .do_im(fft_do_im)
    );

    vio_0 U_VIO (
        .clk(clk),
        .probe_in0(fft_do_en),
        .probe_in1(fft_do_re[0]),
        .probe_in2(fft_do_re[1]),
        .probe_in3(fft_do_re[2]),
        .probe_in4(fft_do_re[3]),
        .probe_in5(fft_do_re[4]),
        .probe_in6(fft_do_re[5]),
        .probe_in7(fft_do_re[6]),
        .probe_in8(fft_do_re[7]),
        .probe_in9(fft_do_re[8]),
        .probe_in10(fft_do_re[9]),
        .probe_in11(fft_do_re[10]),
        .probe_in12(fft_do_re[11]),
        .probe_in13(fft_do_re[12]),
        .probe_in14(fft_do_re[13]),
        .probe_in15(fft_do_re[14]),
        .probe_in16(fft_do_re[15]),
        .probe_in17(fft_do_im[0]),
        .probe_in18(fft_do_im[1]),
        .probe_in19(fft_do_im[2]),
        .probe_in20(fft_do_im[3]),
        .probe_in21(fft_do_im[4]),
        .probe_in22(fft_do_im[5]),
        .probe_in23(fft_do_im[6]),
        .probe_in24(fft_do_im[7]),
        .probe_in25(fft_do_im[8]),
        .probe_in26(fft_do_im[9]),
        .probe_in27(fft_do_im[10]),
        .probe_in28(fft_do_im[11]),
        .probe_in29(fft_do_im[12]),
        .probe_in30(fft_do_im[13]),
        .probe_in31(fft_do_im[14]),
        .probe_in32(fft_do_im[15]),
        .probe_out0()
    );

endmodule
