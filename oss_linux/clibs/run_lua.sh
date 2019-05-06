export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:../lib/linux/release
ulimit -HSn 100000
ulimit -c unlimited
./lua
