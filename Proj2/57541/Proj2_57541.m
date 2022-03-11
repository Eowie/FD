%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
% Programa Fotogrametria - Projeto 2
%
% Silvia Mourao
% FC57541
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Dispõe-se de duas fotografias aéreas, F6 e F7, que formam um par
% estereoscópico.
% Nessas fotografias foram medidos vários pontos novos e alguns PFs.
% A orientação externa da fotografia F6 é desconhecida.
% A da fotografia F7 é conhecida.
% Ambas as fotografias foram obtidas com a câmara digital Intergraph DMC,
% cujo certificado de calibração se encontra disponível no moodle.
% Estão igualmente disponíveis a orientação externa da foto F7, uma lista
% com as coordenadas foto de PFs e pontos novos medidos numa ou em
% ambas as fotos e uma lista com as coordenadas terreno dos PFs medidas
% no campo.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
clear all;
format long;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Dados para o projeto:

% Dados da camara Intergraph DMC
% Orientação Interna das Fotos 6 e 7

x0=0
y0=0
c = 120 %cm

% Distorção do Centro
sigma_c = 0.0001295

% Ajuste da Distância Focal c
c_adj = 0.119

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Informação sobre os pontos fotogramétricos e respetivas coordenadas foto
% Sistema de Coordenadas - ETRS89-PT/TM06

PFs_foto_6=[-1.026  68.670  %1000
            44.310  65.634  %2000
            2.526  -70.734  %3000
            41.166 -61.722  %4000
            -1.962	 7.386  %5000
            36.534	 0.642] %6000
        
Pf_terreno=[-90158.653	-100565.532	93.799  %1000
            -89794.832	-100478.941	89.069  %2000
            -89788.239	-101679.518	81.974  %3000
            -89514.366	-101489.343	123.038 %4000
            -90019.770	-101048.356	93.223  %5000
            -89696.832	-101008.761	95.277] %6000

% Para determinação da orientação externa da fotografia 6 são necessários
% no mínimo 3 PFs. Neste caso escolhemos 4 PFs de forma que exista alguma
% redundância no cálculo destes parâmetros.
% Na escolha destes PFs temos em atenção o facto de eles terem de ser não
% colineares e o mais afastados possível. 
% Após fazer um plot destes PFs num programa gráfico, os PFs escolhidos
% foram 1000, 2000, 3000, 4000.

PFs_foto=[-1.026   68.670  %1000
           44.310  65.634  %2000
           2.526  -70.734  %3000
           41.166 -61.722] %4000
       
PFs=[-90158.653	-100565.532	93.799   %1000
     -89794.832	-100478.941	89.069   %2000
     -89788.239	-101679.518	81.974   %3000
     -89514.366	-101489.343	123.038] %4000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%
% Orientação Externa da Foto 7
X0_7=-89710.750
Y0_7=-100990.128 
Z0_7= 1095.365
omega_7=0.1208
fi_7=0.2895
kappa_7=15.7612

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Valores iniciais estimados para a orientação externa da foto 6
% De forma a encontrar uma aproximação para o ponto central
 
% X0,Y0 obtidos através da intersecção dos cantos da foto 6 no Google Earth
% Z0 obtido por media das coordenadas Z dos PFs conhecidos
% Omega, Fi e Kappa da Orientação Externa da Foto 7

X0_6=-89949.4
Y0_6=-101095.74
Z0_6=1096.0633
omega0_6=0.1208 
fi0_6=0.2895 
kappa0_6=15.7612

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Determinação da Orientação Externa da Foto 6:
%% Intersecção Espacial Direta
% 
% 6 Incógnitas a determinar
% 4 PFs
% 8 Equações (2 por PF)

n_incognitas=6
n_equacoes=8
m=n_equacoes

% Usamos como pesos para o ajustamento uma matriz identidade com as
% dimensões de m
pesos=eye(m)

% Criamos um vetor delta onde serão guardados os ajustes aos parâmetros de
% orientação externa da foto 6. O critério de paragem será dependente dos
% erros definidos pela camara.

delta_6=[1;1;1;1;1;1]

while max(abs(delta_6))>c_adj || max(abs(delta_6))>sigma_c

%Matriz de Rotação (omega,fi,kappa)
Rot(1,1)=cosd(fi0_6)*cosd(kappa0_6)
Rot(1,2)=-cosd(fi0_6)*sind(kappa0_6)
Rot(1,3)=sind(fi0_6)
Rot(2,1)=cosd(omega0_6)*sind(kappa0_6)+sind(omega0_6)*sind(fi0_6)*cosd(kappa0_6)
Rot(2,2)=cosd(omega0_6)*cosd(kappa0_6)-sind(omega0_6)*sind(fi0_6)*sind(kappa0_6)
Rot(2,3)=-sind(omega0_6)*cosd(fi0_6)
Rot(3,1)=sind(omega0_6)*sind(kappa0_6)-cosd(omega0_6)*sind(fi0_6)*cosd(kappa0_6)
Rot(3,2)=sind(omega0_6)*cosd(kappa0_6)+cosd(omega0_6)*sind(fi0_6)*sind(kappa0_6)
Rot(3,3)=cosd(omega0_6)*cosd(fi0_6)

%Cálculos de Nx, Ny e D
for a=1:size(PFs,1)
   Nx(a)=Rot(1,1)*(PFs(a,1)-X0_6)+Rot(2,1)*(PFs(a,2)-Y0_6)+Rot(3,1)*(PFs(a,3)-Z0_6)
   Ny(a)=Rot(1,2)*(PFs(a,1)-X0_6)+Rot(2,2)*(PFs(a,2)-Y0_6)+Rot(3,2)*(PFs(a,3)-Z0_6)
   D(a)=Rot(1,3)*(PFs(a,1)-X0_6)+Rot(2,3)*(PFs(a,2)-Y0_6)+Rot(3,3)*(PFs(a,3)-Z0_6)
   x_inicial(a,1)=x0-(c*Nx(a)/D(a))
   y_inicial(a,1)=y0-(c*Ny(a)/D(a))
end


for n=1:size(PFs,1)
    
  % Cálculo das Derivadas da Matriz Jacobiana A
   % Em Vx
   A_p(2*n-1,1)=(-c/D(n)^2)*(Rot(1,3)*Nx(n)-Rot(1,1)*D(n))
   A_p(2*n-1,2)=(-c/D(n)^2)*(Rot(2,3)*Nx(n)-Rot(2,1)*D(n))
   A_p(2*n-1,3)=(-c/D(n)^2)*(Rot(3,3)*Nx(n)-Rot(3,1)*D(n))
   A_p(2*n-1,4)=(-c/D(n))*((((PFs(n,2)-Y0_6)*Rot(3,3)-(PFs(n,3)-Z0_6)*Rot(2,3))*Nx(n)/D(n))-((PFs(n,2)-Y0_6)*Rot(3,1)+(PFs(n,3)-Z0_6)*Rot(2,1)))
   A_p(2*n-1,5)=(c/D(n))*((Nx(n)*cosd(kappa0_6)-Ny(n)*sind(kappa0_6))*(Nx(n)/D(n))+D(n)*cosd(kappa0_6))
   A_p(2*n-1,6)=(-c/D(n))*Ny(n)
   
   
   %Vetor de obs
   l(2*n-1,1)=PFs_foto(n,1)-x_inicial(n,1)
   
   % Em Vy
   A_p(2*n,1)=(-c/D(n)^2)*(Rot(1,3)*Ny(n)-Rot(1,2)*D(n))
   A_p(2*n,2)=(-c/D(n)^2)*(Rot(2,3)*Ny(n)-Rot(2,2)*D(n))
   A_p(2*n,3)=(-c/D(n)^2)*(Rot(3,3)*Ny(n)-Rot(3,2)*D(n))
   A_p(2*n,4)=(-c/D(n))*((((PFs(n,2)-Y0_6)*Rot(3,3)-(PFs(n,3)-Z0_6)*Rot(2,3))*Ny(n)/D(n))-((PFs(n,2)-Y0_6)*Rot(3,2)+(PFs(n,3)-Z0_6)*Rot(2,2)))
   A_p(2*n,5)=(c/D(n))*((Nx(n)*cosd(kappa0_6)-Ny(n)*sind(kappa0_6))*(Ny(n)/D(n))-D(n)*sind(kappa0_6))
   A_p(2*n,6)=(c/D(n))*Nx(n)
 
 
   %Vetor de obs
   l(2*n,1)=PFs_foto(n,2)-y_inicial(n,1)
        
end
    
   % Aplicação do MMQ
   delta_6=inv(A_p'*pesos*A_p)*A_p'*pesos*l 
   % Correção aos Valores Iniciais
   X0_6=X0_6+delta_6(1)
   Y0_6=Y0_6+delta_6(2)
   Z0_6=Z0_6+delta_6(3)
   omega0_6=omega0_6+delta_6(4)
   fi0_6=fi0_6+delta_6(5)
   kappa0_6=kappa0_6+delta_6(6)

end

%Parâmetros da Orientação Externa da Foto 6
X0_6=X0_6
Y0_6=Y0_6
Z0_6=Z0_6
omega_6=omega0_6
fi_6=fi0_6
kappa_6=kappa0_6

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 2 : Cálculo de Coordenadas de Pontos Novos
%% Intersecção Espacial Direta

% Dados : Coordenadas Foto de 3 Pontos Novos
A_6=[38.898;-34.266]
B_6=[34.268;-47.658]
C_6=[41.986;-50.164]      

A_7=[4.866;-38.166]
B_7=[0.606;-51.966]
C_7=[8.490;-54.402]
      
%Matriz de Rotação (omega,fi,kappa) foto 6
R_6(1,1)=cosd(fi_6)*cosd(kappa_6)
R_6(1,2)=-cosd(fi_6)*sind(kappa_6)
R_6(1,3)=sind(fi_6)
R_6(2,1)=cosd(omega_6)*sind(kappa_6)+sind(omega_6)*sind(fi_6)*cosd(kappa_6)
R_6(2,2)=cosd(omega_6)*cosd(kappa_6)-sind(omega_6)*sind(fi_6)*sind(kappa_6)
R_6(2,3)=-sind(omega_6)*cosd(fi_6)
R_6(3,1)=sind(omega_6)*sind(kappa_6)-cosd(omega_6)*sind(fi_6)*cosd(kappa_6)
R_6(3,2)=sind(omega_6)*cosd(kappa_6)+cosd(omega_6)*sind(fi_6)*sind(kappa_6)
R_6(3,3)=cosd(omega_6)*cosd(fi_6)

%Matriz de Rotação (omega,fi,kappa) foto 7
R_7(1,1)=cosd(fi_7)*cosd(kappa_7)
R_7(1,2)=-cosd(fi_7)*sind(kappa_7)
R_7(1,3)=sind(fi_7)
R_7(2,1)=cosd(omega_7)*sind(kappa_7)+sind(omega_7)*sind(fi_7)*cosd(kappa_7)
R_7(2,2)=cosd(omega_7)*cosd(kappa_7)-sind(omega_7)*sind(fi_7)*sind(kappa_7)
R_7(2,3)=-sind(omega_7)*cosd(fi_7)
R_7(3,1)=sind(omega_7)*sind(kappa_7)-cosd(omega_7)*sind(fi_7)*cosd(kappa_7)
R_7(3,2)=sind(omega_7)*cosd(kappa_7)+cosd(omega_7)*sind(fi_7)*sind(kappa_7)
R_7(3,3)=cosd(omega_7)*cosd(fi_7)

% Cálculo de Kx, Ky, D
% Equações A
D6_A=(R_6(3,1)*(A_6(1)-x0)+R_6(3,2)*(A_6(2)-y0)-R_6(3,3)*c)
Kx6_A=(R_6(1,1)*(A_6(1)-x0)+R_6(1,2)*(A_6(2)-y0)-R_6(1,3)*c)/D6_A
Ky6_A=(R_6(2,1)*(A_6(1)-x0)+R_6(2,2)*(A_6(2)-y0)-R_6(2,3)*c)/D6_A

D7_A=(R_7(3,1)*(A_7(1)-x0)+R_7(3,2)*(A_7(2)-y0)-R_7(3,3)*c)
Kx7_A=(R_7(1,1)*(A_7(1)-x0)+R_7(1,2)*(A_7(2)-y0)-R_7(1,3)*c)/D7_A
Ky7_A=(R_7(2,1)*(A_7(1)-x0)+R_7(2,2)*(A_7(2)-y0)-R_7(2,3)*c)/D7_A

% Equações B
D6_B=(R_6(3,1)*(B_6(1)-x0)+R_6(3,2)*(B_6(2)-y0)-R_6(3,3)*c)
Kx6_B=(R_6(1,1)*(B_6(1)-x0)+R_6(1,2)*(B_6(2)-y0)-R_6(1,3)*c)/D6_B
Ky6_B=(R_6(2,1)*(B_6(1)-x0)+R_6(2,2)*(B_6(2)-y0)-R_6(2,3)*c)/D6_B

D7_B=(R_7(3,1)*(B_7(1)-x0)+R_7(3,2)*(B_7(2)-y0)-R_7(3,3)*c)
Kx7_B=(R_7(1,1)*(B_7(1)-x0)+R_7(1,2)*(B_7(2)-y0)-R_7(1,3)*c)/D7_B
Ky7_B=(R_7(2,1)*(B_7(1)-x0)+R_7(2,2)*(B_7(2)-y0)-R_7(2,3)*c)/D7_B

% Equações C
D6_C=(R_6(3,1)*(C_6(1)-x0)+R_6(3,2)*(C_6(2)-y0)-R_6(3,3)*c)
Kx6_C=(R_6(1,1)*(C_6(1)-x0)+R_6(1,2)*(C_6(2)-y0)-R_6(1,3)*c)/D6_C
Ky6_C=(R_6(2,1)*(C_6(1)-x0)+R_6(2,2)*(C_6(2)-y0)-R_6(2,3)*c)/D6_C

D7_C=(R_7(3,1)*(C_7(1)-x0)+R_7(3,2)*(C_7(2)-y0)-R_7(3,3)*c)
Kx7_C=(R_7(1,1)*(C_7(1)-x0)+R_7(1,2)*(C_7(2)-y0)-R_7(1,3)*c)/D7_C
Ky7_C=(R_7(2,1)*(C_7(1)-x0)+R_7(2,2)*(C_7(2)-y0)-R_7(2,3)*c)/D7_C


% Cálculo de Z
ZA=(X0_7-Z0_7*Kx7_A+Z0_6*Kx6_A-X0_6)/(Kx6_A-Kx7_A)
ZB=(X0_7-Z0_7*Kx7_B+Z0_6*Kx6_B-X0_6)/(Kx6_B-Kx7_B)
ZC=(X0_7-Z0_7*Kx7_C+Z0_6*Kx6_C-X0_6)/(Kx6_C-Kx7_C)

% Cálculo dos Valores de X e Y para cada Ponto em cada uma das Fotos
X6_A=X0_6+(ZA-Z0_6)*Kx6_A
Y6_A=Y0_6+(ZA-Z0_6)*Ky6_A
X7_A=X0_7+(ZA-Z0_7)*Kx7_A
Y7_A=Y0_7+(ZA-Z0_7)*Ky7_A

X6_B=X0_6+(ZB-Z0_6)*Kx6_B
Y6_B=Y0_6+(ZB-Z0_6)*Ky6_B
X7_B=X0_7+(ZB-Z0_7)*Kx7_B
Y7_B=Y0_7+(ZB-Z0_7)*Ky7_B

X6_C=X0_6+(ZC-Z0_6)*Kx6_C
Y6_C=Y0_6+(ZC-Z0_6)*Ky6_C
X7_C=X0_7+(ZC-Z0_7)*Kx7_C
Y7_C=Y0_7+(ZC-Z0_7)*Ky7_C

% Apos Cálculo das coordenadas dos pontos, é necessário fazer uma média
% das coordenadas obtidas para X e Y, calculadas a partir de cada uma das
% fotos.

P(1,1)=(X6_A+X7_A)/2
P(1,2)=(Y6_A+Y7_A)/2
P(1,3)=ZA
P(2,1)=(X6_B+X7_B)/2
P(2,2)=(Y6_B+Y7_B)/2
P(2,3)=ZB
P(3,1)=(X6_C+X7_C)/2
P(3,2)=(Y6_C+Y7_C)/2
P(3,3)=ZC

% Número de PNs
n_PN = 3
% Número de Equações (3 PNs x 2 Fotos x 2 Coordenadas)
n=12
% Peso à priori = 1
pesos=eye(n)

%Critério de Paragem (mm)
stop=0.001

% Criamos de novo um vetor delta onde serão guardados os ajustes
delta_p=[1;1;1;1;1;1;1;1;1]
% Contador de Iterações
it=0
while max(abs(delta_6))>stop || it < 50
    it=it+1
    %Ajustes às Coordenadas Foto e Terreno
 for a=1:size(P,1)
   Nx6(a)=R_6(1,1)*(P(a,1)-X0_6)+R_6(2,1)*(P(a,2)-Y0_6)+R_6(3,1)*(P(a,3)-Z0_6)
   Ny6(a)=R_6(1,2)*(P(a,1)-X0_6)+R_6(2,2)*(P(a,2)-Y0_6)+R_6(3,2)*(P(a,3)-Z0_6)
   D6(a)=R_6(1,3)*(P(a,1)-X0_6)+R_6(2,3)*(P(a,2)-Y0_6)+R_6(3,3)*(P(a,3)-Z0_6)
   x_inicial6(a)=x0-(c*Nx6(a)/D6(a))
   y_inicial6(a)=y0-(c*Ny6(a)/D6(a))
   Nx7(a)=R_7(1,1)*(P(a,1)-X0_7)+R_7(2,1)*(P(a,2)-Y0_7)+R_7(3,1)*(P(a,3)-Z0_7)
   Ny7(a)=R_7(1,2)*(P(a,1)-X0_7)+R_7(2,2)*(P(a,2)-Y0_7)+R_7(3,2)*(P(a,3)-Z0_7)
   D7(a)=R_7(1,3)*(P(a,1)-X0_7)+R_7(2,3)*(P(a,2)-Y0_7)+R_7(3,3)*(P(a,3)-Z0_7)
   x_inicial7(a)=x0-(c*Nx7(a)/D7(a))
   y_inicial7(a)=y0-(c*Ny7(a)/D7(a))
   
    %Determinação das Derivadas para a Matriz Jacobiana
   dxdX6(a)= -(c/(D6(a))^2)*(D6(a)*R_6(1,1) - Nx6(a)*R_6(1,3))        
   dxdY6(a)= -(c/(D6(a))^2)*(D6(a)*R_6(2,1) - Nx6(a)*R_6(2,3))     
   dxdZ6(a)= -(c/(D6(a))^2)*(D6(a)*R_6(3,1) - Nx6(a)*R_6(3,3))       
   dydX6(a)= -(c/(D6(a))^2)*(D6(a)*R_6(1,2) - Nx6(a)*R_6(1,3))         
   dydY6(a)= -(c/(D6(a))^2)*(D6(a)*R_6(2,2) - Nx6(a)*R_6(2,3))       
   dydZ6(a)= -(c/(D6(a))^2)*(D6(a)*R_6(3,2) - Nx6(a)*R_6(3,3))     
   dxdX7(a)= -(c/(D7(a))^2)*(D7(a)*R_7(1,1) - Nx7(a)*R_6(1,3))        
   dxdY7(a)= -(c/(D7(a))^2)*(D7(a)*R_7(2,1) - Nx7(a)*R_6(2,3))     
   dxdZ7(a)= -(c/(D7(a))^2)*(D7(a)*R_7(3,1) - Nx7(a)*R_6(3,3))       
   dydX7(a)= -(c/(D7(a))^2)*(D7(a)*R_7(1,2) - Nx7(a)*R_6(1,3))         
   dydY7(a)= -(c/(D7(a))^2)*(D7(a)*R_7(2,2) - Nx7(a)*R_6(2,3))    
   dydZ7(a)= -(c/(D7(a))^2)*(D7(a)*R_6(3,2) - Nx7(a)*R_6(3,3))
   
 end
    % Matriz Jacobiana A_p
   A_p=[dxdX6(1) dxdY6(1) dxdZ6(1) 0 0 0 0 0 0
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
       
  
  %Vetor de Diferenças de Observações
   l= [A_6(1)-x_inicial6(1)
       A_6(2)-y_inicial6(1)
       A_7(1)-x_inicial7(1)
       A_7(2)-y_inicial7(1)
       B_6(1)-x_inicial6(2)
       B_6(2)-y_inicial6(2)
       B_7(1)-x_inicial7(2)
       B_7(2)-y_inicial7(2)
       C_6(1)-x_inicial6(3)
       C_6(2)-y_inicial6(3)
       C_7(1)-x_inicial7(3)
       C_7(2)-y_inicial7(3)]

   delta_p=inv(A_p'*pesos*A_p)*(A_p'*pesos*l)
        
  %Correção às Coordenadas Terreno Iniciais
    P(1,1)=P(1,1)+delta_p(1)
    P(1,2)=P(1,2)+delta_p(2)
    P(1,3)=P(1,3)+delta_p(3)
    P(2,1)=P(2,1)+delta_p(4)
    P(2,2)=P(2,2)+delta_p(5)
    P(2,3)=P(2,3)+delta_p(6)
    P(3,1)=P(3,1)+delta_p(7)
    P(3,2)=P(3,2)+delta_p(8)
    P(3,3)=P(3,3)+delta_p(9) 
    it=it+1
end

Pf=P
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Resultados Finais

nome=char('Silvia Mourao, 57541');
data=datestr(now);

fid = fopen('P2_57541.txt','wt');

fprintf(fid,'**** Determinação de Coordenadas Terreno de Pontos Novos ***\n');
fprintf(fid,'%s\n',nome);
fprintf(fid,'%s\n\n',data);

fprintf(fid,'\n************* Coordenadas Terreno dos PFs ****************\n\n');
fprintf(fid,'PF1000: X: %9.3f    Y: %9.3f    Z: %9.3f \n\n',Pf_terreno(1,1), Pf_terreno(1,2), Pf_terreno(1,3));
fprintf(fid,'PF2000: X: %9.3f    Y: %9.3f    Z: %9.3f \n\n',Pf_terreno(2,1), Pf_terreno(2,2), Pf_terreno(2,3));
fprintf(fid,'PF3000: X: %9.3f    Y: %9.3f    Z: %9.3f \n\n',Pf_terreno(3,1), Pf_terreno(3,2), Pf_terreno(3,3));
fprintf(fid,'PF4000: X: %9.3f    Y: %9.3f    Z: %9.3f \n\n',Pf_terreno(4,1), Pf_terreno(4,2), Pf_terreno(4,3));
fprintf(fid,'PF5000: X: %9.3f    Y: %9.3f    Z: %9.3f \n\n',Pf_terreno(5,1), Pf_terreno(5,2), Pf_terreno(5,3));
fprintf(fid,'PF6000: X: %9.3f    Y: %9.3f    Z: %9.3f \n\n',Pf_terreno(6,1), Pf_terreno(6,2), Pf_terreno(6,3));

fprintf(fid,'\n*********** Coordenadas Foto dos PFs na foto 6 ***********\n\n');
fprintf(fid,'PF1:    X: %9.4f    Y: %9.4f \n\n',PFs_foto_6(1,1),PFs_foto_6(1,2));
fprintf(fid,'PF2:    X: %9.4f    Y: %9.4f \n\n',PFs_foto_6(2,1),PFs_foto_6(2,2));
fprintf(fid,'PF3:    X: %9.4f    Y: %9.4f \n\n',PFs_foto_6(3,1),PFs_foto_6(3,2));
fprintf(fid,'PF4:    X: %9.4f    Y: %9.4f \n\n',PFs_foto_6(4,1),PFs_foto_6(4,2));
fprintf(fid,'PF6:    X: %9.4f    Y: %9.4f \n\n',PFs_foto_6(5,1),PFs_foto_6(5,2));
fprintf(fid,'PF7:    X: %9.4f    Y: %9.4f \n\n',PFs_foto_6(6,1),PFs_foto_6(6,2));

fprintf(fid,'\n**** Parâmetros Iniciais de Orientação Externa Foto 6 ****\n\n');
fprintf(fid,'X0:   -89949.4 %9.3f \n\n');
fprintf (fid,'\n');
fprintf (fid,'\n');
fprintf(fid,'Y0:   -101095.74 %9.3f \n\n');
fprintf (fid,'\n');
fprintf (fid,'\n');
fprintf(fid,'Z0:    1096.0633  %9.3f \n\n');
fprintf (fid,'\n');
fprintf (fid,'\n');
fprintf(fid,'Omega: 0.1208   %9.4f º \n\n');
fprintf (fid,'\n');
fprintf (fid,'\n');
fprintf(fid,'Fi:    0.2895   %9.4f º \n\n');
fprintf (fid,'\n');
fprintf (fid,'\n');
fprintf(fid,'Kappa: 15.7612  %9.4f º \n\n');
fprintf (fid,'\n');
fprintf (fid,'\n');
fprintf (fid,'\n');
fprintf(fid,'\n************** Intersecção Inversa Espacial **************\n\n');

fprintf (fid,'************ Correções aos Parâmetros pelo MMQ ************\n');
fprintf (fid,'%10.7f\n',delta_6);
fprintf (fid,'\n');

fprintf(fid,'************** Valores Finais dos Parâmetros: **************\n\n');
fprintf(fid,'X0:    %9.3f \n\n',X0_6);
fprintf(fid,'Y0:    %9.3f \n\n',Y0_6);
fprintf(fid,'Z0:    %9.3f \n\n',Z0_6);
fprintf(fid,'Omega: %9.4f º\n\n',omega_6);
fprintf(fid,'Fi:    %9.4f º\n\n',fi_6);
fprintf(fid,'Kappa: %9.4f º\n\n',kappa_6);

fprintf(fid,'\n************** Intersecção Direta Espacial ***************\n\n');

fprintf(fid,'\n*********** Coordenadas foto dos PNs na foto 6 ***********\n\n');
fprintf(fid,'A: X: %9.4f     Y: %9.4f \n\n',A_6(1),A_6(2));
fprintf(fid,'B: X: %9.4f     Y: %9.4f \n\n',B_6(1),B_6(2));
fprintf(fid,'C: X: %9.4f     Y: %9.4f \n\n',C_6(1),C_6(2));

fprintf(fid,'\n*********** Coordenadas foto dos PNs na foto 7 ***********\n\n');
fprintf(fid,'A: X: %9.4f     Y: %9.4f \n\n',A_7(1),A_7(2));
fprintf(fid,'B: X: %9.4f     Y: %9.4f \n\n',B_7(1),B_7(2));
fprintf(fid,'C: X: %9.4f     Y: %9.4f \n\n',C_7(1),C_7(2));

fprintf(fid,'\n*********** Coordenadas Finais Terreno dos PNs ***********\n\n');
fprintf(fid,'A: X: %9.3f     Y: %9.3f     Z: %9.3f \n\n',Pf(1,1), Pf(1,2), Pf(1,3));
fprintf(fid,'B: X: %9.3f     Y: %9.3f     Z: %9.3f \n\n',Pf(2,1), Pf(2,2), Pf(2,3));
fprintf(fid,'C: X: %9.3f     Y: %9.3f     Z: %9.3f \n\n',Pf(3,1), Pf(3,2), Pf(3,3));
fclose(fid);

