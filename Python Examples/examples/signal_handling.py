#!/usr/bin/python

import signal, os, time

def alarm_handler(signum, func):
	print "Signal occured"
	return

signal.signal(signal.SIGALRM, alarm_handler)
signal.alarm(5)
time.sleep(10)
signal.alarm(0)
print "Now out of signals."
