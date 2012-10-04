cpuinfo
=======

cpu used info
mem used info
instance used info

使用说明
1.运行python instance.py，在/tmp 下会产生cpu.info文件。
2.如果该节点有nova-compute 则在/tmp 会产生instance 文件夹。
3.终止程序ps -el | grep vmstat
	  ps aux | grep instance.py

