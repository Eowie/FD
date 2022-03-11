# -*- coding: utf-8 -*-
"""
Created on Wed Nov 18 16:55:01 2020

@author: Miguel
"""
import numpy as np
import math

#Orientação externa da foto 7
X07=-89791
Y07=-101096
Z07= 1095.365
w7=0
fi7=0
k7=15.7612*math.pi/180


#Coodenadas terreno dos PFs
X1=	-90158.653
Y1=-100565.532
Z1= 93.799

X2=-89794.832
Y2=-100478.941
Z2=89.069

X3= -89788.239
Y3= -101679.518
Z3= 81.974

X4=-89514.366
Y4=-101489.343
Z4=123.038

X5=-90019.770
Y5=-101048.356
Z5= 93.223

X6=-89696.832
Y6=-101008.761
Z6=95.277

#Coordenadas foto dos PFs em 6 (foto sem orientação externa)
x1_6=-1.026
y1_6=68.67

x2_6=44.310
y2_6=65.634

x3_6=2.526
y3_6=-70.734

x4_6=41.166
y4_6=-61.722

x5_6=-1.962
y5_6=7.386

x6_6=36.534
y6_6=0.642

#Coordenadas foto dos pontos novos
xA_6=38.898
yA_6=-34.266

xA_7=4.866
yA_7=-38.166

xB_6=34.268
yB_6=-47.658

xB_7=0.606
yB_7=-51.966

xC_6=41.986
yC_6=-50.164

xC_7=8.490
yC_7=-54.402

#Orientação interna da câmara
c=0.12
x0=0
y0=0


#1- OE da foto 6 sabendo coordenadas foto dos PF's e a OI da câmara

#Valores iniciais estimados para a orientação externa da foto 6
X06=-89971
Y06=-101096

Z06=1095.365
w6=0.1208*math.pi/180
fi6=0.2895*math.pi/180
k6=15.7612*math.pi/180
s=0
k=0

#Cálculo dos parâmetros da orientação externa da foto 6 pelo ajustamento por mínimos quadrados
while (k!=3):
    
    #Matriz de rotação
    r11=(math.cos(fi6))*(math.cos(k6))
    r12=-(math.cos(fi6))*(math.sin(k6))
    r13=math.sin(fi6)
    r21=(math.cos(w6))*(math.sin(k6))+(math.sin(w6))*(math.sin(fi6))*(math.cos(k6))
    r22=(math.cos(w6))*(math.cos(k6))-(math.sin(w6))*(math.sin(fi6))*(math.sin(k6))
    r23=-(math.sin(w6))*(math.cos(fi6))
    r31=(math.sin(w6))*(math.sin(k6))-(math.cos(w6))*(math.sin(fi6))*(math.cos(k6))
    r32=(math.sin(w6))*(math.cos(k6))+(math.cos(w6))*(math.sin(fi6))*(math.sin(k6))
    r33=(math.cos(w6))*(math.cos(fi6))
    
    #Nx,Ny e D para cada ponto
    Nx_1=r11*(X1-X06)+r21*(Y1-Y06)+r31*(Z1-Z06)
    Ny_1=r12*(X1-X06)+r22*(Y1-Y06)+r32*(Z1-Z06)
    D_1=r13*(X1-X06)+r23*(Y1-Y06)+r33*(Z1-Z06)
    
    Nx_2=r11*(X2-X06)+r21*(Y2-Y06)+r31*(Z2-Z06)
    Ny_2=r12*(X2-X06)+r22*(Y2-Y06)+r32*(Z2-Z06)
    D_2=r13*(X2-X06)+r23*(Y2-Y06)+r33*(Z2-Z06)
    
    Nx_3=r11*(X3-X06)+r21*(Y3-Y06)+r31*(Z3-Z06)
    Ny_3=r12*(X3-X06)+r22*(Y3-Y06)+r32*(Z3-Z06)
    D_3=r13*(X3-X06)+r23*(Y3-Y06)+r33*(Z3-Z06)
    
    Nx_4=r11*(X4-X06)+r21*(Y4-Y06)+r31*(Z4-Z06)
    Ny_4=r12*(X4-X06)+r22*(Y4-Y06)+r32*(Z4-Z06)
    D_4=r13*(X4-X06)+r23*(Y4-Y06)+r33*(Z4-Z06)
    
    Nx_5=r11*(X5-X06)+r21*(Y5-Y06)+r31*(Z5-Z06)
    Ny_5=r12*(X5-X06)+r22*(Y5-Y06)+r32*(Z5-Z06)
    D_5=r13*(X5-X06)+r23*(Y5-Y06)+r33*(Z5-Z06)
    
    
    #Derivadas parciais para cada ponto
    #1
    dx_dw_1=-(c/D_1)*((Y1-Y06)*r33-(Z1-Z06)*r23*(Nx_1/D_1)-(Y1-Y06)*r31+(Z1-Z06)*r21)
    dx_dfi_1=-(c/D_1)*((Nx_1*math.cos(k6)-Ny_1*math.sin(k6))*(Nx_1/D_1)+D_1*math.cos(k6))
    dx_dk_1=-(c/D_1)*Ny_1
    dx_dXo_1=-(c/(D_1**2))*(r13*Nx_1 - r11*D_1)
    dx_dYo_1=-(c/(D_1**2))*(r23*Nx_1 - r21*D_1)
    dx_dZo_1=-(c/(D_1**2))*(r33*Nx_1 - r31*D_1)
    dy_dw_1=-(c/D_1)*((Y1-Y06)*r33-(Z1-Z06)*r23*(Ny_1/D_1)-(Y1-Y06)*r32+(Z1-Z06)*r22)
    dy_dfi_1=(c/D_1)*((Nx_1*math.cos(k6)-Ny_1*math.sin(k6))*(Ny_1/D_1)-D_1*math.sin(k6))
    dy_dk_1=(c/D_1)*Nx_1
    dy_dXo_1=-(c/(D_1**2))*(r13*Ny_1 - r12*D_1)
    dy_dYo_1=-(c/(D_1**2))*(r23*Ny_1 - r22*D_1)
    dy_dZo_1=-(c/(D_1**2))*(r33*Ny_1 - r32*D_1)
    
    #2
    dx_dw_2=-(c/D_2)*((Y2-Y06)*r33-(Z2-Z06)*r23*(Nx_2/D_2)-(Y2-Y06)*r31+(Z2-Z06)*r21)
    dx_dfi_2=-(c/D_2)*((Nx_2*math.cos(k6)-Ny_2*math.sin(k6))*(Nx_2/D_2)+D_2*math.cos(k6))
    dx_dk_2=-(c/D_2)*Ny_2
    dx_dXo_2=-(c/(D_2**2))*(r13*Nx_2 - r11*D_2)
    dx_dYo_2=-(c/(D_2**2))*(r23*Nx_2 - r21*D_2)
    dx_dZo_2=-(c/(D_2**2))*(r33*Nx_2 - r31*D_2)
    dy_dw_2=-(c/D_2)*((Y2-Y06)*r33-(Z2-Z06)*r23*(Ny_2/D_2)-(Y2-Y06)*r32+(Z2-Z06)*r22)
    dy_dfi_2=(c/D_2)*((Nx_2*math.cos(k6)-Ny_2*math.sin(k6))*(Ny_2/D_2)-D_2*math.sin(k6))
    dy_dk_2=(c/D_2)*Nx_2
    dy_dXo_2=-(c/(D_2**2))*(r13*Ny_2 - r12*D_2)
    dy_dYo_2=-(c/(D_2**2))*(r23*Ny_2 - r22*D_2)
    dy_dZo_2=-(c/(D_2**2))*(r33*Ny_2 - r32*D_2)
    
    #3
    dx_dw_3=-(c/D_3)*((Y3-Y06)*r33-(Z3-Z06)*r23*(Nx_3/D_3)-(Y3-Y06)*r31+(Z3-Z06)*r21)
    dx_dfi_3=-(c/D_3)*((Nx_3*(math.cos(k6))-Ny_3*(math.sin(k6)))*(Nx_3/D_3)+D_3*math.cos(k6))
    dx_dk_3=-(c/D_3)*Ny_3
    dx_dXo_3=-(c/(D_3**2))*(r13*Nx_3 - r11*D_3)
    dx_dYo_3=-(c/(D_3**2))*(r23*Nx_3 - r21*D_3)
    dx_dZo_3=-(c/(D_3**2))*(r33*Nx_3 - r31*D_3)
    dy_dw_3=-(c/D_3)*((Y3-Y06)*r33-(Z3-Z06)*r23*(Ny_3/D_3)-(Y3-Y06)*r32+(Z3-Z06)*r22)
    dy_dfi_3=(c/D_3)*((Nx_3*(math.cos(k6))-Ny_3*(math.sin(k6)))*(Ny_3/D_3)-D_3*math.sin(k6))
    dy_dk_3=(c/D_3)*Nx_3
    dy_dXo_3=-(c/(D_3**2))*(r13*Ny_3 - r12*D_3)
    dy_dYo_3=-(c/(D_3**2))*(r23*Ny_3 - r22*D_3)
    dy_dZo_3=-(c/(D_3**2))*(r33*Ny_3 - r32*D_3)
    
    #4
    dx_dw_4=-(c/D_4)*((Y4-Y06)*r33-(Z4-Z06)*r23*(Nx_4/D_4)-(Y4-Y06)*r31+(Z4-Z06)*r21)
    dx_dfi_4=-(c/D_4)*((Nx_4*math.cos(k6)-Ny_4*math.sin(k6))*(Nx_4/D_4)+D_4*math.cos(k6))
    dx_dk_4=-(c/D_4)*Ny_4
    dx_dXo_4=-(c/(D_4**2))*(r13*Nx_4 - r11*D_4)
    dx_dYo_4=-(c/(D_4**2))*(r23*Nx_4 - r21*D_4)
    dx_dZo_4=-(c/(D_4**2))*(r33*Nx_4 - r31*D_4)
    dy_dw_4=-(c/D_4)*((Y4-Y06)*r33-(Z4-Z06)*r23*(Ny_4/D_4)-(Y4-Y06)*r32+(Z4-Z06)*r22)
    dy_dfi_4=(c/D_4)*((Nx_4*math.cos(k6)-Ny_4*math.sin(k6))*(Ny_4/D_4)-D_4*math.sin(k6))
    dy_dk_4=(c/D_4)*Nx_4
    dy_dXo_4=-(c/(D_4**2))*(r13*Ny_4 - r12*D_4)
    dy_dYo_4=-(c/(D_4**2))*(r23*Ny_4 - r22*D_4)
    dy_dZo_4=-(c/(D_4**2))*(r33*Ny_4 - r32*D_4)
    
    #5
    dx_dw_5=-(c/D_5)*((Y5-Y06)*r33-(Z5-Z06)*r23*(Nx_5/D_5)-(Y5-Y06)*r31+(Z5-Z06)*r21)
    dx_dfi_5=-(c/D_5)*((Nx_5*math.cos(k6)-Ny_5*math.sin(k6))*(Nx_5/D_5)+D_5*math.cos(k6))
    dx_dk_5=-(c/D_5)*Ny_5
    dx_dXo_5=-(c/(D_5**2))*(r13*Nx_5 - r11*D_5)
    dx_dYo_5=-(c/(D_5**2))*(r23*Nx_5 - r21*D_5)
    dx_dZo_5=-(c/(D_5**2))*(r33*Nx_5 - r31*D_5)
    dy_dw_5=-(c/D_5)*((Y5-Y06)*r33-(Z5-Z06)*r23*(Ny_5/D_5)-(Y5-Y06)*r32+(Z5-Z06)*r22)
    dy_dfi_5=(c/D_5)*((Nx_5*math.cos(k6)-Ny_5*math.sin(k6))*(Ny_5/D_5)-D_5*math.sin(k6))
    dy_dk_5=(c/D_5)*Nx_5
    dy_dXo_5=-(c/(D_5**2))*(r13*Ny_5 - r12*D_5)
    dy_dYo_5=-(c/(D_5**2))*(r23*Ny_5 - r22*D_5)
    dy_dZo_5=-(c/(D_5**2))*(r33*Ny_5 - r32*D_5)
    
    
    #Coordenadas foto pelo ajustamento
    x_1=x0-c*(Nx_1/D_1)
    y_1=y0-c*(Ny_1/D_1)
    
    x_2=x0-c*(Nx_2/D_2)
    y_2=y0-c*(Ny_2/D_2)
    
    x_3=x0-c*(Nx_3/D_3)
    y_3=y0-c*(Ny_3/D_3)
    
    x_4=x0-c*(Nx_4/D_4)
    y_4=y0-c*(Ny_4/D_4)
    
    x_5=x0-c*(Nx_5/D_5)
    y_5=y0-c*(Ny_5/D_5)
    
    
    #Cálculo dos parâmetros ajustados
    A = np.array([[dx_dw_1, dx_dfi_1, dx_dk_1, dx_dXo_1, dx_dYo_1, dx_dZo_1], [dy_dw_1, dy_dfi_1, dy_dk_1, dy_dXo_1, dy_dYo_1, dy_dZo_1],[dx_dw_2, dx_dfi_2, dx_dk_2, dx_dXo_2, dx_dYo_2, dx_dZo_2],[dy_dw_2, dy_dfi_2, dy_dk_2, dy_dXo_2, dy_dYo_2, dy_dZo_2],[dx_dw_3, dx_dfi_3, dx_dk_3, dx_dXo_3, dx_dYo_3, dx_dZo_3],[dy_dw_3, dy_dfi_3, dy_dk_3, dy_dXo_3, dy_dYo_3, dy_dZo_3],[dx_dw_4, dx_dfi_4, dx_dk_4, dx_dXo_4, dx_dYo_4, dx_dZo_4],[dy_dw_4, dy_dfi_4, dy_dk_4, dy_dXo_4, dy_dYo_4, dy_dZo_4],[dx_dw_5, dx_dfi_5, dx_dk_5, dx_dXo_5, dx_dYo_5, dx_dZo_5],[dy_dw_5, dy_dfi_5, dy_dk_5, dy_dXo_5, dy_dYo_5, dy_dZo_5]])
    L= np.array([[(x1_6/1000-x_1)],[(y1_6/1000-y_1)],[(x2_6/1000-x_2)],[(y2_6/1000-y_2)],[(x3_6/1000-x_3)],[(y3_6/1000-y_3)],[(x4_6/1000-x_4)],[(y4_6/1000-y_4)],[(x5_6/1000-x_5)],[(y5_6/1000-y_5)]])    
    X=(np.linalg.inv(np.transpose(A).dot(A))).dot(np.transpose(A)).dot(L)
    w6=w6+X[0][0]
    fi6=fi6+X[1][0]
    k6=k6+X[2][0]
    X06=X06+X[3][0]
    Y06=Y06+X[4][0]
    Z06=Z06+X[5][0]

    #Critério de paragem
    mau=[]
    for i in X:
        if abs(i) > 0.1:
            mau.append(i)
    if len(mau) ==0:
        k=3
    else:
        k=2

    s=s+1

#Verificação de resultados calculando as coordenadas foto do ponto 6
r11=(math.cos(fi6))*(math.cos(k6))
r12=-(math.cos(fi6))*(math.sin(k6))
r13=math.sin(fi6)
r21=(math.cos(w6))*(math.sin(k6))+(math.sin(w6))*(math.sin(fi6))*(math.cos(k6))
r22=(math.cos(w6))*(math.cos(k6))-(math.sin(w6))*(math.sin(fi6))*(math.sin(k6))
r23=-(math.sin(w6))*(math.cos(fi6))
r31=(math.sin(w6))*(math.sin(k6))-(math.cos(w6))*(math.sin(fi6))*(math.cos(k6))
r32=(math.sin(w6))*(math.cos(k6))+(math.cos(w6))*(math.sin(fi6))*(math.sin(k6))
r33=(math.cos(w6))*(math.cos(fi6))

Nx_6=r11*(X6-X06)+r21*(Y6-Y06)+r31*(Z6-Z06)
Ny_6=r12*(X6-X06)+r22*(Y6-Y06)+r32*(Z6-Z06)
D_6=r13*(X6-X06)+r23*(Y6-Y06)+r33*(Z6-Z06)

x_6=x0-c*(Nx_6/D_6)
y_6=y0-c*(Ny_6/D_6)

x_6=x_6*1000
y_6=y_6*1000

# print(x_6)
# print(y_6)

#Passagem dos ângulos para graus
w6_g=w6*180/math.pi
fi6_g=fi6*180/math.pi
k6_g=k6*180/math.pi

#Output
print("\n")
print("ORIENTAÇÃO EXTERNA DA FOTO 6:")
print("omega= ", round(w6_g,3),"graus")
print("fi= ", round(fi6_g,3),"graus")
print("k= ", round(k6_g,3),"graus")
print("X0= ", round(X06,3),"m")
print("Y0= ", round(Y06,3),"m")
print("Z0= ", round(Z06,3),"m")



#2- Determinação coordenadas A,B,C

#Matriz rotação para foto 7
r11_7=(math.cos(fi7))*(math.cos(k7))
r12_7=-(math.cos(fi7))*(math.sin(k7))
r13_7=math.sin(fi7)
r21_7=(math.cos(w7))*(math.sin(k7))+(math.sin(w7))*(math.sin(fi7))*(math.cos(k7))
r22_7=(math.cos(w7))*(math.cos(k7))-(math.sin(w7))*(math.sin(fi7))*(math.sin(k7))
r23_7=-(math.sin(w7))*(math.cos(fi7))
r31_7=(math.sin(w7))*(math.sin(k7))-(math.cos(w7))*(math.sin(fi7))*(math.cos(k7))
r32_7=(math.sin(w7))*(math.cos(k7))+(math.cos(w7))*(math.sin(fi7))*(math.sin(k7))
r33_7=(math.cos(w7))*(math.cos(fi7))


#K's
Kx6_A=(r11*(xA_6/1000-x0)+r12*(yA_6/1000-y0)-r13*c)/(r31*(xA_6/1000-x0)+r32*(yA_6/1000-x0)-r33*c)
Ky6_A=(r21*(xA_6/1000-x0)+r22*(yA_6/1000-y0)-r23*c)/(r31*(xA_6/1000-x0)+r32*(yA_6/1000-x0)-r33*c)
Kx7_A=(r11_7*(xA_7/1000-x0)+r12_7*(yA_7/1000-y0)-r13_7*c)/(r31_7*(xA_7/1000-x0)+r32_7*(yA_7/1000-x0)-r33_7*c)
Ky7_A=(r21_7*(xA_7/1000-x0)+r22_7*(yA_7/1000-y0)-r23_7*c)/(r31_7*(xA_7/1000-x0)+r32_7*(yA_7/1000-x0)-r33_7*c)

Kx6_B=(r11*(xB_6/1000-x0)+r12*(yB_6/1000-y0)-r13*c)/(r31*(xB_6/1000-x0)+r32*(yB_6/1000-x0)-r33*c)
Ky6_B=(r21*(xB_6/1000-x0)+r22*(yB_6/1000-y0)-r23*c)/(r31*(xB_6/1000-x0)+r32*(yB_6/1000-x0)-r33*c)
Kx7_B=(r11_7*(xB_7/1000-x0)+r12_7*(yB_7/1000-y0)-r13_7*c)/(r31_7*(xB_7/1000-x0)+r32_7*(yB_7/1000-x0)-r33_7*c)
Ky7_B=(r21_7*(xB_7/1000-x0)+r22_7*(yB_7/1000-y0)-r23_7*c)/(r31_7*(xB_7/1000-x0)+r32_7*(yB_7/1000-x0)-r33_7*c)

Kx6_C=(r11*(xC_6/1000-x0)+r12*(yC_6/1000-y0)-r13*c)/(r31*(xC_6/1000-x0)+r32*(yC_6/1000-x0)-r33*c)
Ky6_C=(r21*(xC_6/1000-x0)+r22*(yC_6/1000-y0)-r23*c)/(r31*(xC_6/1000-x0)+r32*(yC_6/1000-x0)-r33*c)
Kx7_C=(r11_7*(xC_7/1000-x0)+r12_7*(yC_7/1000-y0)-r13_7*c)/(r31_7*(xC_7/1000-x0)+r32_7*(yC_7/1000-x0)-r33_7*c)
Ky7_C=(r21_7*(xC_7/1000-x0)+r22_7*(yC_7/1000-y0)-r23_7*c)/(r31_7*(xC_7/1000-x0)+r32_7*(yC_7/1000-x0)-r33_7*c)

#Coordenadas iniciais para A, B e C
ZA=(X07-Z07*Kx7_A+Z06*Kx6_A-X06)/(Kx6_A-Kx7_A)
XA1=X06+(ZA-Z06)*Kx6_A
YA1=Y06+(ZA-Z06)*Ky6_A
XA2=X07+(ZA-Z07)*Kx7_A
YA2=Y07+(ZA-Z07)*Ky7_A
XA=(XA1+XA2)/2
YA=(YA1+YA2)/2

ZB=(X07-Z07*Kx7_B+Z06*Kx6_B-X06)/(Kx6_B-Kx7_B)
XB1=X06+(ZB-Z06)*Kx6_B
YB1=Y06+(ZB-Z06)*Ky6_B
XB2=X07+(ZB-Z07)*Kx7_B
YB2=Y07+(ZB-Z07)*Ky7_B
XB=(XB1+XB2)/2
YB=(YB1+YB2)/2

ZC=(X07-Z07*Kx7_C+Z06*Kx6_C-X06)/(Kx6_C-Kx7_C)
XC1=X06+(ZC-Z06)*Kx6_C
YC1=Y06+(ZC-Z06)*Ky6_C
XC2=X07+(ZC-Z07)*Kx7_C
YC2=Y07+(ZC-Z07)*Ky7_C
XC=(XC1+XC2)/2
YC=(YC1+YC2)/2


#Determinação de coordenadas de A, B e C pelo ajustamento por mínimos quadrados
p=0
k=0
while (k != 3):
    
    #Nx,Ny e D para cada ponto em cada foto
    Nx_A6=r11*(XA-X06)+r21*(YA-Y06)+r31*(ZA-Z06)
    Ny_A6=r12*(XA-X06)+r22*(YA-Y06)+r32*(ZA-Z06)
    D_A6=r13*(XA-X06)+r23*(YA-Y06)+r33*(ZA-Z06)
    Nx_B6=r11*(XB-X06)+r21*(YB-Y06)+r31*(ZB-Z06)
    Ny_B6=r12*(XB-X06)+r22*(YB-Y06)+r32*(ZB-Z06)
    D_B6=r13*(XB-X06)+r23*(YB-Y06)+r33*(ZB-Z06)
    Nx_C6=r11*(XC-X06)+r21*(YC-Y06)+r31*(ZC-Z06)
    Ny_C6=r12*(XC-X06)+r22*(YC-Y06)+r32*(ZC-Z06)
    D_C6=r13*(XC-X06)+r23*(YC-Y06)+r33*(ZC-Z06)
    
    Nx_A7=r11_7*(XA-X07)+r21_7*(YA-Y07)+r31_7*(ZA-Z07)
    Ny_A7=r12_7*(XA-X07)+r22_7*(YA-Y07)+r32_7*(ZA-Z07)
    D_A7=r13_7*(XA-X07)+r23_7*(YA-Y07)+r33_7*(ZA-Z07)
    Nx_B7=r11_7*(XB-X07)+r21_7*(YB-Y07)+r31_7*(ZB-Z07)
    Ny_B7=r12_7*(XB-X07)+r22_7*(YB-Y07)+r32_7*(ZB-Z07)
    D_B7=r13_7*(XB-X07)+r23_7*(YB-Y07)+r33_7*(ZB-Z07)
    Nx_C7=r11_7*(XC-X07)+r21_7*(YC-Y07)+r31_7*(ZC-Z07)
    Ny_C7=r12_7*(XC-X07)+r22_7*(YC-Y07)+r32_7*(ZC-Z07)
    D_C7=r13_7*(XC-X07)+r23_7*(YC-Y07)+r33_7*(ZC-Z07)
    
    
    #Derivadas parciais para cada ponto em cada foto
    
    #Foto 6
    #A
    dx_dX_A_6=-(c/(D_A6**2))*(D_A6*r11-Nx_A6*r13)
    dx_dY_A_6=-(c/(D_A6**2))*(D_A6*r21-Nx_A6*r23)
    dx_dZ_A_6=-(c/(D_A6**2))*(D_A6*r31-Nx_A6*r33)
    dy_dX_A_6=-(c/(D_A6**2))*(D_A6*r12-Ny_A6*r13)
    dy_dY_A_6=-(c/(D_A6**2))*(D_A6*r22-Ny_A6*r23)
    dy_dZ_A_6=-(c/(D_A6**2))*(D_A6*r32-Ny_A6*r33)
    
    #B
    dx_dX_B_6=-(c/(D_B6**2))*(D_B6*r11-Nx_B6*r13)
    dx_dY_B_6=-(c/(D_B6**2))*(D_B6*r21-Nx_B6*r23)
    dx_dZ_B_6=-(c/(D_B6**2))*(D_B6*r31-Nx_B6*r33)
    dy_dX_B_6=-(c/(D_B6**2))*(D_B6*r12-Ny_B6*r13)
    dy_dY_B_6=-(c/(D_B6**2))*(D_B6*r22-Ny_B6*r23)
    dy_dZ_B_6=-(c/(D_B6**2))*(D_B6*r32-Ny_B6*r33)
    
    #C
    dx_dX_C_6=-(c/(D_C6**2))*(D_C6*r11-Nx_C6*r13)
    dx_dY_C_6=-(c/(D_C6**2))*(D_C6*r21-Nx_C6*r23)
    dx_dZ_C_6=-(c/(D_C6**2))*(D_C6*r31-Nx_C6*r33)
    dy_dX_C_6=-(c/(D_C6**2))*(D_C6*r12-Ny_C6*r13)
    dy_dY_C_6=-(c/(D_C6**2))*(D_C6*r22-Ny_C6*r23)
    dy_dZ_C_6=-(c/(D_C6**2))*(D_C6*r32-Ny_C6*r33)
    
    #Foto 7
    #A
    dx_dX_A_7=-(c/(D_A7**2))*(D_A7*r11_7-Nx_A7*r13_7)
    dx_dY_A_7=-(c/(D_A7**2))*(D_A7*r21_7-Nx_A7*r23_7)
    dx_dZ_A_7=-(c/(D_A7**2))*(D_A7*r31_7-Nx_A7*r33_7)
    dy_dX_A_7=-(c/(D_A7**2))*(D_A7*r12_7-Ny_A7*r13_7)
    dy_dY_A_7=-(c/(D_A7**2))*(D_A7*r22_7-Ny_A7*r23_7)
    dy_dZ_A_7=-(c/(D_A7**2))*(D_A7*r32_7-Ny_A7*r33_7)
    
    #B
    dx_dX_B_7=-(c/(D_B7**2))*(D_B7*r11_7-Nx_B7*r13_7)
    dx_dY_B_7=-(c/(D_B7**2))*(D_B7*r21_7-Nx_B7*r23_7)
    dx_dZ_B_7=-(c/(D_B7**2))*(D_B7*r31_7-Nx_B7*r33_7)
    dy_dX_B_7=-(c/(D_B7**2))*(D_B7*r12_7-Ny_B7*r13_7)
    dy_dY_B_7=-(c/(D_B7**2))*(D_B7*r22_7-Ny_B7*r23_7)
    dy_dZ_B_7=-(c/(D_B7**2))*(D_B7*r32_7-Ny_B7*r33_7)
    
    #C
    dx_dX_C_7=-(c/(D_C7**2))*(D_C7*r11_7-Nx_C7*r13_7)
    dx_dY_C_7=-(c/(D_C7**2))*(D_C7*r21_7-Nx_C7*r23_7)
    dx_dZ_C_7=-(c/(D_C7**2))*(D_C7*r31_7-Nx_C7*r33_7)
    dy_dX_C_7=-(c/(D_C7**2))*(D_C7*r12_7-Ny_C7*r13_7)
    dy_dY_C_7=-(c/(D_C7**2))*(D_C7*r22_7-Ny_C7*r23_7)
    dy_dZ_C_7=-(c/(D_C7**2))*(D_C7*r32_7-Ny_C7*r33_7)
    
    #Coordenadas foto ajustadas
    xcA_6=x0-c*(Nx_A6/D_A6)
    ycA_6=y0-c*(Ny_A6/D_A6)
    xcB_6=x0-c*(Nx_B6/D_B6)
    ycB_6=y0-c*(Ny_B6/D_B6)
    xcC_6=x0-c*(Nx_C6/D_C6)
    ycC_6=y0-c*(Ny_C6/D_C6)
    
    xcA_7=x0-c*(Nx_A7/D_A7)
    ycA_7=y0-c*(Ny_A7/D_A7)
    xcB_7=x0-c*(Nx_B7/D_B7)
    ycB_7=y0-c*(Ny_B7/D_B7)
    xcC_7=x0-c*(Nx_C7/D_C7)
    ycC_7=y0-c*(Ny_C7/D_C7)
    
    #Cálculo dos parâmetros ajustados
    A2=np.array([[dx_dX_A_6, dx_dY_A_6, dx_dZ_A_6],[dy_dX_A_6, dy_dY_A_6, dy_dZ_A_6],[dx_dX_B_6, dx_dY_B_6, dx_dZ_B_6],[dy_dX_B_6, dy_dY_B_6, dy_dZ_B_6],[dx_dX_C_6, dx_dY_C_6, dx_dZ_C_6],[dy_dX_C_6, dy_dY_C_6, dy_dZ_C_6],[dx_dX_A_7, dx_dY_A_7, dx_dZ_A_7],[dy_dX_A_7, dy_dY_A_7, dy_dZ_A_7],[dx_dX_B_7, dx_dY_B_7, dx_dZ_B_7],[dy_dX_B_7, dy_dY_B_7, dy_dZ_B_7],[dx_dX_C_7, dx_dY_C_7, dx_dZ_C_7],[dy_dX_C_7, dy_dY_C_7, dy_dZ_C_7]])
    L2=np.array([[(xA_6/1000-xcA_6)],[(yA_6/1000-ycA_6)],[(xB_6/1000-xcB_6)],[(yB_6/1000-ycB_6)],[(xC_6/1000-xcC_6)],[(yC_6/1000-ycC_6)],[(xA_7/1000-xcA_7)],[(yA_7/1000-ycA_7)],[(xB_7/1000-xcB_7)],[(yB_7/1000-ycB_7)],[(xC_7/1000-xcC_7)],[(yC_7/1000-ycC_7)]])
    XX=(np.linalg.inv(np.transpose(A2).dot(A2))).dot(np.transpose(A2)).dot(L2)
    
    XA=XA+XX[0][0]
    YA=YA+XX[1][0]
    ZA=ZA+XX[2][0]
    
    XB=XB+XX[0][0]
    YB=YB+XX[1][0]
    ZB=ZB+XX[2][0]
    
    XC=XC+XX[0][0]
    YC=YC+XX[1][0]
    ZC=ZC+XX[2][0]
    
    #Critério de paragem
    mau2=[]
    for i in XX:
        if abs(i) > 0.001:
            mau2.append(i)
    if len(mau2) ==0:
        k=3
    else:
        k=2
    p=p+1
    
#Output
print("\n")  
print("COORDENADAS TERRENO DOS PONTOS NOVOS:")  
print("Ponto A")
print("X= ",round(XA,3),"m")   
print("Y= ",round(YA,3),"m")
print("Z= ",round(ZA,3),"m")
print("\n")
print("Ponto B")
print("X= ",round(XB,3),"m")   
print("Y= ",round(YB,3),"m")
print("Z= ",round(ZB,3),"m")
print("\n")
print("Ponto C")
print("X= ",round(XC,3),"m")   
print("Y= ",round(YC,3),"m")
print("Z= ",round(ZC,3),"m")
print("\n")
    
    
