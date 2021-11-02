# -*- coding: utf-8 -*-
"""
Created on Sun Oct 31 15:41:57 2021

@author: Eow
"""
import math
import matplotlib.pyplot as plt

ver1=[0,50]
ver2=[150,50]
ver4=[0,0]
A1=10
A=15
nf=3
nfx=4
B=30




deltax14= ver1[0]-ver4[0]
deltay14= ver1[1]-ver4[1]
deltax12= ver1[0]-ver2[0]
deltay12= ver1[1]-ver2[1]

deltax1f =-A1*math.sin(math.atan(deltax14/deltay14))
deltaxf  =-A*math.sin(math.atan(deltax14/deltay14))
deltay1f =-A1*math.cos(math.atan(deltax14/deltay14))
deltayf  =-A*math.cos(math.atan(deltax14/deltay14))
deltaxp  =B*math.cos(math.atan(deltay12/deltax12))
deltayp  =B*math.sin(math.atan(deltay12/deltax12))

lp=[]
pa1x =ver1[0]+deltax1f
pa1y =ver1[1]+deltay1f
# pax  =pa1x+deltaxf
# pay  =pa1y+deltayf

p0x=pa1x-deltaxp
p0y=pa1y-deltayp

Zmed=81

for i in range(nfx):
    lp.append((p0x,p0y,float(Zmed)))
    plt.scatter(p0x, p0y, s=10)
    for n in range (nf):
        p0x+=deltaxp
        p0y+=deltayp
        lp.append((p0x, p0y, float(Zmed)))
        plt.scatter(p0x, p0y, s=10)
    pa1x=pa1x+deltaxf
    pa1y=pa1y+deltayf
    p0x=pa1x-deltaxp
    p0y=pa1y-deltayp


        
plt.show()
print(lp, end="\n")
print(lp[0][0])       

f2 = open("CoordenadasVoo.txt", "w")
for i in lp:
    f2.write(str(lp.index(i)))
    f2.write(' '+str(i))
    f2.write('\n')
f2.close()