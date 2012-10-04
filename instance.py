#!/usr/bin/env python
import os
import time
def collect_info():
        os.system("vmstat 30 >> /tmp/cpu.info &")
        str_tmp=os.popen("ps -el | grep nova-compute","r")
        tmp_list = str_tmp.readlines()
        if(len(tmp_list)):
                os.system("mkdir -p /tmp/instance")
                while(1):
                        str=os.popen("virsh list","r")
                        str_list = str.readlines()
                        i=2
                        while(i<len(str_list)-1):
                                arr=str_list[i].split()
                                if(arr[2]=="running"):
                                        str1=os.popen("ps aux | grep %s | grep -v grep"%(arr[1]))
                                        str1_list = str1.readlines()
                                        arr1=str1_list[0].split()
                                        os.system("top -b -n 1 -p %s | sed -n '8p' >> /tmp/instance/%s"%(arr1[1],arr[1]))
                                i = i + 1
                        time.sleep(30)

def daemonize():
        pid = os.fork()
        if pid != 0:
                os._exit(0)
        collect_info()

daemonize()

