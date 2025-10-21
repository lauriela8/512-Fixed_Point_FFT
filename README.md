# 512-Fixed_Point_FFT

## 프로젝트 개요 (Overview)
본 프로젝트는 512-point FFT(Fast Fourier Transform) 연산을 고정소수점(Fixed-Point) 기반으로 수행하는 하드웨어 구조를 설계하고, ASIC 합성 및 FPGA 타이밍 환경에서 검증하는 것을 목표로 수행되었습니다.  
알고리즘은 Radix-2 구조를 기반으로 단계별 연산 모듈(Module0 → Module1 → Module2)로 구성되었으며, 각 단계 사이에는 CBFP기반 스케일링 로직을 삽입하여 오버플로를 방지하고 연산 품질(SQNR)을 확보하도록 설계하였습니다.
전체 설계는 Verilog/SystemVerilog로 RTL 수준에서 구현되었으며, Synopsys Design Compiler를 활용하여 ASIC 합성 및 타이밍 분석을 수행하였습니다. 또한 Verdi 기반 게이트 레벨 시뮬레이션을 통해 게이트 레벨 넷리스트와 RTL 결과의 일치성을 확인하였으며, MATLAB Fixed-Point 모델과의 출력 비교를 통해 알고리즘적 정확성을 검증하였습니다.

## 주요 목표 (Objectives)
1. Radix-2 기반 512-point FFT 알고리즘의 RTL 구현
  - Butterfly 구조를 활용한 단계별 FFT 모듈화를 수행하였습니다.
  - Bit Reversal 과정을 포함한 전체 데이터 경로를 하드웨어 파이프라인 흐름에 맞게 구성하였습니다.

2. CBFP(Common Block Floating Point) 기반 스케일링 적용
  - 고정소수점 연산 특성상 발생하는 오버플로 문제를 방지하기 위해 각 Stage 간 스케일링을 적용하였습니다.
  - SQNR 개선을 고려하여 연산 단계별 비트 시프트 제어 방식으로 구현하였습니다.

3. ASIC 합성 및 Timing Closure 달성
  - Synopsys Design Compiler 기반 합성 및 Timing Report 분석을 통해 타이밍 여유를 확보하였습니다.
  - Cell 사용량, Slack, Area 정보를 분석하여 구조적 최적화 방향을 도출하였습니다.

4. FPGA 구현 가능성 및 확장성 검증
  - ASIC 합성 결과를 기반으로 FPGA 환경에 적용 가능한 구조적 조건을 점검하였습니다.

5. RTL → Gate-Level → MATLAB Fixed-Point 모델 간 정확성 검증
  - RTL 및 Gate-Level 시뮬레이션을 통해 연산 결과의 정합성을 검증하였습니다.
  - MATLAB Fixed-Point 모델과의 비교를 통해 연산 정확도를 평가하였습니다.

## 개발 환경 (Environment & Tools)
| 구분         | 사용 도구                        | 목적                                       |
| ---------- | ---------------------------- | ---------------------------------------- |
| HDL 설계     | Verilog / SystemVerilog      | FFT 모듈 및 CBFP 연산 RTL 구현                  |
| 알고리즘 참조 모델 | MATLAB (Fixed-Point Toolbox) | FFT 연산 정확도 검증 및 SQNR 비교                  |
| ASIC 합성    | Synopsys Design Compiler     | Area / Timing 분석 및 Gate-Level Netlist 생성 |
| 게이트 시뮬레이션  | Synopsys Verdi               | Gate-Level Simulation 및 신호 추적            |
| FPGA 분석    | Xilinx Vivado (Optional)     | FPGA 적용 가능성 및 리소스 활용성 평가                 |
| 시뮬레이션 툴    | VCS 또는 ModelSim (환경에 따라 변경)  | RTL 동작 검증 및 알고리즘 정합성 확인                  |
| 버전 관리      | GitHub                       | 코드 및 구조 버전 관리, 이력 추적                     |

---

## 전체 시스템 구조 (Architecture & Flow)
- FFT 파이프라인: Module0 → CBFP0 → Module1 → CBFP1 → Module2 → Bit Reversal
- Radix-2 DIF or SDF 구조 설명
<img width="844" height="652" alt="image" src="https://github.com/user-attachments/assets/41cf4eb9-1f60-447e-a540-34eca4eb5201" />  


### Stage 0 – Module0 + CBFP(Stage0)

**Stage 0은 FFT의 초기 연산을 수행하는 Module0과, 해당 연산 결과의 비트 스케일을 정규화하는 CBFP Stage0로 구성됩니다.**
이 단계는 전체 FFT 변환의 시작점으로서, 입력 데이터를 Radix-2 기반 Butterfly 구조로 처리하여 주파수 도메인의 첫 변환을 수행합니다. 이후 CBFP Stage0에서 연산 결과의 오버플로 가능성을 방지하고 다음 Stage에서 처리 가능한 비트 범위로 조정합니다.  

#### 역할 요약
| 블록 | 기능 | 비고 |
|------|------|------|
| Module0 | Radix-2 Butterfly 기반 FFT 초기 변환 | Fixed-Point 데이터 기반 |
| CBFP Stage0 | MSB 기반 Shift 정규화 → Scaling 적용 | Overflow 방지 및 SQNR 유지 |

#### Module0 구조 다이어그램
<img width="847" height="678" alt="Module0 구조" src="https://github.com/user-attachments/assets/d5d2ca50-c554-46cf-9b2e-195da918b215" />

#### CBFP Stage0 구조 다이어그램
<img width="770" height="1173" alt="CBFP Stage0 구조" src="https://github.com/user-attachments/assets/0f54037c-4418-4a7b-93e1-64e317d198dc" />


### Stage 1 ~ Stage 2 요약 (중간/최종 변환 및 주파수 정렬)

Stage1부터는 Stage0에서 정규화된 데이터를 기반으로 FFT 연산이 단계적으로 확장됩니다.  
각 Stage는 동일한 Radix-2 Butterfly 구조를 기반으로 동작하며, 주파수 분해도가 점진적으로 증가합니다.


#### 단계별 수행 요약

| Stage | 구성 블록 | 역할 | 비고 |
|-------|-----------|------|------|
| Stage1 | Module1 + CBFP1 | FFT 중간 대역 확장 및 비트 정규화 | Stage0 구조 확장 |
| Stage2 | Module2 | 최종 주파수 도메인 변환 | CBFP 미적용 |

#### Bit Reversal

---

### 전체 FFT 출력 시뮬레이션 결과 (RTL vs Fixed-Point 모델 비교)

모든 FFT Stage(Module0 → CBFP0 → Module1 → CBFP1 → Module2 → Bit Reversal)를 통합한 상태에서,
최종 출력 데이터를 MATLAB Fixed-Point Reference 모델과 비교하여 알고리즘 정확성을 검증하였습니다.


#### 시뮬레이션 기준
| 항목 | 설정 |
|------|------|
| 입력 길이 | 512-point |
| 입력 타입 | Fixed-Point (Real/Imag 또는 Real-only) |
| 비교 기준 | MATLAB Fixed-Point FFT 모델 |
| 정합성 검증 방식 | RTL 결과 vs MATLAB 결과 1:1 매칭 |


#### 출력 결과 비교
**Cosine 입력 기반 RTL 시뮬레이션 결과**
- MATLAB 참조 결과와 동일한 FFT 출력값을 확인
<img width="2681" height="248" alt="image" src="https://github.com/user-attachments/assets/87eaf7a3-ae28-483a-b9bf-8b755e56ab5b" />

| Index | 497 | 498 | 499 | 500 | 501 | 502 | 503 | 504 | 505 | 506 | 507 | 508 | 509 | 510 | 511 | 512 |
|-------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
| Real  | -1  | 3   | -1  | 3   | -1  | -1  | 5   | -1  | -1  | -1  | -1  | -1  | -1  | 2   | -1  | 4091 |
| Imag  | 0   | -1  | 0   | 0   | 0   | 0   | 1   | -2  | 0   | 2   | 0   | 0   | 3   | 87  | 61  | -113 |

<br>

**Random 입력 기반 RTL 시뮬레이션 결과**
- 임의의 입력 데이터에 대해서도 MATLAB 모델과 동일한 FFT 결과를 확인
<img width="2681" height="257" alt="image" src="https://github.com/user-attachments/assets/b68e57b1-394b-4355-826f-ccf5f45ee78f" />

| Index | 497 | 498 | 499 | 500 | 501 | 502 | 503 | 504 | 505 | 506 | 507 | 508 | 509 | 510 | 511 | 512 |
|-------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
| Real  | 56  | 95  | 119 | -23 | 27  | -20 | 6   | 24  | 19  | -100| -33 | 16  | -21 | 3   | 87  | 36  |
| Imag  | -29 | 78  | -116| -29 | 103 | 37  | -82 | -85 | 72  | 46  | -11 | 82  | 65  | 43  | 61  | -113 |

<br>

**Gate-Level Simulation 기반 결과**
- 합성된 넷리스트 기반으로 RTL과 동일한 결과를 확인  
- ASIC Flow 전체 검증을 통해 Logic-Level, Timing-Level 모두 정합성 확보
<img width="2619" height="288" alt="image" src="https://github.com/user-attachments/assets/fa086703-dfec-4483-8920-a56eca964365" />
<img width="2619" height="275" alt="image" src="https://github.com/user-attachments/assets/fa3650b6-8f0f-4326-9559-7e721dba3962" />

| 구분 | Imaginary (do_im) | Real (do_re) | Imag 10진수 | Real 10진수 |
|------|------------------|--------------|-------------|-------------|
| 출력 1 | 0_0000_0000_0000 | 0_1111_1111_1011 | 0 | 4091 |
| 출력 2 | 0_0000_0000_0000 | 1_1111_1111_1111 | 0 | -1 |
| 출력 3 | 0_0000_0000_0000 | 0_0000_0000_0010 | 0 | 2 |

