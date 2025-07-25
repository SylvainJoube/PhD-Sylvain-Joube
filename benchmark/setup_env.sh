#!/bin/bash

# The common absolute path used to install Kiwaku, EVE and TBB
export COMMON_PATH="TODO"

# Choose your default vectorization compiler flags
export EVE_FLAG="TODO"

# Valid examples, depending on you CPU's SIMD support:
# export EVE_FLAG=""
# export EVE_FLAG="-msse4.2"
# export EVE_FLAG="-mavx2 -mfma"
# export EVE_FLAG="-march=skylake-avx512"


# Change this line to point to your TBB installation if it's not included in your compiler
export TBB_FULL_PATH="TODO"
# Exemple:
# export TBB_FULL_PATH="${COMMON_PATH}/TBB/oneapi-tbb-2022.2.0"




# These paths should stay the same, no matter your (recent) TBB version
export LD_LIBRARY_PATH=${TBB_FULL_PATH}/lib/intel64/gcc4.8:$LD_LIBRARY_PATH
export TBB_FLAGS="-L${TBB_FULL_PATH}/lib/intel64/gcc4.8 -I${TBB_FULL_PATH}/include -ltbb"


export KWK_BUILD_DIR="${COMMON_PATH}/kiwaku_build"
export KWK_SOURCE_DIR="${COMMON_PATH}/kiwaku_source"
export EVE_INCLUDE_PATH="${COMMON_PATH}/eve_tag2023/include"

echo ""
echo "========== Kiwaku's benchmark environment variables set-up =========="
echo "  EVE_INCLUDE_PATH = $EVE_INCLUDE_PATH"
echo "  KWK_SOURCE_DIR   = $KWK_SOURCE_DIR"
echo "   KWK_BUILD_DIR   = $KWK_BUILD_DIR"
echo "        EVE_FLAG   = $EVE_FLAG"
echo "       TBB_FLAGS   = $TBB_FLAGS"
echo ""
