#!/usr/bin/python 

import sqlite3
print sqlite3.__file__

conn = sqlite3.connect("/usr/local/McAfee/fmp/var/FMP.db")
c = conn.cursor()
c.execute("select * from reports")
print c.rowcount
rows = c.fetchall()
print len(rows)
for row in rows :
    print row
