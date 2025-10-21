`timescale 1ns / 1ps

// FFT_Top_With_ROM 모듈을 테스트하기 위한 단순화된 테스트벤치
module tb_fft_top;

    // 테스트벤치 신호 선언
    logic clk;
    logic rstn;

    // DUT의 최종 출력을 모니터링하기 위한 wire
    wire do_en;
    wire signed [12:0] do_re[0:15]; // WIDTH_OUT = 13
    wire signed [12:0] do_im[0:15];

    // DUT 인스턴스화 (FFT_Top_With_ROM으로 변경)
    // 참고: FFT_Top_With_ROM 모듈에도 아래 출력 포트들을 추가해야 합니다.
    FFT_Top_With_ROM dut (
        .clk(clk),
        .rstn(rstn),
        .do_en(do_en),
        .do_re(do_re),
        .do_im(do_im)
    );

    // 클럭 생성 (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 단순화된 테스트 시퀀스
    initial begin
        // 1. 리셋 신호 인가
        rstn = 0;
        
        // 2. 리셋을 20ns 동안 유지 후 해제
        #20;
        rstn = 1;

        // 3. 시뮬레이션 실행
        // DUT가 무한 반복하므로, 2~3번의 루프를 관찰할 수 있도록
        // 충분한 시간(예: 5000ns) 동안 실행합니다.
        #5000;

        $display("Simulation finished after 5000ns.");
        $finish; // 시뮬레이션 종료
    end
    
endmodule