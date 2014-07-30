@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set APP_DIR=%HOME%\vim-config

call mklink "%HOME%\.vimrc" "%APP_DIR%\.vim\.vimrc"
call mklink "%HOME%\_vimrc" "%APP_DIR%\.vim\.vimrc"
call mklink /J "%HOME%\.vim" "%APP_DIR%\.vim"
call mklink /J "%HOME%\vimfiles" "%APP_DIR%\.vim"


