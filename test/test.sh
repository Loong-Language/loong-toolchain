#!/bin/bash

rm -f *.ll *.v *.out

LLVM_HOME=/opt/loong-llvm
CXX=$LLVM_HOME/bin/clang++
OPT=$LLVM_HOME/bin/opt
LOONG_LIB=$LLVM_HOME/lib/LoongLLVM.so
CXXFLAG="-Xclang -disable-O0-optnone -S -emit-llvm -Werror -std=c++17"
ASTDUMP="-Xclang -ast-dump -fsyntax-only"

$CXX --version

$CXX empty.loong $CXXFLAG -o empty.loong.ll

$CXX -std=c++17 -DDEBUG sillyfunction.loong
$CXX $ASTDUMP sillyfunction.loong
$CXX sillyfunction.loong $CXXFLAG -o sillyfunction.loong.ll
$OPT -S -load $LOONG_LIB -generate-verilog sillyfunction.loong.ll 2> sillyfunction.v > /dev/null

$CXX $ASTDUMP inv.loong
$CXX inv.loong $CXXFLAG -o inv.loong.ll

$CXX $ASTDUMP gates.loong
$CXX gates.loong $CXXFLAG -o gates.loong.ll

$CXX $ASTDUMP and8.loong
$CXX and8.loong $CXXFLAG -o and8.loong.ll

$CXX $ASTDUMP mux2.loong
$CXX mux2.loong $CXXFLAG -o mux2.loong.ll

$CXX $ASTDUMP mux4.loong
$CXX mux4.loong $CXXFLAG -o mux4.loong.ll

$CXX $ASTDUMP fulladder.loong
$CXX fulladder.loong $CXXFLAG -o fulladder.loong.ll

$CXX $ASTDUMP smux4.loong
$CXX smux4.loong $CXXFLAG -o smux4.loong.ll

$CXX $ASTDUMP flop.loong
$CXX flop.loong $CXXFLAG -o flop.loong.ll
