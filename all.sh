# Get code and build to prepare files
git clone https://github.com/tensorflow/tensorflow.git -b r1.9
cd tensorflow && ./configure && bazel build --config=mkl --copt="-DEIGEN_USE_VML" -c opt //tensorflow/tools/pip_package:build_pip_package

# Patch
unalias cp
cd ..
cp fft_ops.cc tensorflow/tensorflow/core/kernels/fft_ops.cc
cp TensorFFT.h tensorflow/bazel-tensorflow/bazel-out/k8-opt/bin/tensorflow/tools/pip_package/build_pip_package.runfiles/eigen_archive/unsupported/Eigen/CXX11/src/Tensor/TensorFFT.h
cp kernels.BUILD tensorflow/tensorflow/core/kernels/BUILD

# Rebuild
source /opt/intel/mkl/bin/mklvars.sh intel64
cd tensorflow && bazel build --copt=-mavx2 --copt=-mfma --copt=-mavx --copt=-msse4.2 --copt=-msse4.1 --copt=-msse3 --copt=-fopenmp --copt="-DEIGEN_USE_VML" --linkopt=-L/opt/intel/compilers_and_libraries_2018.3.222/linux/compiler/lib/intel64_lin --linkopt=-liomp5 -c opt //tensorflow/tools/pip_package:build_pip_package
mkdir build
bazel-bin/tensorflow/tools/pip_package/build_pip_package ./build
#pip install --upgrade ./build/*.whl

