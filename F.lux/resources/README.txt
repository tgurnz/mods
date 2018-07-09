Change D:\\Software\\F.lux
in both _install.reg and _uninstall.reg
to where ever you put your program in.

For example:
Go to             C:\Program Files (x86)
Creating folder:  F.lux

(Copy files...)

Edit:             _install.reg
Replace:          D:\\Software\\F.lux
With:             C:\\Program Files (x86)\\F.lux
(do the same for  _uninstall.reg)


run:              _install.reg
run:              C:\\Program Files (x86)\\F.lux\flux.exe

---------------------------------------------------------------------------

run:              notepad2.exe "C:\Windows\System32\drivers\etc\hosts"
add at the end:   

#----------------------------------F.lux
0.0.0.0 forum.stereopsis.com
0.0.0.0 www.stereopsis.com
0.0.0.0 stereopsis.com
0.0.0.0 update.stereopsis.com
0.0.0.0 fluxupdate.stereopsis.com
0.0.0.0 justgetflux.com
0.0.0.0 forum.justgetflux.com
0.0.0.0 update.justgetflux.com
0.0.0.0 www.justgetflux.com

