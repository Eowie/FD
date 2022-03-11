
%%                      Programa  para  Fotogrametria  Analitica                    
%
%
% Dispõe-se de duas fotografias aéreas, F6 e F7, que formam um par estereoscópico.
% Nessas fotografias foram medidos vários pontos novos e alguns PFs. 
% Orientaçoes : 
% 1- A orientação externa da fotografia F6 é desconhecida.
% 2- A da fotografia F7 é conhecida
% Camera : Intergraph DMC
% *Aluno* : Gonçalo Mendes
% Numero Aluno: FC43253
% Unidade Curricular: Fotogrametria Digital

%% 
clear all;
format long;

%Dimensoes da Camara Fotogramétrica - Intergraph DMC
s1_dimensional=7680;
s2_dimensional=13824;
Pixel = 12*10^-6;
c = 0.12; %Distancia Focal (metros)
%Cálculo de dimensões de S1 e S2
s1 = s1_dimensional * Pixel;
s2 = s2_dimensional * Pixel;

%Pontos Fotogramétricos - PF XX ( x , y , z (metros) )
%Sistema de Coordenadas - UTM
% 1º PF---------

PF1 =[];
PF1(1) = -90158.653;
PF1(2) = -100565.532;
PF1(3) =  93.799;

% 2ª PF ----------
PF2 =[];
PF2(1) = -89794.832;
PF2(2) = -100478.941;
PF2(3) =  89.069;

% 3ª PF ----------
PF3 = [];
PF3(1) = -89788.239;
PF3(2) = -101679.518;
PF3(3) =  81.974;

% 4ª PF ----------
PF4 =[];
PF4(1) = -89514.366;
PF4(2) = -101489.343;
PF4(3) =  123.038;

% 5ª PF ----------
PF5 = [];
PF5(1) = -90019.770;
PF5(2) = -101048.356;
PF5(3) =  93.223;

% 6ª PF ----------
PF6 = [];
PF6(1) = -89696.832;
PF6(2) = -101008.761;
PF6(3) =  95.277;

normas_PF = []
normas_PF(1) = sqrt((PF1(1) - PF2(1))^2 + (PF1(2) - PF2(2))^2)
normas_PF(2) = sqrt((PF2(1) - PF3(1))^2 + (PF2(2) - PF3(2))^2)
normas_PF(3) = sqrt((PF3(1) - PF4(1))^2 + (PF3(2) - PF4(2))^2)
normas_PF(4) = sqrt((PF4(1) - PF5(1))^2 + (PF4(2) - PF5(2))^2)
% normas_PF(5) = sqrt((PF5(1) - PF6(1))^2 + (PF6(2) - PF6(2))^2)
% normas_PF(6) = sqrt((PF1(1) - PF3(1))^2 + (PF1(2) - PF3(2))^2)
% normas_PF(7) = sqrt((PF1(1) - PF4(1))^2 + (PF1(2) - PF4(2))^2)
% normas_PF(8) = sqrt((PF1(1) - PF5(1))^2 + (PF1(2) - PF5(2))^2)

%Lista dos Pontos Fotograméticos Medidos
Lista_PFs = [PF1;PF2;PF3;PF4;PF5;PF6]
Lista_X_PF = [PF1(1);PF2(1);PF3(1);PF4(1)]
Lista_Y_PF = [PF1(2);PF2(2);PF3(2);PF4(2)]
Lista_Z_PF = [PF1(3);PF2(3);PF3(3);PF4(3)]
% Coordenadas Foto dos PF's ( Foto 6 ) 
% 1º PF---------

PF1_Foto =[];
PF1_Foto(1) = -1.026;
PF1_Foto(2) = 68.670;


% 2ª PF ----------
PF2_Foto =[];
PF2_Foto(1) = 44.310;
PF2_Foto(2) = 65.634;


% 3ª PF ----------
PF3_Foto = [];
PF3_Foto(1) = 2.526;
PF3_Foto(2) = -70.734;


% 4ª PF ----------
PF4_Foto =[];
PF4_Foto(1) = 41.166;
PF4_Foto(2) = -61.722;


% 5ª PF ----------
PF5_Foto = [];
PF5_Foto(1) = -1.962;
PF5_Foto(2) = 7.386;


% 6ª PF ----------
PF6_Foto = [];
PF6_Foto(1) = 36.534;
PF6_Foto(2) = 0.642;


%Lista dos Pontos Fotos Fotograméticos Conhecidos (Foto 6)
Lista_PFs_Foto = [PF1_Foto;PF2_Foto;PF3_Foto;PF4_Foto;PF5_Foto;PF6_Foto]
Lista_x_PF_Foto = [PF1_Foto(1);PF2_Foto(1);PF3_Foto(1);PF4_Foto(1)]
Lista_y_PF_Foto = [PF1_Foto(2);PF2_Foto(2);PF3_Foto(2);PF4_Foto(2)]


%Primeira Fase: Calcular os PF's da Foto 7 e as devidas correções aos parâmetros de orientação
%Valores para a inicilização do ajustamento e determinação dos PF's na Foto 7
X_ini= -89710.750
Y_ini= -100990.128
Z_ini= 1095.365

%Angulos e Fatores de conversão angular
Fator_conv_rad = pi/180
Fator_conv_deg = 180/pi

Omega = 0.1208 * Fator_conv_rad
Fi = 0.2895   * Fator_conv_rad
Kapa = 15.7612 * Fator_conv_rad

%Vetor inicial dos parâmetros
L_ini=[X_ini;Y_ini;Z_ini;Omega;Fi;Kapa];

%Ajustamento Paramétrico Linear
%Nº de Obervações
n = length(Lista_PFs)

%Nº de incógnitas
u = length(L_ini)

%Numero minimo de obseevações 
n0 = 4

%Vetor de Termos independentes
Termos = [];
%Inicialização da matriz de configuração (Jacobiana)
A=[];

paragem_a = [1;1;1];
paragem_b = [1;1;1];
contador =1 ;
%Matrizes de Rotação ( R(omegafi,kapa) = R_Omega * R_Fi * R_Kapa )
%Slides 54 e 55 da Matéria Teórica
while (norm(paragem_a,inf) > 0.112) || (norm(paragem_b,inf) > 0.0001295) %Condição de paragem
    R_Omega = [ 1 0 0;
        cos(L_ini(4))+sin(L_ini(4)) cos(L_ini(4))-sin(L_ini(4)) -sin(L_ini(4));
        sin(L_ini(4)) - cos(L_ini(4)) sin(L_ini(4))+cos(L_ini(4)) cos(L_ini(4))]
    
    R_Fi = [cos(L_ini(5)) -cos(L_ini(5)) sin(L_ini(5));
        0           1          0;
        -sin(L_ini(5)) 0 cos(L_ini(5))]
    
    R_Kapa = [cos(L_ini(6)) -sin(L_ini(6)) 0;
        sin(L_ini(6)) cos(L_ini(6))  0;
        0                0           1]
    
    %Matriz de rotação
    R_RotOMega_Fi = R_Omega*R_Fi
    R_Rot = R_RotOMega_Fi * R_Kapa
    
    %...... Linearização das equações de colinearidade.......
    %Determinação dos parâmetros
    for i=1:n0
        % Nx representa o numerador do numerador da equação em x; (x = xo - c*(Nx/D))
        Nx =  R_Rot(1,1)*(Lista_X_PF(i)-L_ini(1))+R_Rot(2,1)*(Lista_Y_PF(i)-L_ini(2))+R_Rot(3,1)*(Lista_Z_PF(i)-L_ini(3));
        
        % Ny representa o numerador do numerador da equação em y; (y = yo - c*(Ny/D))
        Ny = R_Rot(1,2)*(Lista_X_PF(i)-L_ini(1))+R_Rot(2,2)*(Lista_Y_PF(i)-L_ini(2))+R_Rot(3,2)*(Lista_Z_PF(i)-L_ini(3));
        
        % D representa o denominador comum a ambas as equações
        D = R_Rot(1,3)*(Lista_X_PF(i)-L_ini(1))+R_Rot(2,3)*(Lista_Y_PF(i)-L_ini(2))+R_Rot(3,3)*(Lista_Z_PF(i)-L_ini(3));
        
        % Equações de colinearidade e a sua linearização
        X = L_ini(1) - (c*Nx/D)
        Y = L_ini(2) - (c*Ny/D)
        
        %Derivadas Parciais dos parametros de correção para implmentaçao da matriz de configuração
        %C
        dc_dp = []
        dx_dc = -Nx / D
        dy_dc = -Ny / D
        dc_dp(1) = dx_dc
        dc_dp(2) = dy_dc
        
        %Xo
        dXo =[]
        dx_dXo = -(c/D^2) * (R_Rot(1,3) * Nx-R_Rot(1,1) * D);
        dy_dXo = -(c/D^2) * (R_Rot(1,3) * Ny-R_Rot(1,2) * D);
        dXo(1) =  dx_dXo
        dXo(2) =  dy_dXo
        
        %Yo
        dYo = []
        dx_dY0 = -(c/D^2) * (R_Rot(2,3) * Nx-R_Rot(2,1)* D);
        dy_dY0 = -(c/D^2) * (R_Rot(2,3) * Ny-R_Rot(2,2)* D);
        dYo(1) = dx_dY0
        dYo(2) = dy_dY0
        
        %Zo
        dZo = []
        dx_dZ0 = -(c/D^2) * (R_Rot(3,3)* Nx-R_Rot(3,1)* D);
        dy_dZ0 = -(c/D^2) * (R_Rot(3,3) * Ny-R_Rot(3,2)* D);
        dZo(1) = dx_dZ0
        dZo(2) = dy_dZ0
        
        %Omega
        dOmega = []
        dx_dOmega = -(c/D) * (((Lista_Y_PF(i)-L_ini(2)) * R_Rot(3,3) - (Lista_Z_PF(i) - L_ini(3))* R_Rot(2,3)) * (Nx/D) - (Lista_Y_PF(i) - L_ini(2)) * R_Rot(3,1)+(Lista_Z_PF(i)- L_ini(3))* R_Rot(2,1));
        dy_dOmega = -(c/D) * (((Lista_Y_PF(i)-L_ini(2)) * R_Rot(3,3) - (Lista_Z_PF(i) - L_ini(3)) * R_Rot(2,3)) * (Ny/D)- (Lista_Y_PF(i) - L_ini(2)) * R_Rot(3,2)+(Lista_Z_PF(i)- L_ini(3))* R_Rot(2,2));
        dOmega(1) = dx_dOmega
        dOmega(2) = dy_dOmega
        
        %Fi
        dFi = [];
        dx_dFi = (c/D) * ((Nx * cos(L_ini(6))- Ny * sin(L_ini(6)) * (Nx/D) + D * cos(L_ini(6))));
        dy_dFi = (c/D) * ((Nx * cos(L_ini(6))- Ny * sin(L_ini(6)) * (Ny/D) - D * sin(L_ini(6))));
        dFi(1) = dx_dFi
        dFi(2) = dy_dFi
        
        %Kapa
        dKapa = []
        dx_dKapa = -(c/D) * Ny;
        dy_dKapa =  (c/D) * Nx;
        dKapa(1) = dx_dKapa
        dKapa(2) = dy_dKapa
        
        %Matriz de Confiuração - A
        A_jacob = [dXo(1) dYo(1) dZo(1) dOmega(1) dFi(1) dKapa(1);
             dXo(2) dYo(2) dZo(2) dOmega(2) dFi(2) dKapa(2)];
        A=[A;A_jacob];
        
        %Vector dos termos independentes
        
        T_Indp=[Lista_x_PF_Foto(i)-X;Lista_y_PF_Foto(i)-Y];
        % T_ind2= [Lista_y_PF_Foto(i)-Y];
        Termos=[Termos;T_Indp];
        %         Termos=[Termos;T_ind2];
        
        paragem = inv(A'*A)*A'*Termos %estes valores saem em metros
    
    end
  
    
    %Vector das correcções aos parâmetros a determinar
   
    paragem_a=[paragem(1);paragem(2);paragem(3)];
    paragem_b=[paragem(4);paragem(5);paragem(6)];
    
    Pl = L_ini + paragem;
    
    A1=A;
    l1=L_ini;
    
    A=[];
    l=[];
    
    contador=contador+1;
end
