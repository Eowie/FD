
import math
import matplotlib.pyplot as plt
import utm
import simplekml


ver4=[484845,4290518]
ver3=[488710,4290518]
ver2=[488710,4294383]
ver1=[484845,4294383]

lverx=[ver1[0],ver2[0],ver3[0],ver4[0]]
lvery=[ver1[1],ver2[1],ver3[1],ver4[1]]

ss1 = 7680
ss2 = 13824
px  = 12
c   = 120

side1=math.sqrt(((ver1[0])-(ver2[0]))**2+((ver1[1])-(ver2[1]))**2)
side2=math.sqrt(((ver2[0])-(ver3[0]))**2+((ver2[1])-(ver3[1]))**2)
side3=math.sqrt(((ver3[0])-(ver4[0]))**2+((ver3[1])-(ver4[1]))**2)
side4=math.sqrt(((ver4[0])-(ver1[0]))**2+((ver4[1])-(ver1[1]))**2)

if side1>=side2:
    L=side1
    Q=side2
else:
    L=side2
    Q=side1
mf=8000
Zmed=81
pxm=px*10**(-6)
cm=c*10**(-3)
ss1m=ss1*pxm
ss2m=ss2*pxm
mseg=20

h=cm*mf
Z0=Zmed+h
S1 = ss1m*mf
S2 = ss2m*mf

slong=60
slat=30

B = S1*(1-(slong/100))
A = S2*(1-(slat/100))
A1= mseg*S2/100
GSD= pxm*mf


        
#outputs orcamento
nm=(L//B)+1
nf=nm+2
nfx=(Q//A)+1

N=nfx*nf

deltax14= ver1[0]-ver4[0]
deltay14= ver1[1]-ver4[1]
deltax12= ver1[0]-ver2[0]
deltay12= ver1[1]-ver2[1]

if deltay12 == 0 and deltax14==0:
    if side1>=side2:
        deltax1f =0
        deltaxf =0
        deltay1f=A1
        deltayf =A
        deltaxp= B
        deltayp=0
    else:
        deltax1f =A1
        deltaxf =A
        deltay1f=0
        deltayf =0
        deltaxp= 0
        deltayp=B

# if side1<side2:
#     deltax1f =A1*math.cos(math.atan(deltax14/deltay14))
#     deltaxf  =A*math.cos(math.atan(deltax14/deltay14))
#     deltay1f =A1*math.sin(math.atan(deltax14/deltay14))
#     deltayf  =A*math.sin(math.atan(deltax14/deltay14))
#     deltaxp  =B*math.cos(math.atan(deltay12/deltax12))
#     deltayp  =B*math.sin(math.atan(deltay12/deltax12))

# else:
#     deltax1f =A1*math.cos(math.atan(deltax12/deltay12))
#     deltaxf  =A*math.cos(math.atan(deltax12/deltay12))
#     deltay1f =A1*math.sin(math.atan(deltax12/deltay12))
#     deltayf  =A*math.sin(math.atan(deltax12/deltay12))
#     deltaxp  =B*math.cos(math.atan(deltay14/deltax14))
#     deltayp  =B*math.sin(math.atan(deltay14/deltax14))


lp=[]
pa1x =ver1[0]-deltax1f
pa1y =ver1[1]-deltay1f
# pax  =pa1x+deltaxf
# pay  =pa1y+deltayf

p0x=pa1x-deltaxp
p0y=pa1y-deltayp


llat=[]
llon=[]


for i in range(int(nfx)):
    llat.append(p0x)
    llon.append(p0y)
    lp.append((p0x,p0y,float(Zmed)))
    plt.scatter(p0x, p0y, s=10)
    for n in range (int(nf)):
        p0x+=deltaxp
        p0y-=deltayp
        llat.append(p0x)
        llon.append(p0y)
        lp.append((p0x, p0y, float(Zmed)))
        plt.scatter(p0x, p0y, s=10)
    pa1x=pa1x-deltaxf
    pa1y=pa1y-deltayf
    p0x=pa1x-deltaxp
    p0y=pa1y+deltayp


        
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

ble=[]

for i in range(4):
    idk=utm.to_latlon(lverx[i],lvery[i],29,'T')
    print(idk)
    ble.append((idk[1],idk[0]))
   
    
for i in ble:
    blepoint=kml.newpoint(name='Vertice')
    blepoint.coords=[i]
    kml.save('planovoo.kml')


for i in lll:
    npoint=kml.newpoint(name=str(lll.index(i)))
    npoint.coords=[i]
    kml.save('planovoo.kml')
    
