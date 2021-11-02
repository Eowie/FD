import tkinter as tk
import math
import matplotlib.pyplot as plt

#Desenho GUI
root= tk.Tk()


canvas1 = tk.Canvas(root, width = 1000, height = 700,  relief = 'raised')
canvas1.pack()

label1 = tk.Label(root, text='Informacao para Plano de Voo')
label1.config(font=('helvetica', 14))
canvas1.create_window(500, 30, window=label1)

label2 = tk.Label(root, text='Vertices da Area a Fotografar')
label2.config(font=('helvetica', 12))
canvas1.create_window(150, 60, window=label2)

label7 = tk.Label(root, text='Por favor insira as coordenadas UTM dos vertices da area a fotografar')
label7.config(font=('helvetica', 10))
canvas1.create_window(220, 90, window=label7)

label8 = tk.Label(root, text='E Canto Superior Esquerdo')
label8.config(font=('helvetica', 10))
canvas1.create_window(100, 120, window=label8)
entry1 = tk.Entry(root) 
canvas1.create_window(300, 120, window=entry1)

label9 = tk.Label(root, text='E Canto Superior Direito')
label9.config(font=('helvetica', 10))
canvas1.create_window(100, 150, window=label9)
entry2 = tk.Entry(root) 
canvas1.create_window(300, 150, window=entry2)

label10 = tk.Label(root, text='E Canto Inferior Direito')
label10.config(font=('helvetica', 10))
canvas1.create_window(100, 180, window=label10)
entry3 = tk.Entry(root) 
canvas1.create_window(300, 180, window=entry3)

label11 = tk.Label(root, text='E Canto Inferior Esquerdo')
label11.config(font=('helvetica', 10))
canvas1.create_window(100, 210, window=label11)
entry4 = tk.Entry(root) 
canvas1.create_window(300, 210, window=entry4)


label12 = tk.Label(root, text='N Canto Superior Esquerdo')
label12.config(font=('helvetica', 10))
canvas1.create_window(600, 120, window=label12)
entry9 = tk.Entry(root) 
canvas1.create_window(900, 120, window=entry9)

label13 = tk.Label(root, text='N Canto Superior Direito')
label13.config(font=('helvetica', 10))
canvas1.create_window(600, 150, window=label13)
entry10 = tk.Entry(root) 
canvas1.create_window(900, 150, window=entry10)

label14 = tk.Label(root, text='N Canto Inferior Direito')
label14.config(font=('helvetica', 10))
canvas1.create_window(600, 180, window=label14)
entry11 = tk.Entry(root) 
canvas1.create_window(900, 180, window=entry11)

label15 = tk.Label(root, text='N Canto Inferior Esquerdo')
label15.config(font=('helvetica', 10))
canvas1.create_window(600, 210, window=label15)
entry12 = tk.Entry(root) 
canvas1.create_window(900, 210, window=entry12)


label2 = tk.Label(root, text='Definicoes do Voo')
label2.config(font=('helvetica', 12))
canvas1.create_window(150, 270, window=label2)

label3 = tk.Label(root, text='Escala da Fotografia')
label3.config(font=('helvetica', 10))
canvas1.create_window(100, 300, window=label3)
entry5 = tk.Entry(root) 
canvas1.create_window(300, 300, window=entry5)

label4 = tk.Label(root, text='Camara a Utilizar')
label4.config(font=('helvetica', 10))
canvas1.create_window(600, 300, window=label4)

choices1 = ['Intergraph DMC', 'Intergraph DMC II 140', 'Intergraph DMC II 230', 'Intergraph DMC II 250', 'Microsoft UltraCamD', 'Microsoft UltraCamX', 'Microsoft UltraCamXp', 'Microsoft UltraCamXp WA', 'Leica ADS', 'Outra']
value_inside1 = tk.StringVar(root)
value_inside1.set('Selecione uma Opcao')

question_menu1=tk.OptionMenu(root, value_inside1, *choices1)
question_menu1.pack()
canvas1.create_window(900, 300, window=question_menu1)

label16 = tk.Label(root, text='Se selecionou outra na lista acima, por favor indique os seguintes parametros')
label16.config(font=('helvetica', 10))
canvas1.create_window(750, 330, window=label16)


label17 = tk.Label(root, text='s1')
label17.config(font=('helvetica', 10))
canvas1.create_window(600, 360, window=label17)
entry13 = tk.Entry(root) 
canvas1.create_window(900, 360, window=entry13)

label18 = tk.Label(root, text='s2')
label18.config(font=('helvetica', 10))
canvas1.create_window(600, 390, window=label18)
entry14 = tk.Entry(root) 
canvas1.create_window(900, 390, window=entry14)

label19 = tk.Label(root, text='dimensao do pixel no terreno em micrometro')
label19.config(font=('helvetica', 10))
canvas1.create_window(600, 420, window=label19)
entry15 = tk.Entry(root) 
canvas1.create_window(900, 420, window=entry15)

label20 = tk.Label(root, text='distancia focal em mm')
label20.config(font=('helvetica', 10))
canvas1.create_window(600, 450, window=label20)
entry16 = tk.Entry(root) 
canvas1.create_window(900, 450, window=entry16)



label21 = tk.Label(root, text='sobreposicao longitudinal %')
label21.config(font=('helvetica', 10))
canvas1.create_window(100, 330, window=label21)
entry6 = tk.Entry(root) 
canvas1.create_window(300, 330, window=entry6)

label5 = tk.Label(root, text='sobreposicao lateral %')
label5.config(font=('helvetica', 10))
canvas1.create_window(100, 360, window=label5)
entry7 = tk.Entry(root) 
canvas1.create_window(300, 360, window=entry7)

label26 = tk.Label(root, text='margem seguranca %')
label26.config(font=('helvetica', 10))
canvas1.create_window(100, 390, window=label26)
entry20 = tk.Entry(root) 
canvas1.create_window(300, 390, window=entry20)

label27 = tk.Label(root, text='cota media do terreno')
label27.config(font=('helvetica', 10))
canvas1.create_window(100, 420, window=label27)
entry21 = tk.Entry(root) 
canvas1.create_window(300, 420, window=entry21)

label6 = tk.Label(root, text='Custos de Voo')
label6.config(font=('helvetica', 12))
canvas1.create_window(150, 510, window=label6)


label22 = tk.Label(root, text='Preco Foto')
label22.config(font=('helvetica', 10))
canvas1.create_window(100, 540, window=label22)
entry8 = tk.Entry(root) 
canvas1.create_window(300, 540, window=entry8)

label23 = tk.Label(root, text='Preco por hora de voo')
label23.config(font=('helvetica', 10))
canvas1.create_window(100, 570, window=label23)
entry17 = tk.Entry(root) 
canvas1.create_window(300, 570, window=entry17)

label24 = tk.Label(root, text='Tempo mudanca de faixa(s)')
label24.config(font=('helvetica', 10))
canvas1.create_window(600, 540, window=label24)
entry18 = tk.Entry(root) 
canvas1.create_window(900, 540, window=entry18)

label25 = tk.Label(root, text='Velocidade do aviao (m/s)')
label25.config(font=('helvetica', 10))
canvas1.create_window(600, 570, window=label25)
entry19 = tk.Entry(root) 
canvas1.create_window(900, 570, window=entry19)




coords=[] 
l=[]
defcamera=[]

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
        print("Valores Submetidos com Sucesso")
  

button1 = tk.Button(text='Submeter', command=lambda:submit(l), bg='brown', fg='white', font=('helvetica', 9, 'bold'))
b2 = tk.Button(root, text='Sair', command=root.destroy, bg='brown', fg='white', font=('helvetica', 9, 'bold'))
button1.pack()
b2.pack()
root.mainloop()


for i in l:
    print(i)


#--------------------------
#Definicao de variaveis

ver1 = [float(coords[0]),float(coords[1])]
ver2 = [float(coords[2]),float(coords[3])]
ver3 = [float(coords[4]),float(coords[5])]
ver4 = [float(coords[6]),float(coords[7])]


mf = float(l[0])
slong = float(l[2])
slat = float(l[3])
mseg = float(l[4])

Zmed = float(l[5])

precofoto=float(l[6])
precohvoo=float(l[7])
tf=float(l[8])
v=float(l[9])

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
elif camera=='Leica ADS':
    ss1 = 1
    ss2 = 12000
    px  = 6.5
    c   = 62.5
else:
    print('Nenhuma camera selecionada')

pxm=px*10**(-6)
cm=c*10**(-3)
ss1m=ss1*pxm
ss2m=ss2*pxm


side1=math.sqrt(((ver1[0])-(ver2[0]))**2+((ver1[1])-(ver2[1]))**2)
side2=math.sqrt(((ver2[0])-(ver3[0]))**2+((ver2[1])-(ver3[1]))**2)
side3=math.sqrt(((ver3[0])-(ver4[0]))**2+((ver3[1])-(ver4[1]))**2)
side4=math.sqrt(((ver4[0])-(ver1[0]))**2+((ver4[1])-(ver1[1]))**2)

sidelist=[side1, side2, side3, side4]
sidelist.sort()

L=float(sidelist[3])
Q=float(sidelist[1])


h=cm*mf
Z0=Zmed+h
S1 = ss1m*mf
S2 = ss2m*mf

B = S1*(1-(slong/100))
A = S2*(1-(slat/100))
A1= mseg*S2/100
GSD= pxm*mf


        
#outputs orcamento
nm=(L//B)+1
nf=nm+2
nfx=(Q//A)+1

N=nfx*nf
Custofoto=N*precofoto
T=(B/v)*nfx*(nf-1)+tf*(nfx-1)
Custovoo=precohvoo*T
Custototal=Custofoto+Custovoo


# Output1 - ficheiro txt com calculos

l1 = ["Dados do Utilizador\n", 
      "Coordenadas Vertice 1: "+str(ver1)+"\n", 
      "Coordenadas Vertice 2: "+str(ver2)+"\n",
      "Coordenadas Vertice 3: "+str(ver3)+"\n", 
      "Coordenadas Vertice 4: "+str(ver4)+"\n",
      "Modulo da Escala da Fotografia: "+str(mf)+"\n", 
      "Camara Escolhida: "+str(camera)+"\n", 
      "s1(px): "+str(ss1)+"\n",
      "s2(px): "+str(ss2)+"\n", 
      "c(mm): "+str(c)+"\n", 
      "px(micrometro): "+str(px)+"\n",
      "Sobreposicao Longitudinal(%): "+str(slong)+"\n",
      "Sobreposicao Lateral(%): "+str(slat)+"\n", 
      "Margem de Seguranca(%): "+str(mseg)+"\n",
      "Cota Media: "+str(Zmed)+"\n",
      "Preco Foto: "+str(precofoto)+"\n", 
      "Preco por Hora voo: "+str(precohvoo)+"\n",
      "Tempo Mudanca de Faixa (s): "+str(tf)+"\n",
      "Velocidade do Aviao(m/s): "+str(v)+"\n",     
      "\n",
      "\n",
      "Dados do Calculo\n",
      "L: "+str(L)+"\n", 
      "Q: "+str(Q)+"\n",
      "h: "+str(h)+"\n", 
      "B: "+str(B)+"\n",
      "A: "+str(A)+"\n", 
      "A1(para a primeira fiada): "+str(A1)+"\n",
      "Cota Absoluta: "+str(Z0)+"\n", 
      "Numero de Fotos por Fiada: "+str(nf)+"\n", 
      "Numero de Fiadas: "+str(nfx)+"\n",
      "Numero de Fotos total: "+str(N)+"\n", 
      "Tempo de Voo: "+str(T)+"\n",
      "Custo do Voo: "+str(Custovoo)+"\n",
      "Custo Fotos: "+str(Custofoto)+"\n",
      "Orcamento total"+str(Custototal)+"\n",]


f = open("DadosVoo.txt", "w")
for i in l1:
    f.write(i)
f.close()

#Calculo de Coordenadas de Fotografias

#Definicao do eixo da fiada

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

    
for i in range(nfx):
    lp.append((p0x,p0y,float(Zmed)))
    plt.scatter(p0x, p0y, s=10)
    for n in range (nf-1):
        p0x+=deltaxp
        p0y+=deltayp
        lp.append((p0x, p0y,float(Zmed)))
        plt.scatter(p0x, p0y, s=10)
    pa1x=pa1x+deltaxf
    pa1y=pa1y+deltayf
    p0x=pa1x-deltaxp
    p0y=pa1y-deltayp


# ver1 = [float(coords[0]),float(coords[1])]
# ver2 = [float(coords[2]),float(coords[3])]
# ver3 = [float(coords[4]),float(coords[5])]
# ver4 = [float(coords[6]),float(coords[7])]

# coord=[ver1,ver2,ver3,ver4]
# coord.append(coord[0]) #repeat the first point to create a 'closed loop'

# xs, ys = zip(*coord) #create lists of x and y values

# plt.figure()
# plt.plot(xs,ys) 
# plt.show()
#point1 = [1, 2]
# point2 = [3, 4]

# x_values = [point1[0], point2[0]]
# gather x-values

# y_values = [point1[1], point2[1]]
# gather y-values


# plt.plot(x_values, y_values)        
# plt.show()
# print(lp, end="\n")
# print(lp[0][0])       
     

#output 2 - list of coordinates
f2 = open("CoordenadasVoo.txt", "w")
for i in lp:
    f2.write(str(lp.index(i)))
    f2.write(' '+str(i))
    f2.write('\n')
f2.close()

