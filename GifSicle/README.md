<h1><img src="resources/icon.png"/> GifSicle</h1>

a modified Windows-build from https://eternallybored.org/misc/gifsicle/ 
which source is https://github.com/kohler/gifsicle/releases/tag/v1.89
(or https://eternallybored.org/misc/gifsicle/src/gifsicle-1.89.tar.gz).

manifest, VERINFO, icon.

<hr/>

for how to use imagemagick with gifsicle to optimize a GIF, <br/>
see <code>optimize_gif.cmd</code>, <br/>
it is basically:

```cmd
::------------------------------------------------------------to "ImageMagick Machine independent File Format bitmap". use '^' before '%'.
call magick.exe "convert" input.gif -fuzz 3^% -deconstruct output.miff
::------------------------------------------------------------optimize 1
call magick.exe "convert" output.miff "-coalesce" "+dither" -layers Optimize -colors 64 output_optimized1.gif
::------------------------------------------------------------optimize 2
call gifsicle.exe --verbose --optimize=2 output_optimized1.gif --output output_optimized2.gif
```