#!/usr/bin/env python
import sys, re, gzip

if len(sys.argv) != 4:
    print("Usage: <script> <invcf> <groupname> <outsfs>")

inroot = str(sys.argv[1])
if inroot.endswith(".gz"):
    infile = gzip.open(inroot)
else:
    infile = open(inroot)
k = re.compile("\s+")

for line in infile:
    if line.startswith("##"):
        continue
    else:
        line = line.strip()
        l = k.split(line)
        if line.startswith("#C"):
            lst = [0] * (len(l[9:])*2+1)
        else:
            if l[4] == ".":
                lst[0] += 1
            else:
                n = 0
                for i in range(9, len(l)):
                    n += l[i].split(":")[0].count("1")
                lst[n] += 1
a = (len(lst)+1)/2 - 1
total = sum(lst)
for i in range(1, a+1):
    lst[a-i] += lst[a+i]

lst = lst[1:a+1]

infile.close()
group = str(sys.argv[2])
with open(str(sys.argv[3]), "w") as outfile:
    outfile.write("%s\t%d\t%d\t%d\n" % (group, 2*a, total, a))
    lst = [str(i) for i in lst]
    outfile.write("\t".join(lst))
                
                
