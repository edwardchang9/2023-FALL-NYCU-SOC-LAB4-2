# 2023-FALL-NYCU-SOC-LAB4-2
## Introduction
Lab4 of NYCU SOC Design Course

## Toolchain Prerequisites
* [Ubuntu 20.04+](https://releases.ubuntu.com/focal/)
* [Xilinx Vitis 2022.1](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2022-1.html)
* [GTKWave v3.3.103](https://gtkwave.sourceforge.net/)
* [RISC-V GCC Toolchains rv32i-4.0.0](https://github.com/stnolting/riscv-gcc-prebuilt)

## Setup Toolchain
Get presetup Vitis Virtual Machine from course TA or setup following toolchains yourself.
* Ubuntu 20.04+ and Xilinx Vitis
* GTKWave and RISC-V GCC Toolchains
```sh
sudo apt update
sudo apt install gtkwave git -y
sudo wget -O /tmp/riscv32-unknown-elf.gcc-12.1.0.tar.gz https://github.com/stnolting/riscv-gcc-prebuilt/releases/download/rv32i-4.0.0/riscv32-unknown-elf.gcc-12.1.0.tar.gz
sudo mkdir /opt/riscv
sudo tar -xzf /tmp/riscv32-unknown-elf.gcc-12.1.0.tar.gz -C /opt/riscv
echo 'export PATH=$PATH:/opt/riscv/bin' >> ~/.bashrc
source ~/.bashrc
```

## Run this code
```sh
git clone https://github.com/edwardchang9/2023-FALL-NYCU-SOC-LAB4-2
cd ~/2023-FALL-NYCU-SOC-LAB4-2/testbench/counter_la_fir/
source run_clean
source run_sim
```
