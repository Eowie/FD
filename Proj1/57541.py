# =============================================================================
# # # -*- coding: utf-8 -*-
# # """
# # Created on Thu Nov 4 23:08:23 2021
# 
# # @author: silam
# # """
# =============================================================================

#library imports
import tkinter as tk
import math
import matplotlib.pyplot as plt
import utm
import simplekml
from shapely.geometry import Polygon

kml = simplekml.Kml()

# =============================================================================
# # ===========================================================================
# # #GUI
# # ===========================================================================
# =============================================================================
root= tk.Tk()

label1 = tk.Label(root, text='Informação para Plano de Voo',font=('helvetica', 16))
label1.grid(row=0,column=0,columnspan=4,ipadx=10, ipady=10)

# =============================================================================
# #Coordenadas de Vertices e zona UTM
# =============================================================================
label2 = tk.Label(root, text='Vértices da Área a Fotografar',font=('helvetica', 12))
label2.grid(row=1,column=0,columnspan=4,ipadx=10, ipady=10)

label7 = tk.Label(root, text='Insira as Coordenadas UTM dos Vértices da Área a Fotografar',font=('helvetica', 10))
label7.grid(row=2,column=0,columnspan=4,ipadx=5, ipady=5)

label8 = tk.Label(root, text='E Canto Superior Esquerdo',font=('helvetica', 10))
label8.grid(row=3,column=0,sticky='e')
entry1 = tk.Entry(root) 
entry1.grid(row=3,column=1)

label12 = tk.Label(root, text='N Canto Superior Esquerdo',font=('helvetica', 10))
label12.grid(row=3,column=2,sticky='e')
entry9 = tk.Entry(root) 
entry9.grid(row=3,column=3)

label9 = tk.Label(root, text='E Canto Superior Direito',font=('helvetica', 10))
label9.grid(row=4,column=0,sticky='e')
entry2 = tk.Entry(root) 
entry2.grid(row=4,column=1)

label13 = tk.Label(root, text='N Canto Superior Direito',font=('helvetica', 10))
label13.grid(row=4,column=2,sticky='e')
entry10 = tk.Entry(root) 
entry10.grid(row=4,column=3)

label10 = tk.Label(root, text='E Canto Inferior Direito',font=('helvetica', 10))
label10.grid(row=5,column=0,sticky='e')
entry3 = tk.Entry(root) 
entry3.grid(row=5,column=1)

label14 = tk.Label(root, text='N Canto Inferior Direito',font=('helvetica', 10))
label14.grid(row=5,column=2,sticky='e')
entry11 = tk.Entry(root) 
entry11.grid(row=5,column=3)

label11 = tk.Label(root, text='E Canto Inferior Esquerdo',font=('helvetica', 10))
label11.grid(row=6,column=0,sticky='e')
entry4 = tk.Entry(root) 
entry4.grid(row=6,column=1)

label15 = tk.Label(root, text='N Canto Inferior Esquerdo',font=('helvetica', 10))
label15.grid(row=6,column=2,sticky='e')
entry12 = tk.Entry(root) 
entry12.grid(row=6,column=3)

label28 = tk.Label(root, text='Zona UTM (ex. 29)',font=('helvetica', 8))
label28.grid(row=7,column=0,sticky='e')
entry22 = tk.Entry(root) 
entry22.grid(row=7,column=1)

label29 = tk.Label(root, text='Banda UTM (ex. S)',font=('helvetica', 8))
label29.grid(row=7,column=2,sticky='e')
entry23 = tk.Entry(root) 
entry23.grid(row=7,column=3)

# =============================================================================
# #Definicoes do Voo
# =============================================================================

label2 = tk.Label(root, text='Definições do Voo',font=('helvetica', 12))
label2.grid(row=8,column=0,columnspan=4,ipadx=20, ipady=20)

label3 = tk.Label(root, text='Modulo Escala da Fotografia',font=('helvetica', 10))
label3.grid(row=9,column=0,sticky='e')
entry5 = tk.Entry(root) 
entry5.grid(row=9,column=1)

label4 = tk.Label(root, text='Câmara a Utilizar',font=('helvetica', 10))
label4.grid(row=9,column=2,sticky='e')

choices1 = ['Intergraph DMC', 'Intergraph DMC II 140', 'Intergraph DMC II 230', 'Intergraph DMC II 250', 'Microsoft UltraCamD', 'Microsoft UltraCamX', 'Microsoft UltraCamXp', 'Microsoft UltraCamXp WA', 'Leica ADS40', 'Outra']
value_inside1 = tk.StringVar(root)
value_inside1.set('Selecione uma Opcao')

question_menu1=tk.OptionMenu(root, value_inside1, *choices1)
question_menu1.grid(row=9,column=3)

label16 = tk.Label(root, text='Se Selecionou “Outra” na Lista Acima, Indique os Seguintes Parâmetros',font=('helvetica', 8))
label16.grid(row=10,column=2,columnspan=2,sticky='e')

label17 = tk.Label(root, text='s1 (px)',font=('helvetica', 8))
label17.grid(row=11,column=2,sticky='e')
entry13 = tk.Entry(root) 
entry13.grid(row=11,column=3)

label18 = tk.Label(root, text='s2 (px)',font=('helvetica',8))
label18.grid(row=12,column=2,sticky='e')
entry14 = tk.Entry(root) 
entry14.grid(row=12,column=3)

label19 = tk.Label(root, text='Dimensão do Pixel no Terreno (μm)',font=('helvetica',8))
label19.grid(row=13,column=2,sticky='e')
entry15 = tk.Entry(root) 
entry15.grid(row=13,column=3)

label20 = tk.Label(root, text='Distância Focal (mm)',font=('helvetica', 8))
label20.grid(row=14,column=2,sticky='e')
entry16 = tk.Entry(root) 
entry16.grid(row=14,column=3)

label35 = tk.Label(root, text='LEICA ADS:% de L para Inicio/Fim de Fiada',font=('helvetica', 8))
label35.grid(row=15,column=2,sticky='e')
entry26 = tk.Entry(root) 
entry26.grid(row=15,column=3)

label30 = tk.Label(root, text='Voo para Ortofoto:',font=('helvetica', 10))
label30.grid(row=10,column=0,sticky='e')

label31 = tk.Label(root, text='Variação de Cota Δh (m)',font=('helvetica', 8))
label31.grid(row=11,column=0,sticky='e')
entry24 = tk.Entry(root) 
entry24.grid(row=11,column=1)

label32 = tk.Label(root, text='Distorção Máxima Admissível Δr (mm)',font=('helvetica', 8))
label32.grid(row=12,column=0,sticky='e')
entry25 = tk.Entry(root) 
entry25.grid(row=12,column=1)

label33 = tk.Label(root, text='Voo para Outra Finalidade:',font=('helvetica', 10))
label33.grid(row=13,column=0,sticky='e')

label21 = tk.Label(root, text='Sobreposição Longitudinal (%)',font=('helvetica', 8))
label21.grid(row=14,column=0,sticky='e')
entry6 = tk.Entry(root) 
entry6.grid(row=14,column=1)

label5 = tk.Label(root, text='Sobreposição Lateral (%)',font=('helvetica', 8))
label5.grid(row=15,column=0,sticky='e')
entry7 = tk.Entry(root) 
entry7.grid(row=15,column=1)

label26 = tk.Label(root, text='Margem de Segurança (%)',font=('helvetica', 10))
label26.grid(row=16,column=0,sticky='e')
entry20 = tk.Entry(root) 
entry20.grid(row=16,column=1)

label27 = tk.Label(root, text='Cota Média do Terreno',font=('helvetica', 10))
label27.grid(row=16,column=2,sticky='e')
entry21 = tk.Entry(root) 
entry21.grid(row=16,column=3)

# =============================================================================
# #Custos do Voo
# =============================================================================

label6 = tk.Label(root, text='Custos de Voo',font=('helvetica', 12))
label6.grid(row=18,column=0,columnspan=4,ipadx=20, ipady=20)

label22 = tk.Label(root, text='Preço por Foto',font=('helvetica', 10))
label22.grid(row=19,column=0,sticky='e')
entry8 = tk.Entry(root) 
entry8.grid(row=19,column=1)

label23 = tk.Label(root, text='Preço por Hora de Voo',font=('helvetica', 10))
label23.grid(row=20,column=0,sticky='e')
entry17 = tk.Entry(root) 
entry17.grid(row=20,column=1)

label24 = tk.Label(root, text='Tempo de Mudança de Faixa (s)',font=('helvetica', 10))
label24.grid(row=19,column=2,sticky='e')
entry18 = tk.Entry(root) 
entry18.grid(row=19,column=3)

label25 = tk.Label(root, text='Velocidade do Avião (m/s)',font=('helvetica', 10))
label25.grid(row=20,column=2,sticky='e')
entry19 = tk.Entry(root) 
entry19.grid(row=20,column=3)

label34 = tk.Label(root, text='Nota: Por favor deixar em branco os campos de outra câmara se não for relevante e preencher apenas os dados para ortofoto ou para outra finalidade, colocando zeros no par não relevante',font=('helvetica', 8))
label34.grid(row=21,column=0,columnspan=4,ipadx=20, ipady=20)

# =============================================================================
# #Criacao de listas para guardar os inputs do utilizador
# =============================================================================

coords=[] 
l=[]
defcamera=[]
lutm=[]
orto=[]

# =============================================================================
# #Funcao submit para obter os dados do GUI
# =============================================================================

def submit(l):
    if not l:
        coords.append(entry1.get())
        coords.append(entry9.get())
        coords.append(entry2.get())
        coords.append(entry10.get())
        coords.append(entry3.get())
        coords.append(entry11.get())
        coords.append(entry4.get())
        coords.append(entry12.get())
        l.append(entry5.get())
        l.append(value_inside1.get())
        l.append(entry6.get())
        l.append(entry7.get())
        l.append(entry20.get())
        l.append(entry21.get())
        l.append(entry8.get())
        l.append(entry17.get())
        l.append(entry18.get())
        l.append(entry19.get())
        defcamera.append(entry13.get())
        defcamera.append(entry14.get())
        defcamera.append(entry15.get())
        defcamera.append(entry16.get())
        defcamera.append(entry26.get())
        lutm.append(entry22.get())
        lutm.append(entry23.get())
        orto.append(entry24.get())
        orto.append(entry25.get())
        print("Valores Submetidos com Sucesso")
  

b1 = tk.Button(text='Submeter', command=lambda:submit(l), bg='brown', fg='white', font=('helvetica', 9, 'bold'))
b2 = tk.Button(root, text='Sair', command=root.destroy, bg='brown', fg='white', font=('helvetica', 9, 'bold'))
b1.grid(row=22,column=0,columnspan=4)
b2.grid(row=23,column=0,columnspan=4)

root.mainloop()

# =============================================================================
# #Fim do Codigo do GUI
# =============================================================================

# =============================================================================
# # ===========================================================================
# # #Calculo de variaveis
# # ===========================================================================
# =============================================================================

# =============================================================================
# #definir os quatro vertices da area a fotografar
# =============================================================================
ver1 = [float(coords[0]),float(coords[1])]
ver2 = [float(coords[2]),float(coords[3])]
ver3 = [float(coords[4]),float(coords[5])]
ver4 = [float(coords[6]),float(coords[7])]

# =============================================================================
# #calculo do comprimento dos lados
# =============================================================================
side1=math.sqrt(((ver1[0])-(ver2[0]))**2+((ver1[1])-(ver2[1]))**2)
side2=math.sqrt(((ver2[0])-(ver3[0]))**2+((ver2[1])-(ver3[1]))**2)
side3=math.sqrt(((ver3[0])-(ver4[0]))**2+((ver3[1])-(ver4[1]))**2)
side4=math.sqrt(((ver4[0])-(ver1[0]))**2+((ver4[1])-(ver1[1]))**2)

# =============================================================================
# #definir L e Q
# =============================================================================
if side1>=side2:
    L=side1
    Q=side2
else:
    L=side2
    Q=side1
    
# =============================================================================
# #escala da fotografia
# =============================================================================
mf = float(l[0])

# =============================================================================
# #definir a camara
# =============================================================================
camera=l[1]

if camera=='Outra':
    ss1 =float(defcamera[0])
    ss2 =float(defcamera[1])
    px  =float(defcamera[2])
    c   =float(defcamera[3])
elif camera=='Intergraph DMC':
    ss1 = 7680
    ss2 = 13824
    px  = 12
    c   = 120
elif camera=='Intergraph DMC II 140':
    ss1 = 11200
    ss2 = 12096
    px  = 7.2
    c   = 92
elif camera=='Intergraph DMC II 230':
    ss1 = 14144
    ss2 = 15542
    px  = 5.6
    c   = 92
elif camera=='Intergraph DMC II 250':
    ss1 = 14656
    ss2 = 17216
    px  = 5.6
    c   = 112
elif camera=='Microsoft UltraCamD':
    ss1 = 7500
    ss2 = 11500
    px  = 9
    c   = 100
elif camera=='Microsoft UltraCamX':
    ss1 = 9420
    ss2 = 14430
    px  = 7.2
    c   = 100
elif camera=='Microsoft UltraCamXp':
    ss1 = 11310
    ss2 = 17310
    px  = 6
    c   = 100
elif camera=='Microsoft UltraCamXp WA':
    ss1 = 11310
    ss2 = 17310
    px  = 6
    c   = 70
elif camera=='Leica ADS40':
    ss2 = 12000
    px  = 6.5
    ss1 = L/(px*10**(-6)*mf)
    c   = 62.5
else:
    print('Nenhuma camera selecionada')

# =============================================================================
# #converter variaveis da camera para m
# =============================================================================
pxm=px*10**(-6)
cm=c*10**(-3)
ss1m=ss1*pxm
ss2m=ss2*pxm

# =============================================================================
# #variaveis para ortofotos se necessario
# =============================================================================
deltah=float(orto[0])
deltar=float(orto[1])

# =============================================================================
# #variaveis para sobreposicoes
# =============================================================================
if camera=='Leica ADS40':
    slong=0
else:
    slong = float(l[2])
slat = float(l[3])

# =============================================================================
# #calculo de S1 e S2
# =============================================================================
S1 = ss1m*mf
S2 = ss2m*mf

# =============================================================================
# #Definicao de A e B para Ortofotos ou Outro
# =============================================================================
if deltah !=0:
    r=deltar*10**(-3)/deltah*cm*mf
    lq=r*math.sqrt(2)
    B=lq*mf
    A=B
else:
    B = S1*(1-(slong/100))
    A = S2*(1-(slat/100))
    
# =============================================================================
# #variaveis para outros parametros de voo
# =============================================================================
mseg = float(l[4])
Zmed = float(l[5])
h=cm*mf
Z0=Zmed+h
A1= (50-mseg)*S2/100
GSD= pxm*mf

# =============================================================================
# #Variaveis para custos de voo
# =============================================================================
precofoto=float(l[6])
precohvoo=float(l[7])
tf=float(l[8])
v=float(l[9])

        
# =============================================================================
# #Outputs voo
# =============================================================================
if camera=='Leica ADS40':
    nm=(L//B)
else:
    nm=(L//B)+1

if camera=='Leica ADS40':
    nf=nm
else:
    nf=nm+1
    
nfx=(Q//A)+1

# =============================================================================
# #Outputs orcamento
# =============================================================================
N=nfx*nf+nfx
Custofoto=N*precofoto
if camera=='Leica ADS40':
    T=(B/v)*nfx*(nf)+tf*(nfx-1)
else:
    T=(B/v)*nfx*(nf-1)+tf*(nfx-1)
Custovoo=precohvoo*T
Custototal=Custofoto+Custovoo


# =============================================================================
# =============================================================================
# # # Entrega 1 - ficheiro txt com calculos
# =============================================================================
# =============================================================================

l1 = ["Dados do Utilizador\n", 
      "Coordenadas Vertice 1: "+str(ver1)+"\n", 
      "Coordenadas Vertice 2: "+str(ver2)+"\n",
      "Coordenadas Vertice 3: "+str(ver3)+"\n", 
      "Coordenadas Vertice 4: "+str(ver4)+"\n",
      "Modulo da Escala da Fotografia: "+str(int(mf))+"\n", 
      "Camara Escolhida: "+str(camera)+"\n", 
      "s1(px): "+str(int(ss1))+"\n",
      "s2(px): "+str(int(ss2))+"\n", 
      "c(mm): "+str(round(c,2))+"\n", 
      "px(micrometro): "+str(round(px,2))+"\n",
      "Sobreposicao Longitudinal(%): "+str(round(slong,2))+"\n",
      "Sobreposicao Lateral(%): "+str(round(slat,2))+"\n", 
      "Margem de Seguranca(%): "+str(round(mseg,2))+"\n",
      "Cota Media(m): "+str(round(Zmed,2))+"\n",
      "Preco Foto(€): "+str(round(precofoto,2))+"\n", 
      "Preco por Hora Voo(€): "+str(round(precohvoo,2))+"\n",
      "Tempo Mudanca de Faixa (s): "+str(round(tf,2))+"\n",
      "Velocidade do Aviao(m/s): "+str(round(v,2))+"\n",     
      "\n",
      "\n",
      "Dados do Calculo\n",
      "L(m): "+str(round(L,2))+"\n", 
      "Q(m): "+str(round(Q,2))+"\n",
      "h(m): "+str(round(h,2))+"\n", 
      "B(m): "+str(round(B,2))+"\n",
      "A(m): "+str(round(A,2))+"\n", 
      "A1(para a primeira fiada)(m): "+str(round(A1,2))+"\n",
      "Cota Absoluta(m): "+str(round(Z0,2))+"\n", 
      "Numero de Fotos por Fiada: "+str(int(nf))+"\n", 
      "Numero de Fiadas: "+str(int(nfx))+"\n",
      "Numero de Fotos total(inclui fotos de seguranca): "+str(int(N))+"\n", 
      "Tempo de Voo(s): "+str(round(T,2))+"\n",
      "Tempo de Voo(h): "+str(round(T/3600,2))+"\n",
      "Custo do Voo(€): "+str(round(Custovoo,2))+"\n",
      "Custo Fotos(€): "+str(round(Custofoto,2))+"\n",
      "Orcamento total(€): "+str(round(Custototal,2))+"\n",]

f = open("DadosVoo.txt", "w")
for i in l1:
    f.write(i)
f.close()

# =============================================================================
# # ===========================================================================
# # #Calculo da Orientacao do Voo, Fiadas e de Pontos de fotografia
# # ===========================================================================
# =============================================================================

deltax14= ver1[0]-ver4[0]
deltay14= ver1[1]-ver4[1]
deltax12= ver2[0]-ver1[0]
deltay12= ver2[1]-ver1[1]

ver=[ver1,ver2,ver3,ver4]

fig = plt.figure()
poly = Polygon(ver)
x,y = poly.exterior.xy
ax = fig.add_subplot(111)
ax.plot(x, y, color='#6699cc', alpha=0.7, linewidth=3, solid_capstyle='round', zorder=2)
ax.set_title('Plano Voo')

lp=[]
llat=[]
llon=[]
testla=[]
testlo=[]


if side1<side2:
    deltax1f =(A1/side1)*deltax12
    deltaxf  =(A/side1)*deltax12
    deltay1f =(A1/side1)*deltay12
    deltayf  =(A/side1)*deltay12
    deltaxp  =(B/side4)*deltax14
    deltayp  =(B/side4)*deltay14
    angulo=math.asin(deltax14/side1)
    rumons=0-angulo
    rumosn=rumons+180
    pa1x =ver1[0]+deltax1f
    pa1y =ver1[1]-deltay1f
    if camera=='Leica ADS40':
        auxx=((B*(float(defcamera[4]))/100)/side4)*deltax14
        auxy=((B*(float(defcamera[4]))/100)/side4)*deltay14 
        p0x=pa1x+auxx
        p0y=pa1y+auxy
    else:
        p0x=pa1x+deltaxp
        p0y=pa1y+deltayp
    for i in range(int(nfx)):
        testla.clear()
        testlo.clear()
        llat.append(p0x)
        llon.append(p0y)
        lp.append((p0x,p0y,float(Zmed)))
        plt.scatter(p0x, p0y, color='blue', s=10)
        testla.append(p0x)
        testlo.append(p0y)
        plt.plot(testla,testlo,'r')
        for n in range (int(nf+1)):
            if camera=='Leica ADS40':
                p0x-=(deltaxp+2*auxx)
                p0y-=(deltayp+2*auxy)
            else:
                p0x-=deltaxp
                p0y-=deltayp
            llat.append(p0x)
            llon.append(p0y)
            lp.append((p0x, p0y, float(Zmed)))
            testla.append(p0x)
            testlo.append(p0y)
            plt.scatter(p0x, p0y, color='black',s=10)
            plt.plot(testla,testlo,'r')
        pa1x=pa1x+deltaxf
        pa1y=pa1y+deltayf
        if camera=='Leica ADS40':
            p0x=pa1x-deltaxp*((float(defcamera[4]))/100)
            p0y=pa1y-deltayp*-((float(defcamera[4]))/100)
        else:
            p0x=pa1x+deltaxp
            p0y=pa1y+deltayp
else:
    deltax1f =(A1/side4)*deltax14
    deltaxf  =(A/side4)*deltax14
    deltay1f =(A1/side4)*deltay14   
    deltayf  =(A/side4)*deltay14
    deltaxp  =(B/side1)*deltax12
    deltayp  =(B/side1)*deltay12 
    angulo=math.asin(deltay12/side2)
    rumoeo=90-angulo
    rumooe=rumoeo+180
    pa1x =ver1[0]-deltax1f
    pa1y =ver1[1]-deltay1f
    if camera=='Leica ADS40':
        auxx=((B*(float(defcamera[4]))/100)/side1)*deltax12
        auxy=((B*(float(defcamera[4]))/100)/side1)*deltay12 
        p0x=pa1x-auxx
        p0y=pa1y-auxy
    else:
        p0x=pa1x-deltaxp
        p0y=pa1y-deltayp
    for i in range(int(nfx)):
        testla.clear()
        testlo.clear()
        llat.append(p0x)
        llon.append(p0y)
        lp.append((p0x,p0y,float(Zmed)))
        plt.scatter(p0x, p0y, color='blue', s=10)
        testla.append(p0x)
        testlo.append(p0y)
        plt.plot(testla,testlo,'r')
        for n in range (int(nf)):
            if camera=='Leica ADS40':
                p0x+=(deltaxp+2*auxx)
                p0y+=(deltayp+2*auxy)
            else:
                p0x+=deltaxp
                p0y+=deltayp
            llat.append(p0x)
            llon.append(p0y)
            lp.append((p0x, p0y, float(Zmed)))
            testla.append(p0x)
            testlo.append(p0y)
            plt.scatter(p0x, p0y, color='black',s=10)
            plt.plot(testla,testlo,'r')
        pa1x=pa1x-deltaxf
        pa1y=pa1y-deltayf
        if camera=='Leica ADS40':
            p0x=pa1x+deltaxp*((-float(defcamera[4]))/100)
            p0y=pa1y+deltayp*((-float(defcamera[4]))/100)
        else:
            p0x=pa1x-deltaxp
            p0y=pa1y+deltayp
            
# =============================================================================
# #Assegurar que os rumos estao dentro de 0-360
# =============================================================================
if side1>=side2:
    if rumoeo >360:
        rumoeo=rumoeo-360
    elif rumoeo<0:
        rumoeo=rumoeo+360
    else:
        rumoeo=rumoeo   
    if rumooe >360:
        rumooe=rumooe-360
    elif rumooe<0:
        rumooe=rumooe+360
    else:
        rumooe=rumooe
        
else:  
    if rumons >360:
        rumons=rumons-360
    elif rumons<0:
        rumons=rumons+360
    else:
        rumons=rumons
    if rumosn >360:
        rumosn=rumosn-360
    elif rumosn<0:
        rumosn=rumosn+360
    else:
        rumosn=rumosn     

    
# =============================================================================
# # ===========================================================================
# # #Entrega 3 - Grafico com os pontos de tomada de fotos, fiadas e 'area a fotografar    
# # ===========================================================================
# =============================================================================

plt.savefig('graficoplanovoo.png', dpi=300, bbox_inches='tight')

# =============================================================================
# # ===========================================================================
# # #Entrega 2 - Ficheiro com coordenadas de pontos de tomada de foto      
# # ===========================================================================
# =============================================================================

f2 = open("CoordenadasVoo.txt", "w")

for i in lp:
    f2.write(str(round(lp.index(i),2)))
    f2.write(' '+str(i))
    f2.write('\n')
f2.close()

# =============================================================================
# # ===========================================================================
# # #Entrega 4 - Ficheiro KML
# # ===========================================================================
# =============================================================================

# =============================================================================
# #conversao para coords lat lon para representacao no GE
# =============================================================================
lll=[]
llll=[]
for i in lp:
    x=utm.to_latlon(llat[lp.index(i)],llon[lp.index(i)],29,'S')
    lll.append((x[1],x[0],Z0))
    llll.append((x[1],x[0]))

ble=[]
lverx=[ver1[0],ver2[0],ver3[0],ver4[0]]
lvery=[ver1[1],ver2[1],ver3[1],ver4[1]]

for i in range(4):
    idk=utm.to_latlon(lverx[i],lvery[i],int(lutm[0]),str(lutm[1]))
    print(idk)
    ble.append((idk[1],idk[0]))
   
# =============================================================================
# #pontos Vertice no GE
# =============================================================================

for i in ble:
    blepoint=kml.newpoint(name='Vertice'+str(ble.index(i)))
    blepoint.coords=[i]
    kml.save('planovoo.kml')

# =============================================================================
# #Pontos foto no GE
# =============================================================================

for i in lll:
    npoint=kml.newpoint(name=str(lll.index(i)))
    npoint.coords=[i]
    npoint.style.iconstyle.icon.href = 'http://maps.google.com/mapfiles/kml/shapes/placemark_circle.png'
    npoint.altitudemode='absolute'
    npoint.extrude=1
    kml.save('planovoo.kml')
    
# =============================================================================
# #Area fotografia no GE
# =============================================================================

poly=kml.newpolygon(name='Area Fotografia',
                            outerboundaryis=[ble[0],ble[1],ble[2],ble[3],ble[0]])
poly.style.polystyle.color='33FFFF00'
poly.style.polystyle.outline=1
kml.save('planovoo.kml')
    

length_to_split = int(len(llll)/nfx)

newlist=[]
# =============================================================================
# # Altura em Pes
# =============================================================================
Z0f1=Z0*3.281
Z0f=round(Z0f1)

# =============================================================================
# #Fiadas no GE
# =============================================================================
for i in range(int(nfx)):
    newlist.clear()
    newlist.extend(llll[:length_to_split])
    del llll[:(length_to_split)]
    if side1>=side2:
        lines=kml.newlinestring(name='F'+str(i)+', RumoE-O:'+str(round(rumoeo))+', RumoO-E:'+str(round(rumooe))+', H:'+str(Z0f),coords=newlist)
    else:
        lines=kml.newlinestring(name='F'+str(i)+', RumoN-S:'+str(round(rumons))+', RumoS-N:'+str(round(rumosn))+', H:'+str(Z0f),coords=newlist)
    lines.style.linestyle.color= simplekml.Color.red
    lines.style.linestyle.width=3
    kml.save('planovoo.kml')
    
# =============================================================================
# # ===========================================================================
# # #Fim do Programa
# # ===========================================================================
# =============================================================================
