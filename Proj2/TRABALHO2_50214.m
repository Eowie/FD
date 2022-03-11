%Trabalho Prático 2
%nome: João Miguel Pinto Ferreira
%nº de aluno: 50214
%disciplina: Fotogrametria Digital
%curso: Engenharia Geoespacial

%Cálculo da orientação externa da foto 6.
tic
clear all
format long
%orientacao interna - certificado de calibracao da camara DMC
x0=0
y0=0
c=120
%orientacao externa foto 6, verifiquei as coordenadas foto dos PF e
%verifiquei aproximadamente o centro ótico com as coordenadas no terreno,
%escolhi o ponto 6000, os valore de omega, phi, k e Z0  foram pela foto 7

X0_6=-89949.4
Y0_6=-101095.74
Z0_6=1096.0633
omega0_6=0.1208 
fi0_6=0.2895 
kappa0_6=15.7612


%escolha dos Pf (4 pontos para cálculo, 2 para validação)

PFs_foto=[-1.026 68.670
            44.310 65.634
            2.526  -70.734
            41.166 -61.722]
PFs=[-90158.653	-100565.532	93.799
            -89794.832	-100478.941	89.069
            -89788.239	-101679.518	81.974
            -89514.366	-101489.343	123.038]

        
        
% Determinação da orientação externa da foto 6
%temos 6 incognitas e 4 PFs(2 eq por cada PF), logo a matriz é uma 12x6
n_inc=6
N_eq=8 %2 equacoes por cada pf
m=N_eq

pesos=eye(m)

% vamos comecar a efetuar a correcao aos parametros de orientacao externa
%da foto 6, assim atribuimos às correções o valor de 1 e vamos atribuir um
%critério de paragem



parametros=[1;1;1;1;1;1]
paragem=0.0001295

%definimos o máximo para que todos os parametros sejam menores que o
%critério de paragem
while max(abs(parametros))>paragem

%matriz de rotação (omega,phi,k)
Rot(1,1)=cosd(fi0_6)*cosd(kappa0_6)
Rot(1,2)=-cosd(fi0_6)*sind(kappa0_6)
Rot(1,3)=sind(fi0_6)
Rot(2,1)=cosd(omega0_6)*sind(kappa0_6)+sind(omega0_6)*sind(fi0_6)*cosd(kappa0_6)
Rot(2,2)=cosd(omega0_6)*cosd(kappa0_6)-sind(omega0_6)*sind(fi0_6)*sind(kappa0_6)
Rot(2,3)=-sind(omega0_6)*cosd(fi0_6)
Rot(3,1)=sind(omega0_6)*sind(kappa0_6)-cosd(omega0_6)*sind(fi0_6)*cosd(kappa0_6)
Rot(3,2)=sind(omega0_6)*cosd(kappa0_6)+cosd(omega0_6)*sind(fi0_6)*sind(kappa0_6)
Rot(3,3)=cosd(omega0_6)*cosd(fi0_6)
%calculos de Nx, Ny e D
for a=1:size(PFs,1)
   Nx(a)=Rot(1,1)*(PFs(a,1)-X0_6)+Rot(2,1)*(PFs(a,2)-Y0_6)+Rot(3,1)*(PFs(a,3)-Z0_6)
   Ny(a)=Rot(1,2)*(PFs(a,1)-X0_6)+Rot(2,2)*(PFs(a,2)-Y0_6)+Rot(3,2)*(PFs(a,3)-Z0_6)
   D(a)=Rot(1,3)*(PFs(a,1)-X0_6)+Rot(2,3)*(PFs(a,2)-Y0_6)+Rot(3,3)*(PFs(a,3)-Z0_6)
   x_inicial(a,1)=x0-(c*Nx(a)/D(a))
   y_inicial(a,1)=y0-(c*Ny(a)/D(a))
end


for n=1:size(PFs,1)
    
   %Calculo do vetor Vx
   A(2*n-1,1)=(-c/D(n)^2)*(Rot(1,3)*Nx(n)-Rot(1,1)*D(n))
   A(2*n-1,2)=(-c/D(n)^2)*(Rot(2,3)*Nx(n)-Rot(2,1)*D(n))
   A(2*n-1,3)=(-c/D(n)^2)*(Rot(3,3)*Nx(n)-Rot(3,1)*D(n))
   A(2*n-1,4)=(-c/D(n))*((((PFs(n,2)-Y0_6)*Rot(3,3)-(PFs(n,3)-Z0_6)*Rot(2,3))*Nx(n)/D(n))-((PFs(n,2)-Y0_6)*Rot(3,1)+(PFs(n,3)-Z0_6)*Rot(2,1)))
   A(2*n-1,5)=(c/D(n))*((Nx(n)*cosd(kappa0_6)-Ny(n)*sind(kappa0_6))*(Nx(n)/D(n))+D(n)*cosd(kappa0_6))
   A(2*n-1,6)=(-c/D(n))*Ny(n)
   
   
   %vetor de obs
   l(2*n-1,1)=PFs_foto(n,1)-x_inicial(n,1)
   
  %Calculo do vector Vy
   A(2*n,1)=(-c/D(n)^2)*(Rot(1,3)*Ny(n)-Rot(1,2)*D(n))
   A(2*n,2)=(-c/D(n)^2)*(Rot(2,3)*Ny(n)-Rot(2,2)*D(n))
   A(2*n,3)=(-c/D(n)^2)*(Rot(3,3)*Ny(n)-Rot(3,2)*D(n))
   A(2*n,4)=(-c/D(n))*((((PFs(n,2)-Y0_6)*Rot(3,3)-(PFs(n,3)-Z0_6)*Rot(2,3))*Ny(n)/D(n))-((PFs(n,2)-Y0_6)*Rot(3,2)+(PFs(n,3)-Z0_6)*Rot(2,2)))
   A(2*n,5)=(c/D(n))*((Nx(n)*cosd(kappa0_6)-Ny(n)*sind(kappa0_6))*(Ny(n)/D(n))-D(n)*sind(kappa0_6))
   A(2*n,6)=(c/D(n))*Nx(n)
 
 
   %vetor de obs
   l(2*n,1)=PFs_foto(n,2)-y_inicial(n,1)
        
end
    
   parametros=inv(A'*pesos*A)*A'*pesos*l 
   % correcao aos valores iniciais
   X0_6=X0_6+parametros(1)
   Y0_6=Y0_6+parametros(2)
   Z0_6=Z0_6+parametros(3)
   omega0_6=omega0_6+parametros(4)
   fi0_6=fi0_6+parametros(5)
   kappa0_6=kappa0_6+parametros(6)

end

%parametros da orientacao externa da foto 6
X0_6=X0_6
Y0_6=Y0_6
Z0_6=Z0_6
omega_6=omega0_6
phi_6=fi0_6
k_6=kappa0_6
%parametros de orientacao externa foto7
X0_7=-89710.750
Y0_7=-100990.128 
Z0_7= 1095.365
omega_7=0.1208
phi_7=0.2895
k_7=15.7612

%coordenadas foto dos pontos A,B,C
Afoto6=[38.898;-34.266]
Bfoto6=[34.268;-47.658]
Cfoto6=[41.986;-50.164]      

Afoto7=[4.866;-38.166]
Bfoto7=[0.606;-51.966]
Cfoto7=[8.490;-54.402]
      
%coordenadas terreno inciais para cada ponto
%Matriz de rotacao (omega,phi,k) foto 6
Rot6(1,1)=cosd(phi_6)*cosd(k_6)
Rot6(1,2)=-cosd(phi_6)*sind(k_6)
Rot6(1,3)=sind(phi_6)
Rot6(2,1)=cosd(omega_6)*sind(k_6)+sind(omega_6)*sind(phi_6)*cosd(k_6)
Rot6(2,2)=cosd(omega_6)*cosd(k_6)-sind(omega_6)*sind(phi_6)*sind(k_6)
Rot6(2,3)=-sind(omega_6)*cosd(phi_6)
Rot6(3,1)=sind(omega_6)*sind(k_6)-cosd(omega_6)*sind(phi_6)*cosd(k_6)
Rot6(3,2)=sind(omega_6)*cosd(k_6)+cosd(omega_6)*sind(phi_6)*sind(k_6)
Rot6(3,3)=cosd(omega_6)*cosd(phi_6)

%Matriz de rotacao (omega,phi,k) foto 7 
Rot7(1,1)=cosd(phi_7)*cosd(k_7)
Rot7(1,2)=-cosd(phi_7)*sind(k_7)
Rot7(1,3)=sind(phi_7)
Rot7(2,1)=cosd(omega_7)*sind(k_7)+sind(omega_7)*sind(phi_7)*cosd(k_7)
Rot7(2,2)=cosd(omega_7)*cosd(k_7)-sind(omega_7)*sind(phi_7)*sind(k_7)
Rot7(2,3)=-sind(omega_7)*cosd(phi_7)
Rot7(3,1)=sind(omega_7)*sind(k_7)-cosd(omega_7)*sind(phi_7)*cosd(k_7)
Rot7(3,2)=sind(omega_7)*cosd(k_7)+cosd(omega_7)*sind(phi_7)*sind(k_7)
Rot7(3,3)=cosd(omega_7)*cosd(phi_7)

%cálculo dos valores de k através das equações de colinearidade
%os parametros de orientacao (xo,y0,c) são iguais nas 2 fotos
%o denominador é igual para as duas equcoes (x,y)
K6A_d=(Rot6(3,1)*(Afoto6(1)-x0)+Rot6(3,2)*(Afoto6(2)-y0)-Rot6(3,3)*c)
Kx6A=(Rot6(1,1)*(Afoto6(1)-x0)+Rot6(1,2)*(Afoto6(2)-y0)-Rot6(1,3)*c)/K6A_d
Ky6A=(Rot6(2,1)*(Afoto6(1)-x0)+Rot6(2,2)*(Afoto6(2)-y0)-Rot6(2,3)*c)/K6A_d

K6B_d=(Rot6(3,1)*(Bfoto6(1)-x0)+Rot6(3,2)*(Bfoto6(2)-y0)-Rot6(3,3)*c)
Kx6B=(Rot6(1,1)*(Bfoto6(1)-x0)+Rot6(1,2)*(Bfoto6(2)-y0)-Rot6(1,3)*c)/K6B_d
Ky6B=(Rot6(2,1)*(Bfoto6(1)-x0)+Rot6(2,2)*(Bfoto6(2)-y0)-Rot6(2,3)*c)/K6B_d

K6C_d=(Rot6(3,1)*(Cfoto6(1)-x0)+Rot6(3,2)*(Cfoto6(2)-y0)-Rot6(3,3)*c)
Kx6C=(Rot6(1,1)*(Cfoto6(1)-x0)+Rot6(1,2)*(Cfoto6(2)-y0)-Rot6(1,3)*c)/K6C_d
Ky6C=(Rot6(2,1)*(Cfoto6(1)-x0)+Rot6(2,2)*(Cfoto6(2)-y0)-Rot6(2,3)*c)/K6C_d

K7A_d=(Rot7(3,1)*(Afoto7(1)-x0)+Rot7(3,2)*(Afoto7(2)-y0)-Rot7(3,3)*c)
Kx7A=(Rot7(1,1)*(Afoto7(1)-x0)+Rot7(1,2)*(Afoto7(2)-y0)-Rot7(1,3)*c)/K7A_d
Ky7A=(Rot7(2,1)*(Afoto7(1)-x0)+Rot7(2,2)*(Afoto7(2)-y0)-Rot7(2,3)*c)/K7A_d

K7B_d=(Rot7(3,1)*(Bfoto7(1)-x0)+Rot7(3,2)*(Bfoto7(2)-y0)-Rot7(3,3)*c)
Kx7B=(Rot7(1,1)*(Bfoto7(1)-x0)+Rot7(1,2)*(Bfoto7(2)-y0)-Rot7(1,3)*c)/K7B_d
Ky7B=(Rot7(2,1)*(Bfoto7(1)-x0)+Rot7(2,2)*(Bfoto7(2)-y0)-Rot7(2,3)*c)/K7B_d

K7C_d=(Rot7(3,1)*(Cfoto7(1)-x0)+Rot7(3,2)*(Cfoto7(2)-y0)-Rot7(3,3)*c)
Kx7C=(Rot7(1,1)*(Cfoto7(1)-x0)+Rot7(1,2)*(Cfoto7(2)-y0)-Rot7(1,3)*c)/K7C_d
Ky7C=(Rot7(2,1)*(Cfoto7(1)-x0)+Rot7(2,2)*(Cfoto7(2)-y0)-Rot7(2,3)*c)/K7C_d

%calculo do valor de Z comum ás duas fotos, para cada ponto
ZA=(X0_7-Z0_7*Kx7A+Z0_6*Kx6A-X0_6)/(Kx6A-Kx7A)
ZB=(X0_7-Z0_7*Kx7B+Z0_6*Kx6B-X0_6)/(Kx6B-Kx7B)
ZC=(X0_7-Z0_7*Kx7C+Z0_6*Kx6C-X0_6)/(Kx6C-Kx7C)

%calculo dos valores de X e Y de cada ponto nas 2 fotos
XA6=X0_6+(ZA-Z0_6)*Kx6A
YA6=Y0_6+(ZA-Z0_6)*Ky6A
XA7=X0_7+(ZA-Z0_7)*Kx7A
YA7=Y0_7+(ZA-Z0_7)*Ky7A

XB6=X0_6+(ZB-Z0_6)*Kx6B
YB6=Y0_6+(ZB-Z0_6)*Ky6B
XB7=X0_7+(ZB-Z0_7)*Kx7B
YB7=Y0_7+(ZB-Z0_7)*Ky7B

XC6=X0_6+(ZC-Z0_6)*Kx6C
YC6=Y0_6+(ZC-Z0_6)*Ky6C
XC7=X0_7+(ZC-Z0_7)*Kx7C
YC7=Y0_7+(ZC-Z0_7)*Ky7C

%Pelos apontamentos da aula os valores de X são iguais enquanto que os de Y
%tem de se fazer uma média, os valores de Z já foram calculados. Apesar
%disto fiz uma média para os valores de X e Y.
%coordenadas iniciais terreno dos pontos para entrada no ciclo  
P_terr_0(1,1)=(XA6+XA7)/2
P_terr_0(1,2)=(YA6+YA7)/2
P_terr_0(1,3)=ZA
P_terr_0(2,1)=(XB6+XB7)/2
P_terr_0(2,2)=(YB6+YB7)/2
P_terr_0(2,3)=ZB
P_terr_0(3,1)=(XC6+XC7)/2
P_terr_0(3,2)=(YC6+YC7)/2
P_terr_0(3,3)=ZC

%número d equacoes
n=12
%Variancia a priori
pesos=eye(12)
%a variacao só a coloquei para conseguir entrar no ciclo.
delta_x=[1;1;1;1;1;1;1;1;1]
paragem=0.001
iteracoes=0
while max(abs(delta_x))>paragem
    iteracoes=iteracoes+1
 %vou calcular as coordenadas foto de cada ponto para cada foto, com base nas coordenadas
 %terreno inciais
 for a=1:size(P_terr_0,1)
     %aqui fui utilizar as coordenadas terreno usadas anteriormente através
     %da média
   Nx6(a)=Rot6(1,1)*(P_terr_0(a,1)-X0_6)+Rot6(2,1)*(P_terr_0(a,2)-Y0_6)+Rot6(3,1)*(P_terr_0(a,3)-Z0_6)
   Ny6(a)=Rot6(1,2)*(P_terr_0(a,1)-X0_6)+Rot6(2,2)*(P_terr_0(a,2)-Y0_6)+Rot6(3,2)*(P_terr_0(a,3)-Z0_6)
   D6(a)=Rot6(1,3)*(P_terr_0(a,1)-X0_6)+Rot6(2,3)*(P_terr_0(a,2)-Y0_6)+Rot6(3,3)*(P_terr_0(a,3)-Z0_6)
   x_inicial6(a)=x0-(c*Nx6(a)/D6(a))
   y_inicial6(a)=y0-(c*Ny6(a)/D6(a))
   Nx7(a)=Rot7(1,1)*(P_terr_0(a,1)-X0_7)+Rot7(2,1)*(P_terr_0(a,2)-Y0_7)+Rot7(3,1)*(P_terr_0(a,3)-Z0_7)
   Ny7(a)=Rot7(1,2)*(P_terr_0(a,1)-X0_7)+Rot7(2,2)*(P_terr_0(a,2)-Y0_7)+Rot7(3,2)*(P_terr_0(a,3)-Z0_7)
   D7(a)=Rot7(1,3)*(P_terr_0(a,1)-X0_7)+Rot7(2,3)*(P_terr_0(a,2)-Y0_7)+Rot7(3,3)*(P_terr_0(a,3)-Z0_7)
   x_inicial7(a)=x0-(c*Nx7(a)/D7(a))
   y_inicial7(a)=y0-(c*Ny7(a)/D7(a))
   
   %determinação das variaveis para as equacoes de observacao 6 por foto
   dxdX6(a)= -(c/(D6(a))^2)*(D6(a)*Rot6(1,1) - Nx6(a)*Rot6(1,3))        
   dxdY6(a)= -(c/(D6(a))^2)*(D6(a)*Rot6(2,1) - Nx6(a)*Rot6(2,3))     
   dxdZ6(a)= -(c/(D6(a))^2)*(D6(a)*Rot6(3,1) - Nx6(a)*Rot6(3,3))       
   dydX6(a)= -(c/(D6(a))^2)*(D6(a)*Rot6(1,2) - Nx6(a)*Rot6(1,3))         
   dydY6(a)= -(c/(D6(a))^2)*(D6(a)*Rot6(2,2) - Nx6(a)*Rot6(2,3))       
   dydZ6(a)= -(c/(D6(a))^2)*(D6(a)*Rot6(3,2) - Nx6(a)*Rot6(3,3))     
   dxdX7(a)= -(c/(D7(a))^2)*(D7(a)*Rot7(1,1) - Nx7(a)*Rot6(1,3))        
   dxdY7(a)= -(c/(D7(a))^2)*(D7(a)*Rot7(2,1) - Nx7(a)*Rot6(2,3))     
   dxdZ7(a)= -(c/(D7(a))^2)*(D7(a)*Rot7(3,1) - Nx7(a)*Rot6(3,3))       
   dydX7(a)= -(c/(D7(a))^2)*(D7(a)*Rot7(1,2) - Nx7(a)*Rot6(1,3))         
   dydY7(a)= -(c/(D7(a))^2)*(D7(a)*Rot7(2,2) - Nx7(a)*Rot6(2,3))    
   dydZ7(a)= -(c/(D7(a))^2)*(D7(a)*Rot6(3,2) - Nx7(a)*Rot6(3,3))
   
 end
% matriz A
   A=[dxdX6(1) dxdY6(1) dxdZ6(1) 0 0 0 0 0 0
      dydX6(1) dydY6(1) dydZ6(1) 0 0 0 0 0 0
      dxdX7(1) dxdY7(1) dxdZ7(1) 0 0 0 0 0 0
      dydX7(1) dydY7(1) dydZ7(1) 0 0 0 0 0 0
      0 0 0 dxdX6(2) dxdY6(2) dxdZ6(2) 0 0 0
      0 0 0 dydX6(2) dydY6(2) dydZ6(2) 0 0 0
      0 0 0 dxdX7(2) dxdY7(2) dxdZ7(2) 0 0 0
      0 0 0 dydX7(2) dydY7(2) dydZ7(2) 0 0 0
      0 0 0 0 0 0 dxdX6(3) dxdY6(3) dxdZ6(3)
      0 0 0 0 0 0 dydX6(3) dydY6(3) dydZ6(3)
      0 0 0 0 0 0 dxdX7(3) dxdY7(3) dxdZ7(3)
      0 0 0 0 0 0 dydX7(3) dydY7(3) dydZ7(3)]  
       
  
  %vector de observacoes coordenadas_foto medidas- coordenadas calculadas
   l= [Afoto6(1)-x_inicial6(1)
       Afoto6(2)-y_inicial6(1)
       Afoto7(1)-x_inicial7(1)
       Afoto7(2)-y_inicial7(1)
       Bfoto6(1)-x_inicial6(2)
       Bfoto6(2)-y_inicial6(2)
       Bfoto7(1)-x_inicial7(2)
       Bfoto7(2)-y_inicial7(2)
       Cfoto6(1)-x_inicial6(3)
       Cfoto6(2)-y_inicial6(3)
       Cfoto7(1)-x_inicial7(3)
       Cfoto7(2)-y_inicial7(3)]

   delta_x=inv(A'*pesos*A)*(A'*pesos*l)
        
   %correcao às coordenadas terreno iniciais
    P_terr_0(1,1)=P_terr_0(1,1)+delta_x(1)
    P_terr_0(1,2)=P_terr_0(1,2)+delta_x(2)
    P_terr_0(1,3)=P_terr_0(1,3)+delta_x(3)
    P_terr_0(2,1)=P_terr_0(2,1)+delta_x(4)
    P_terr_0(2,2)=P_terr_0(2,2)+delta_x(5)
    P_terr_0(2,3)=P_terr_0(2,3)+delta_x(6)
    P_terr_0(3,1)=P_terr_0(3,1)+delta_x(7)
    P_terr_0(3,2)=P_terr_0(3,2)+delta_x(8)
    P_terr_0(3,3)=P_terr_0(3,3)+delta_x(9) 
    iteracoes=iteracoes+1
end


fprintf('________________________________ \n')
fprintf('Parametros de orientação externa da foto 6 \n')
fprintf('X0= %6.3f \n',X0_6)
fprintf('Y0= %6.3f \n',Y0_6)
fprintf('Z0= %6.3f \n',Z0_6)
fprintf('omega= %6.3f\n',omega_6)
fprintf('phi= %6.3f \n',phi_6)
fprintf('k= %6.3f \n',k_6)
fprintf('\n')
fprintf('________________________________ \n')
fprintf('Coordenadas ajustadas dos pontos A, B, C \n')
fprintf('\n')
fprintf('X ajustado de A= %6.3fm  \n', P_terr_0(1,1))
fprintf('Y ajustado de A= %6.3fm  \n', P_terr_0(1,2))
fprintf('Z ajustado de A= %6.3fm  \n', P_terr_0(1,3))
fprintf('X ajustado de B= %6.3fm  \n', P_terr_0(2,1))
fprintf('Y ajustado de B= %6.3fm  \n', P_terr_0(2,2))
fprintf('Z ajustado de B= %6.3fm  \n', P_terr_0(2,3))
fprintf('X ajustado de C= %6.3fm  \n', P_terr_0(3,1))
fprintf('Y ajustado de C= %6.3fm  \n', P_terr_0(3,2))
fprintf('Z ajustado de C= %6.3fm  \n', P_terr_0(3,3))
toc
