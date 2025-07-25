# Benchmark set-up

Please find here detailed instructions on how to replicate the benchmarks mentioned in my thesis.

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

Always source once the `setup_env.sh` file before attempting to compile and run Kiwaku's benchmarks. It's recommended to source this file in your .bashrc, to always have Kiwaku's environment set-up when needed.

Note that the `EVE_FLAG` environment variable is needed both at compile-time and runtime.

