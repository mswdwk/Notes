[VSCode增加mysys2终端](https://blog.csdn.net/liang_clg/article/details/121097676)
1) execute 'ctrl + ,' ,input 'shell windows'
2) chose 'edit settings.json'
3) modify 'settings.json', add fellowing content. 
	attention: replace 'msys2_shell' to your own path.

```
 "msys2-mingw64":{
            "path":"cmd.exe",
            "args": ["/c","D:\\msys64\\msys2_shell.cmd -defterm -mingw64 -no-start -here"]
        }
```
