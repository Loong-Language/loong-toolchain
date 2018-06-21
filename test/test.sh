#!/bin/bash

rm -f *.ll *.out

LLVM_HOME=/opt/loong-llvm
CC=$LLVM_HOME/bin/clang

$CC --version
$CC empty.loong -S -emit-llvm -Werror -o empty.loong.ll
$CC sillyfunction.loong -S -emit-llvm -Werror -o sillyfunction.loong.ll
$CC inv.loong -S -emit-llvm -Werror -o inv.loong.ll
$CC gates.loong -S -emit-llvm -Werror -o gates.loong.ll
$CC and8.loong -S -emit-llvm -Werror -o and8.loong.ll
$CC mux2.loong -S -emit-llvm -Werror -o mux2.loong.ll
