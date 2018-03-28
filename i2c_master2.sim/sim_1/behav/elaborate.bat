@echo off
set xv_path=C:\\XilinX\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 8d8420b21c4e4ec2b1610e96dc0f42a0 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot master_tb_behav xil_defaultlib.master_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
