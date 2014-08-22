#!/usr/bin/env python
#
#
#################

import time,random
import string

def Nrandom(N):
	L = string.digits + string.letters
	n = 0
	s = ''
	while n < N:
		s = s + random.choice(L)
		n += 1
	return s		
s = Nrandom(20)
print s