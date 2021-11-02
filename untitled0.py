# -*- coding: utf-8 -*-
"""
Created on Sun Oct 31 15:41:57 2021

@author: Eow
"""
import math
import matplotlib.pyplot as plt
import utm
import simplekml


ver1=[484845,4290518]
ver2=[488710,4290502]
ver3=[484775,4287816]
ver4=[488722,4287616]
A1=398
A=929
nf=15
nfx=4
B=295
h=1041

side1=math.sqrt(((ver1[0])-(ver2[0]))**2+((ver1[1])-(ver2[1]))**2)
side2=math.sqrt(((ver2[0])-(ver3[0]))**2+((ver2[1])-(ver3[1]))**2)
side3=math.sqrt(((ver3[0])-(ver4[0]))**2+((ver3[1])-(ver4[1]))**2)
side4=math.sqrt(((ver4[0])-(ver1[0]))**2+((ver4[1])-(ver1[1]))**2)

deltax14= ver1[0]-ver4[0]
deltay14= ver1[1]-ver4[1]
deltax12= ver1[0]-ver2[0]
deltay12= ver1[1]-ver2[1]



if side1<side2:
    deltax1f =A1*math.cos(math.atan(deltax14/deltay14))
    deltaxf  =A*math.cos(math.atan(deltax14/deltay14))
    deltay1f =A1*math.sin(math.atan(deltax14/deltay14))
    deltayf  =A*math.sin(math.atan(deltax14/deltay14))
    deltaxp  =B*math.cos(math.atan(deltay12/deltax12))
    deltayp  =B*math.sin(math.atan(deltay12/deltax12))
else:
    deltax1f =A1*math.cos(math.atan(deltax12/deltay12))
    deltaxf  =A*math.cos(math.atan(deltax12/deltay12))
    deltay1f =A1*math.sin(math.atan(deltax12/deltay12))
    deltayf  =A*math.sin(math.atan(deltax12/deltay12))
    deltaxp  =B*math.cos(math.atan(deltay14/deltax14))
    deltayp  =B*math.sin(math.atan(deltay14/deltax14))


lp=[]
pa1x =ver1[0]+deltax1f
pa1y =ver1[1]+deltay1f
# pax  =pa1x+deltaxf
# pay  =pa1y+deltayf

p0x=pa1x-deltaxp
p0y=pa1y-deltayp


llat=[]
llon=[]
Zmed=81

for i in range(nfx):
    llat.append(p0x)
    llon.append(p0y)
    lp.append((p0x,p0y,float(Zmed)))
    plt.scatter(p0x, p0y, s=10)
    for n in range (nf):
        p0x+=deltaxp
        p0y+=deltayp
        llat.append(p0x)
        llon.append(p0y)
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

lll=[]
for i in lp:
    x=utm.to_latlon(llat[lp.index(i)],llon[lp.index(i)],29,'T')
    lll.append((x[1],x[0]))

print(lll)

kml = simplekml.Kml()

for i in lll:
    npoint=kml.newpoint(name=str(lll.index(i)))
    npoint.coords=[i]
    kml.save('planovoo.kml')
    
