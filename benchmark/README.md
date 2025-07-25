# Benchmark set up

Please find here detailed instructions on how to replicate the benchmarks mentioned in my thesis.

## Installation

### Kiwaku build dependencies

* cmake
* ninja

### TBB installation

TBB is sometimes necessary to use the standard execution policies, especially if it doesn't come bundled with your compiler.

If you have a missing dependencies to TBB, [download TBB from Intel's website](https://www.intel.com/content/www/us/en/developer/tools/oneapi/onetbb-download.html?operatingsystem=linux&distribution-linux=offline).

In the manuscript, we used version `oneapi-tbb-2022.2.0`.

### Download EVE

```bash
git clone https://github.com/jfalcou/eve.git eve_tag2023 && \
cd eve_tag2023 && \
git checkout tags/v2023.02.15 && \
cd ..
```

### Download Kiwaku

```bash
git clone https://github.com/jfalcou/kiwaku.git kiwaku_source && \
cd kiwaku_source && \
git checkout contexts_v2 && \
cd ..
```

### Make your own setup_env.sh

Modify the provided `setup_env.sh` file to match your configuration and absolute installation path.

Always source once the `setup_env.sh` file before attempting to compile and run Kiwaku's benchmarks. It's recommended to source this file in your .bashrc, to always have Kiwaku's environment set up when needed.

Note that the `EVE_FLAG` environment variable is needed both at compile-time and runtime.


### Set up your Kiwaku compiler

```bash
# ============ SYCL with NVIDIA ============
export KWK_COMPILER="icpx" && \
export EXTRA_FLAGS="-fsycl -ffp-model=precise -fsycl-targets=nvptx64-nvidia-cuda,x86_64"

# If compilation fails, it may be necessary to change the "x86_64" target into "spir64".
#   This may impact kernel performance, particularly the first one.

# ============== SYCL on CPU ===============
export KWK_COMPILER="icpx" && \
export EXTRA_FLAGS="-fsycl -ffp-model=precise"
# ==========================================

# ============= CLANG =============
export KWK_COMPILER="clang++" && \
export EXTRA_FLAGS=""
# =================================

# ============== GCC ==============
export KWK_COMPILER="g++" && \
export EXTRA_FLAGS=""
# =================================
```


## Set up compilation CMake

```bash
# Generic compilation thanks to environment variables
cmake \
-S ${KWK_SOURCE_DIR} \
-B ${KWK_BUILD_DIR} \
-G Ninja \
-DCMAKE_CXX_FLAGS="-O3 -DNDEBUG -I${EVE_INCLUDE_PATH} ${EXTRA_FLAGS} ${EVE_FLAG} ${TBB_FLAGS}" \
-DCMAKE_CXX_COMPILER="${KWK_COMPILER}"

cd $KWK_BUILD_DIR
```


## Compile and run tests

You may want to ensure Kiwaku's tests successfully compile and run before moving further.

```bash

# Only compile EVE tests
ninja unit.algorithm.algos.context.eve.exe

# Only run EVE tests
ctest -R ^unit.bench.eve.*.exe

# Only compile SYCL tests
ninja unit.algorithm.algos.context.sycl.exe

# Only run SYCL tests
ctest -R ^unit.bench.sycl.*.exe

# Compile all Kiwaku's tests
ninja

# Run all Kiwaku's tests
ctest
```


## Benchmark compilation and execution

On single benchmark at a time:

```bash
# EVE
ninja unit.bench.eve.eve_map_1d.exe     && ./unit/unit.bench.eve.eve_map_1d.exe
ninja unit.bench.eve.eve_reduce_1d.exe  && ./unit/unit.bench.eve.eve_reduce_1d.exe
ninja unit.bench.eve.eve_find_1d.exe    && ./unit/unit.bench.eve.eve_find_1d.exe
ninja unit.bench.eve.eve_numeric_1d.exe && ./unit/unit.bench.eve.eve_numeric_1d.exe

# SYCL
ninja unit.bench.reduce_1d.exe  && ./unit/unit.bench.reduce_1d.exe
ninja unit.bench.find_1d.exe    && ./unit/unit.bench.find_1d.exe
ninja unit.bench.numeric_1d.exe && ./unit/unit.bench.numeric_1d.exe
ninja unit.bench.map_1d.exe     && ./unit/unit.bench.map_1d.exe
```


Compile and run all benchmarks (may take a long time to execute ann the benchmarks!):
```bash
# EVE
ninja unit.bench.eve.exe && ctest -R ^unit.bench.eve.*.exe

# SYCL
ninja unit.bench.exe && ctest -R ^unit.bench.*.exe
```

