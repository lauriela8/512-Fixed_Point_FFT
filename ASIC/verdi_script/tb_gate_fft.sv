`timescale 1ps / 1fs

module tb_gate_fft_input;

    // DUT 파라미터
    parameter WIDTH_IN  = 9;
    parameter WIDTH_OUT = 11;
    parameter ARRAY_IN  = 16;
    parameter ARRAY_BTF = 16;

    // --- 수정된 부분: timescale에 유연한 클럭 주기 정의 ---
    parameter real T_CLK = 10.0; // 목표 주파수 100MHz -> 주기 10ns

    // 신호 선언
    localparam FLAT_WIDTH_IN  = WIDTH_IN * ARRAY_IN;
    localparam FLAT_WIDTH_OUT = WIDTH_OUT * ARRAY_BTF;

    logic clk;
    logic rstn;
    logic din_valid;
    logic signed [FLAT_WIDTH_IN-1:0]  flat_din_i;
    logic signed [FLAT_WIDTH_IN-1:0]  flat_din_q;
    logic do_en;
    logic signed [FLAT_WIDTH_OUT-1:0] flat_do_re;
    logic signed [FLAT_WIDTH_OUT-1:0] flat_do_im;
    wire signed [WIDTH_OUT-1:0] do_re[0:ARRAY_BTF-1];
    wire signed [WIDTH_OUT-1:0] do_im[0:ARRAY_BTF-1];

    // 데이터 메모리 및 파일 관련 변수
    localparam DATA_SIZE = 512;
    integer real_data_mem[0:DATA_SIZE-1];
    integer imag_data_mem[0:DATA_SIZE-1];
    integer real_file_ptr, imag_file_ptr, scan_result;
    integer data_idx;

    // DUT 인스턴스 (파라미터 오버라이드 제거)
    Bfy_Module_0 dut (
        .clk(clk),
        .rstn(rstn),
        .din_valid(din_valid),
        .din_i(flat_din_i),
        .din_q(flat_din_q),
        .do_en(do_en),
        .do_re(flat_do_re),
        .do_im(flat_do_im),
        .index_out()
    );

    // --- 수정된 부분: 유연한 클럭 생성 ---
    initial begin
        clk = 0;
        forever #(T_CLK/2.0) clk = ~clk;
    end

    // 테스트 시퀀스
    initial begin
        rstn = 0;
        din_valid = 0;
        flat_din_i = 0;
        flat_din_q = 0;
        data_idx = 0;

        real_file_ptr = $fopen("./fft_data/fixed_data_real.txt", "r");
        imag_file_ptr = $fopen("./fft_data/fixed_data_imag.txt", "r");

        if (real_file_ptr == 0 || imag_file_ptr == 0) begin
            $display("Error: Could not open data files.");
            $finish;
        end

        for (int k = 0; k < DATA_SIZE; k++) begin
            scan_result = $fscanf(real_file_ptr, "%d", real_data_mem[k]);
            scan_result = $fscanf(imag_file_ptr, "%d", imag_data_mem[k]);
        end

        $fclose(real_file_ptr);
        $fclose(imag_file_ptr);
        $display("Data files loaded successfully.");

        // --- 수정된 부분: 클럭 사이클 기반 지연 ---
        repeat(1000) @(posedge clk); // 리셋 유지
        rstn = 1; // 리셋 해제
        repeat(1000) @(posedge clk); // 안정화 시간

        din_valid = 1;
        while (data_idx < DATA_SIZE) begin
            @(posedge clk);
            for (int i = 0; i < ARRAY_IN; i++) begin
                flat_din_i[i*WIDTH_IN +: WIDTH_IN] = real_data_mem[data_idx + i];
                flat_din_q[i*WIDTH_IN +: WIDTH_IN] = imag_data_mem[data_idx + i];
            end
            data_idx = data_idx + ARRAY_IN;
        end

        @(posedge clk);
        din_valid = 0;

        repeat (200000) @(posedge clk);

        $display("Simulation finished.");
        $finish;
    end
    
    // 출력 데이터 분리
    genvar i;
    generate
        for (i = 0; i < ARRAY_BTF; i++) begin : unpack_output
            assign do_re[i] = flat_do_re[i*WIDTH_OUT +: WIDTH_OUT];
            assign do_im[i] = flat_do_im[i*WIDTH_OUT +: WIDTH_OUT];
        end
    endgenerate

endmodule