#!/usr/bin/python

#arguments are : input file, output file, number of columns

import sys
import os
import re

fIn=open(sys.argv[1],'r')
fOutL=open(sys.argv[2],'w')

while True:
	line=fIn.readline()
	if line[0:6]=="Inv(A)":
		break
fIn.readline()

for line in fIn:
		
	splitted=str.split(line)
	lineOut=""
	for i in splitted:
		lineOut=lineOut+i+","
	lineOut=lineOut[:-1]
	lineOut=lineOut+"\n"
	if len(lineOut)>3:
		fOutL.write(lineOut)

