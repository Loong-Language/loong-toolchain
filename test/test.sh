#!/bin/bash

rm -f *.ll *.v *.out

LLVM_HOME=/opt/loong-llvm
CC=$LLVM_HOME/bin/clang
OPT=$LLVM_HOME/bin/opt
LOONG_LIB=$LLVM_HOME/lib/LoongLLVM.so

$CC --version

$CC empty.loong -S -emit-llvm -Werror -o empty.loong.ll

$CC sillyfunction.loong -S -emit-llvm -Werror -o sillyfunction.loong.ll
$OPT -S -load $LOONG_LIB -generate-verilog sillyfunction.loong.ll 2> sillyfunction.v > /dev/null

$CC inv.loong -S -emit-llvm -Werror -o inv.loong.ll
$CC gates.loong -S -emit-llvm -Werror -o gates.loong.ll
$CC and8.loong -S -emit-llvm -Werror -o and8.loong.ll
$CC mux2.loong -S -emit-llvm -Werror -o mux2.loong.ll
$CC mux4.loong -S -emit-llvm -Werror -o mux4.loong.ll
$CC fulladder.loong -S -emit-llvm -Werror -o fulladder.loong.ll
$CC smux4.loong -S -emit-llvm -Werror -o smux4.loong.ll
$CC flop.loong -S -emit-llvm -Werror -o flop.loong.ll
