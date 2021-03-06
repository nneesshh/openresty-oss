# Build openresty-win32 with vs2017

## Features
- IOCP is supported in events, by "use iocp;" option
- SSL is supported

- Other tips:
    - Write to console(such as via "printf") after "FreeConsole()" will make iocp crash, maybe some overflow happens.
    - WSARecv memory recycle in ngx_overlapped_wsarecv: ngx_get_connection() --> WSARecv lock memory --> ngx_getqueuedcompletionstatusex free memory --> ngx_get_connection() again ...
    - MUST NOT import "jquery.form.min.js" before "jquery.min.js", because it will raise "Uncaught TypeError: $(...).ajaxSubmit is not a function" error.
    - JQuery form doesn't submit button value, we must do it "MANUALLY".
    - Don't reimport "jquery.form.min.js" in ajax pages, because reimport it would clear "$.AdminLTE" and make "$.AdminLTE.options" undefined.
    - Remove code like "<script src="/scripts/script.js"></script>" from ajax page, because it will raise "Synchronous XMLHttpRequest on the main thread is deprecated" warning.
    - "package.path = package.path .. xxxx" MUST BE in "init_site.lua" because every coroutine will create a new state thread and it will be memory overflow if it is in "web_main.lua".
    - official "lua51" won't work because "attempt to yield across metamethod/C-call boundary" error.
    - ...

- Missing modules:
    - ngx_service
    - ngx_postgres
    - ngx_google_perftools_module
    - ngx_stream_geoip_module
    - ngx_http_geoip_module
    - ngx_http_degradation_module
    - ngx_http_probe(dtrace)
    - ...



## Thirdparty Dependancy

+ jemalloc: https://github.com/jemalloc/jemalloc
+ libtiff: https://github.com/rouault/libtiff
+ libgd.lib: https://windows.php.net/downloads/php-sdk/deps/vc15/x86/
+ pgsql(libpg, openssl): https://www.enterprisedb.com/download-postgresql-binaries
+ perl: http://strawberryperl.com/releases.html
+ pcre: https://ftp.pcre.org/pub/pcre/
+ more not listed ...