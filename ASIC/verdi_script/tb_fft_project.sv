`timescale 1ns / 1ps

module tb_fft_input;

    // DUT (FFT_Float) 파라미터와 동일하게 설정
    parameter WIDTH_IN  = 9;
    parameter WIDTH_OUT = 13;
    parameter ARRAY_IN  = 16;
    parameter ARRAY_BTF = 16;

    // 테스트벤치 신호 선언
    logic clk;
    logic rstn;
    logic din_valid;
    logic signed [WIDTH_IN-1:0] din_i[0:ARRAY_IN-1];
    logic signed [WIDTH_IN-1:0] din_q[0:ARRAY_IN-1];
    logic do_en;
    logic signed [WIDTH_OUT-1:0] do_re[0:ARRAY_BTF-1];
    logic signed [WIDTH_OUT-1:0] do_im[0:ARRAY_BTF-1];

    // 입력 데이터 파일에서 읽어올 배열 선언
    localparam DATA_SIZE = 512;
    integer real_data_mem[0:DATA_SIZE-1];
    integer imag_data_mem[0:DATA_SIZE-1];

    // 파일 핸들
    integer real_file_ptr;
    integer imag_file_ptr;
    integer scan_result;

    // 데이터 인덱스
    integer data_idx;

    // DUT 인스턴스화
    FFT_Fixed #(
        .WIDTH_IN(WIDTH_IN),
        .WIDTH_OUT(WIDTH_OUT),
        .ARRAY_IN(ARRAY_IN),
        .ARRAY_BTF(ARRAY_BTF)
    ) dut (
        .clk(clk),
        .rstn(rstn),
        .din_valid(din_valid),
        .din_i(din_i),
        .din_q(din_q),
        .do_en(do_en),
        .do_re(do_re),
        .do_im(do_im)
    );

    // 클럭 생성
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns 주기 (100MHz 클럭)
    end

    // 테스트 시퀀스
    initial begin
        // 1. 초기화
        rstn = 0;
        din_valid = 0;
        for (int i = 0; i < ARRAY_IN; i++) begin
            din_i[i] = 0;
            din_q[i] = 0;
        end
        data_idx = 0;

        // 2. 파일 열기 및 데이터 로드 (실수부, 허수부)
        real_file_ptr = $fopen("./fft_data/fixed_data_real_rand.txt", "r");
        imag_file_ptr = $fopen("./fft_data/fixed_data_imag_rand.txt", "r");

        if (real_file_ptr == 0 || imag_file_ptr == 0) begin
            $display("Error: Could not open data files.");
            $finish;
        end

        for (int k = 0; k < DATA_SIZE; k++) begin
            scan_result = $fscanf(real_file_ptr, "%d", real_data_mem[k]);
            if (scan_result != 1) begin
                $display("Error: fixed_data_real.txt has fewer than %0d lines.", DATA_SIZE);
                $finish;
            end
            scan_result = $fscanf(imag_file_ptr, "%d", imag_data_mem[k]);
            if (scan_result != 1) begin
                $display("Error: fixed_data_imag.txt has fewer than %0d lines.", DATA_SIZE);
                $finish;
            end
        end

        $fclose(real_file_ptr);
        $fclose(imag_file_ptr);
        $display("Data files loaded successfully.");

        #10; // 리셋 유지
        rstn = 1; // 리셋 해제
        #10; // 안정화 시간

        // 3. DUT에 데이터 입력 (1클럭에 16개씩)
        // 512개의 데이터를 16개씩 32번의 클럭 동안 입력
        din_valid = 1; // 데이터 입력을 시작하기 전에 valid 신호를 활성화
        
        while (data_idx < DATA_SIZE) begin
            @(posedge clk); // 클럭 엣지에서 데이터 입력

            // 16개씩 데이터 할당
            for (int i = 0; i < ARRAY_IN; i++) begin
                din_i[i] = real_data_mem[data_idx + i];
                din_q[i] = imag_data_mem[data_idx + i];
            end
            data_idx = data_idx + ARRAY_IN; // 다음 16개 데이터를 위해 인덱스 증가
        end

        // 32번의 데이터 입력이 모두 완료된 후, 다음 클럭 엣지에서 din_valid를 비활성화
        @(posedge clk);
        din_valid = 0;

        // 모든 데이터가 입력된 후 추가 클럭을 제공하여 DUT가 연산을 완료하도록 함
        repeat (200) @(posedge clk);

        $display("Simulation finished.");
        $finish; // 시뮬레이션 종료
    end
endmodule