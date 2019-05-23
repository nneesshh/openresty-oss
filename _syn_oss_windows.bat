rmdir /s /q "./oss/clibs"
rmdir /s /q "./oss/conf"
rmdir /s /q "./oss/lapis_env"
rmdir /s /q "./oss/memleak"
del ./oss/*.bat
del ./oss/*.lib
del ./oss/*.dll
del ./oss/*.manifest
del ./oss/*.chm
del ./oss/*.exe
del ./oss/*.exp
xcopy /sy .\oss_windows\*.* .\oss\
