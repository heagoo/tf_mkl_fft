# tf_mkl_fft
This repository provides a patch for tensorflow 1.9, in order to accelerate the Tacotron performance on CPU (https://github.com/keithito/tacotron.git).  
The patch uses Intel(R) MKL and openmp to accelerate the FFT implementation.

To test it, please install MKL at first and then run:
```
sh all.sh
```
