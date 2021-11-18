import tkinter as tk
import math
import asyncio


#GUI PART
root= tk.Tk()


canvas1 = tk.Canvas(root, width = 800, height = 400,  relief = 'raised')
canvas1.pack()

label1 = tk.Label(root, text='Informacao para Plano de Voo')
label1.config(font=('helvetica', 14))
canvas1.create_window(200, 25, window=label1)

label2 = tk.Label(root, text='Vertices da Area a Fotografar')
label2.config(font=('helvetica', 10))
canvas1.create_window(100, 60, window=label2)

entry1 = tk.Entry (root) 
canvas1.create_window(300, 60, window=entry1)
entry2 = tk.Entry (root) 
canvas1.create_window(300, 90, window=entry2)
entry3 = tk.Entry (root) 
canvas1.create_window(300, 120, window=entry3)
entry4 = tk.Entry (root) 
canvas1.create_window(300, 150, window=entry4)

label3 = tk.Label(root, text='Escala')
label3.config(font=('helvetica', 10))
canvas1.create_window(100, 180, window=label3)
entry5 = tk.Entry (root) 
canvas1.create_window(300, 180, window=entry5)

label4 = tk.Label(root, text='Camara a Utilizar')
label4.config(font=('helvetica', 10))
canvas1.create_window(100, 210, window=label4)

choices3 = ['c1', 'c2']
value_inside3 = tk.StringVar(root)
value_inside3.set('Selecione uma Opcao')

question_menu3=tk.OptionMenu(root, value_inside3, *choices3)
question_menu3.pack()
canvas1.create_window(300, 210, window=question_menu3)

label5 = tk.Label(root, text='Objectivo do Voo')
label5.config(font=('helvetica', 10))
canvas1.create_window(100, 240, window=label5)
choices4 = ['Estereorrestituicao', 'Aerotriangulacao', 'Ortofotomapa', 'UAV']
value_inside4 = tk.StringVar(root)
value_inside4.set('Selecione uma Opcao')

question_menu4=tk.OptionMenu(root, value_inside4, *choices4)
question_menu4.pack()
canvas1.create_window(300, 240, window=question_menu4)

label6 = tk.Label(root, text='Custos de Voo')
label6.config(font=('helvetica', 10))
canvas1.create_window(100, 270, window=label6)
entry8 = tk.Entry (root) 
canvas1.create_window(300, 270, window=entry8)

choices1 = ['2 Vertices', '3 Vertices', '4 Vertices']
value_inside1 = tk.StringVar(root)
value_inside1.set('Selecione uma Opcao')

question_menu1=tk.OptionMenu(root, value_inside1, *choices1)
question_menu1.pack()
canvas1.create_window(550, 60, window=question_menu1)

choices2 = ['Fotografia', 'Carta']
value_inside2 = tk.StringVar(root)
value_inside2.set('Selecione uma Opcao')

question_menu2=tk.OptionMenu(root, value_inside2, *choices2)
question_menu2.pack()
canvas1.create_window(550, 180, window=question_menu2)


def submit ():
    
    x1 = entry1.get()
    x2 = entry2.get()
    x3 = entry3.get()
    x4 = entry4.get()
    x5 = entry5.get()
    x8 = entry8.get()
    v1 = value_inside1.get()
    v2 = value_inside2.get()
    v3 = value_inside3.get()
    v4 = value_inside4.get()
  
    
button1 = tk.Button(text='Submit', command=submit, bg='brown', fg='white', font=('helvetica', 9, 'bold'))
canvas1.create_window(400, 350, window=button1)

root.mainloop()

#Variables Calculus
#inputs
ver1 = [484845.00,4290518]
ver2 = [488722.00,4287616.0]

mf = 8000
c= 0.12
ss1= 0.09216
ss2= 0.165888
l = 60
q = 30
px = 12*10**(-6)
v = 1
a = 0.054
dradialmax=0.2
cotamax=81
precofoto=3
tf=2

#outputs plano voo
ver3= [ver1[0],ver2[1]]
ver4= [ver2[0],ver1[1]]
h=c*mf

S1 = ss1*mf
S2 = ss2*mf

B = S1*(1-(l/100))
A = S2*(1-(q/100))
GSD= px*mf

Laux=abs(ver1[0]-ver2[0])
Qaux=abs(ver1[1]-ver2[1])

if (Laux>Qaux):
    L=Laux
    Q=Qaux
else:
    L=Qaux
    Q=Laux
        
#outputs orcamento
nm=(L//B)+1
nf=nm+1
nfx=(Q//A)+1
Am=(S1-B)*S2
Asm=(S1-2*B)*S2
An= A*B
t=B/v
dt=a*mf/v

N=nfx*nf
Custo=N*precofoto
T=(B/v)*nfx*(nf-1)+tf*(nfx-1)


#ortofotos
pontocentral=[(abs(ver1[0]-ver2[0])/2)+ver1[0],(abs(ver1[1]-ver2[1]/2)+ver1[1])]

r=math.sqrt(((ver1[0])-pontocentral[0])**2+(ver1[1]-pontocentral[1])**2)

lq=r*math.sqrt(2)

