#!/bin/bash

rm -f *.ll *.v *.out

LLVM_HOME=/opt/loong-llvm
CC=$LLVM_HOME/bin/clang
OPT=$LLVM_HOME/bin/opt
LOONG_LIB=$LLVM_HOME/lib/LoongLLVM.so
CFLAG="-Xclang -disable-O0-optnone -S -emit-llvm -Werror"

$CC --version

$CC empty.loong $CFLAG -o empty.loong.ll

$CC sillyfunction.loong $CFLAG -o sillyfunction.loong.ll
$OPT -S -load $LOONG_LIB -generate-verilog sillyfunction.loong.ll 2> sillyfunction.v > /dev/null

$CC inv.loong $CFLAG -o inv.loong.ll
$CC gates.loong $CFLAG -o gates.loong.ll
$CC and8.loong $CFLAG -o and8.loong.ll
$CC mux2.loong $CFLAG -o mux2.loong.ll
$CC mux4.loong $CFLAG -o mux4.loong.ll
$CC fulladder.loong $CFLAG -o fulladder.loong.ll
$CC smux4.loong $CFLAG -o smux4.loong.ll
$CC flop.loong $CFLAG -o flop.loong.ll
