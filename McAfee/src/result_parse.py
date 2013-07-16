#!/usr/bin/env python
import pprint
import sys
import os
import re
def computeIOStatAverage(file) :
    iostatRegex = '(\d+\.?\d+)\s+(\d+\.?\d+)\s+(\d+\.?\d+)\s+(\d+\.?\d+)\s+(\d+\.?\d+)\s+(\d+\.?\d+)\s+\d+\.?\d+\s+\d+\.?\d+\s+(\d+\.?\d+)'
    iostat_keys = ['KBpt', 'tps', 'MBps', 'user', 'sys', 'idle', 'load']
    sum = dict()
    cntr = 0
    for key in iostat_keys :
        sum[key] = 0
    fh = open(file)
    for line in fh :
        m = re.search(iostatRegex, line)
        if m is not None :
            cntr = cntr + 1
            i = 1
            for key in iostat_keys:
                sum[key] = sum[key] + float(m.group(i))
                i = i + 1
    fh.close()
    print str(cntr) + 'for IOSTat'
    for key in iostat_keys :
        sum[key] = sum[key] / cntr
    return sum

def computeVMStatAverage(file) :
    vmstat_keys = ['Pages free', 'Pages active', 'Pages inactive',
            'Pages speculative', 'Pages wired down', 'Translation faults',
            'Pages copy-on-write', 'Pages zero filled', 'Pages reactivated',
            'Pageins', 'Pageouts']
    cntr = 0
    sum = dict()
    for key in vmstat_keys :
        sum[key] = {'sum':0, 'cntr':0}
    fh = open(file)
    for line in fh :
        for key in vmstat_keys :
            rx = key + '"?:\s+(\d+)'
            m = re.search(rx, line)
            if m is not None :
                sum[key]['sum'] = sum[key]['sum'] + int(m.group(1))
                sum[key]['cntr'] = sum[key]['cntr']+1
                break
    fh.close()
    avg = dict()
    for key in vmstat_keys :
        print str(sum[key]['cntr']) + ' for VMStat'
        avg[key] = sum[key]['sum']/sum[key]['cntr']
    return avg

def computeProcessStats(f, processes) :
    """
PID  COMMAND          %CPU TIME     #TH  #WQ #PORTS #MREGS RPRVT  RSHRD  RSIZE  VPRVT VSIZE  PGRP PPID STATE    UID FAULTS  COW   MSGSENT MSGRECV SYSBSD SYSMACH CSW     PAGEINS USER
        93-    cma              0.0  80:56.20 20   0   74+    242+   5584K+ 7436K+ 18M+   41M+   625M+  93    1     sleeping 0   854817+    115+     88921+      1221+       19132737+  389418256+  158882344+ 1028+    root
"""
     
    cntr = 0
    p_data = {}
    for p in processes :
        p_data[p] = {'cpu':0, 'rprvt':0, 'rshrd':0, 'rsize':0, 'vprvt':0, 'vsize':0, 'cntr':0}
        
    fh = open(f)
    for line in fh :
        for process in processes :
            if re.search(process, line) is not None :
                elems = new_line = re.sub('\s+',' ', line).split(' ')
                if process == 'Endpoint' :
                    elems.remove('Endpoint')
                for i in range(8, 13) :
                    m = re.search('(.*)(M|K)\+?', elems[i])
                    if m is not None :
                        elems[i] = int(m.group(1))
                        elems[i] = elems[i] * 1024
                        if m.group(2) == 'M' :
                            elems[i] = elems[i] * 1024
                    else :
                        if re.search('\+$', elems[i]) is not None:
                            elems[i] = elems[i].rstrip('+')
                        elems[i] = int(elems[i])
                p_data[process]['cpu'] = p_data[process]['cpu'] + float(elems[2])
                p_data[process]['rprvt'] = p_data[process]['rprvt'] + elems[8]
                p_data[process]['rshrd'] = p_data[process]['rshrd'] + elems[9]
                p_data[process]['rsize'] = p_data[process]['rsize'] + elems[10]
                p_data[process]['vprvt'] = p_data[process]['vprvt'] + elems[11]
                p_data[process]['vsize'] = p_data[process]['vsize'] + elems[12]
                cntr = cntr + 1
                break
    fh.close()
    if cntr == 0:
        return None
    for key in p_data.keys() :
        for key1 in  p_data[key].keys() :
            p_data[key][key1] = p_data[key][key1]/cntr/1024
    return p_data



log_dir = sys.argv[1]
if not os.path.isdir(log_dir) :
    print "%s is not a dir." % log_dir
    sys.exit(1)
pprint.pprint(computeIOStatAverage(log_dir + '/iostat.log'))
pprint.pprint( computeVMStatAverage(log_dir + '/vmstat.log'))
pprint.pprint( computeProcessStats(log_dir + '/mem_cpu_usage.log', ['cma','EpeMacHost','Endpoint']))
