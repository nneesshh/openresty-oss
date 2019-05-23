rmdir /s /q "./oss/clibs"
rmdir /s /q "./oss/conf"
rmdir /s /q "./oss/lapis_env"
rmdir /s /q "./oss/memleak"
xcopy /sy .\oss_windows\*.* .\oss\
