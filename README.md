Loong Language Toolchain
------------------------

hello.loong -> LLVM IR -> OPT PASS -> LLVM IR' -> V2C PASS -> optimized circuit

## Build

```
$ git clone git@github.com:Loong-Language/loong-llvm.git
$ cd loong-llvm/tools
$ git clone git@github.com:Loong-Language/loong-clang.git clang
$ cd ..
$ mkdir build
$ cd build
$ sudo yum install libffi-devel binutils-devel
$ cmake .. -DCMAKE_INSTALL_PREFIX=/opt/loong-llvm \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DCMAKE_CXX_FLAGS="-std=c++11 -fPIC" \
    -DLLVM_BUILD_LLVM_DYLIB=ON \
    -DLLVM_LINK_LLVM_DYLIB=ON \
    -DLLVM_INSTALL_UTILS=ON \
    -DLLVM_ENABLE_RTTI=ON \
    -DLLVM_ENABLE_FFI=ON \
    -DLLVM_ENABLE_EH=ON \
    -DLLVM_BUILD_TESTS=OFF \
    -DLLVM_BUILD_DOCS=OFF \
    -DLLVM_ENABLE_SPHINX=OFF \
    -DLLVM_ENABLE_DOXYGEN=OFF \
    -DLLDB_DISABLE_LIBEDIT=1 \
    -DSPHINX_WARNINGS_AS_ERRORS=OFF \
    -DFFI_INCLUDE_DIR=$(pkg-config --variable=includedir libffi) \
    -DFFI_LIBRARY_DIR:PATH="$(pkg-config --variable=libdir libffi)" \
    -DLLVM_BINUTILS_INCDIR=/usr/include \
    -DLIBCXX_ENABLE_ABI_LINKER_SCRIPT=ON \
    -DLIBUNWIND_ENABLE_SHARED=OFF \
    -DLIBCXXABI_USE_LLVM_UNWINDER=ON \
    -DLLVM_DEFAULT_TARGET_TRIPLE="mips64el-redhat-linux" \
    -DCLANG_VENDOR="Loongson"
$ make -j4
$ sudo make install
```

## Test

```
$ make check-clang-driver
$ make check-clang-parser
```

## Usage

```
/opt/loong-llvm/bin/clang hello.loong -S -emit-llvm -o hello.ll
/opt/loong-llvm/bin/opt -S -load /opt/loong-llvm/lib/LoongLLVM.so -other-pass1 hello.ll > hello1.ll
/opt/loong-llvm/bin/opt -S -load /opt/loong-llvm/lib/LoongLLVM.so -other-pass2 hello1.ll > hello2.ll
/opt/loong-llvm/bin/opt -S -load /opt/loong-llvm/lib/LoongLLVM.so -v2c hello2.ll > opt-circuit.svg
```
