@echo off
set xv_path=C:\\XilinX\\Vivado\\2016.2\\bin
call %xv_path%/xsim master_tb_behav -key {Behavioral:sim_1:Functional:master_tb} -tclbatch master_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
