
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
FatorMm = 10^-3

PF1_Foto =[];
PF1_Foto(1) = -1.026*FatorMm;
PF1_Foto(2) = 68.670*FatorMm;


% 2ª PF ----------
PF2_Foto =[];
PF2_Foto(1) = 44.310*FatorMm;
PF2_Foto(2) = 65.634*FatorMm;


% 3ª PF ----------
PF3_Foto = [];
PF3_Foto(1) = 2.526*FatorMm;
PF3_Foto(2) = -70.734*FatorMm;


% 4ª PF ----------
PF4_Foto =[];
PF4_Foto(1) = 41.166*FatorMm;
PF4_Foto(2) = -61.722*FatorMm;


% 5ª PF ----------
PF5_Foto = [];
PF5_Foto(1) = -1.962*FatorMm;
PF5_Foto(2) = 7.386*FatorMm;


% 6ª PF ----------
PF6_Foto = [];
PF6_Foto(1) = 36.534*FatorMm;
PF6_Foto(2) = 0.642*FatorMm;


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
d=1
paragem_a = [1;1;1];
paragem_b = [1;1;1];
contador =1 ;
%Matrizes de Rotação ( R(omegafi,kapa) = R_Omega * R_Fi * R_Kapa )
%Slides 54 e 55 da Matéria Teórica
while (norm(paragem_a,inf) > 0.119) || (norm(paragem_b,inf) > 0.0001295)  %Condição de paragem
        R_Omega = [ 1 0 0;
        0 cos(L_ini(4)) -sin(L_ini(4));
        0 sin(L_ini(4))  cos(L_ini(4))]
    
        R_Fi = [cos(L_ini(5)) 0 sin(L_ini(5));
        0           1          0;
        -sin(L_ini(5)) 0 cos(L_ini(5))]
    
        R_Kapa = [  cos(L_ini(6)) -sin(L_ini(6)) 0;
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
        X = 0 - (c*Nx/D)
        Y = 0 - (c*Ny/D)
        
        %Derivadas Parciais dos parametros de correção para implmentaçao da matriz de configuração
        %C
        dc_dp = []
        dx_dc = -Nx / D
        dy_dc = -Ny / D
        dc_dp(1) = dx_dc
        dc_dp(2) = dy_dc
        
        %Xo
        dXo =[]
        dx_dXo = -(c/D^2) * ((R_Rot(1,3) * Nx) - (R_Rot(1,1) * D));
        dy_dXo = -(c/D^2) * ((R_Rot(1,3) * Ny)-(R_Rot(1,2) * D));
        dXo(1) =  dx_dXo
        dXo(2) =  dy_dXo
        
        %Yo
        dYo = []
        dx_dY0 = -(c/D^2) * ((R_Rot(2,3) * Nx)-(R_Rot(2,1)* D));
        dy_dY0 = -(c/D^2) * ((R_Rot(2,3) * Ny)-(R_Rot(2,2)* D));
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
        dx_dOmega = -(c/D) * (((Lista_Y_PF(i)-L_ini(2)) * R_Rot(3,3) - (Lista_Z_PF(i) - L_ini(3))* R_Rot(2,3)) * (Nx/D) - ((Lista_Y_PF(i) - L_ini(2)) * R_Rot(3,1))+((Lista_Z_PF(i)- L_ini(3))* R_Rot(2,1)));
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
             dXo(2) dYo(2) dZo(2) dOmega(2) dFi(2) dKapa(2)]
        A = [A;A_jacob]
        
        %Vector dos termos independentes
        
        T_Indp = Lista_x_PF_Foto(i)-X;
        T_ind1 = Lista_y_PF_Foto(i)-Y;
        Termos=[Termos;T_Indp ; T_ind1]

        d=d+1
        
        
        
    end
    
%     Termos2 = Termos1'
    %Vector das correcções aos parâmetros a determinar
%     paragem = inv(A'*A)*A'*Termos1 %estes valores saem em metros
    paragem = inv(A'*A)
    Paragem1 = paragem * A'
    Paragem2 = Paragem1 * Termos
    paragem_a=[Paragem2(1);Paragem2(2);Paragem2(3)];
    paragem_b=[Paragem2(4);Paragem2(5);Paragem2(6)];
    
    L_ini = L_ini + Paragem2;
    
    A1=A;
    l1=Termos;
 
    A =[]
    Termos=[]
    contador=contador+1;
end


v = A1 * Paragem2-l1


%Parâmetros finais
Pf=L_ini;

% Elementos da matriz de rotação (omega fi kapa)
r11=cos(Pf(5))*cos(Pf(6));
r21=cos(Pf(4))*sin(Pf(6))+sin(Pf(4))*sin(Pf(5))*cos(Pf(6));
r31=sin(Pf(4))*sin(Pf(6))-cos(Pf(4))*sin(Pf(5))*cos(Pf(6));

r12=-cos(Pf(5))*sin(Pf(6));
r22=cos(Pf(4))*cos(Pf(6))-sin(Pf(4))*sin(Pf(5))*sin(Pf(6));
r32=sin(Pf(4))*cos(Pf(6))-cos(Pf(4))*sin(Pf(5))*sin(Pf(6));

r13=sin(Pf(5));
r23=-sin(Pf(4))*cos(Pf(5));
r33=cos(Pf(4))*cos(Pf(5));

coord_foto=[]; %Vector das coordenadas foto

%Vector das coordenadas terreno dos PFs
Lista_X_PF = [PF1(1);PF2(1);PF3(1);PF4(1); PF5(1);PF6(1)]
Lista_Y_PF = [PF1(2);PF2(2);PF3(2);PF4(2); PF5(2);PF6(2)]
Lista_Z_PF = [PF1(3);PF2(3);PF3(3);PF4(3); PF5(3);PF6(3)]

for i=1:n
% Elementos das equações de colinearidade

Nx1=r11*(Lista_X_PF(i)-Pf(1))+r21*(Lista_Y_PF(i)-Pf(2))+r31*(Lista_Z_PF(i)-Pf(3));

Ny1=r12*(Lista_X_PF(i)-Pf(1))+r22*(Lista_Y_PF(i)-Pf(2))+r32*(Lista_Z_PF(i)-Pf(3));

D1=r13*(Lista_X_PF(i)-Pf(1))+r23*(Lista_Y_PF(i)-Pf(2))+r33*(Lista_Z_PF(i)-Pf(3));


%Equações de colinearidade

x_coord=0-c*(Nx1/D1);

y_coord=0-c*(Ny1/D1);

%Vector das coordenadas foto
coord_foto_aux=[x_coord;y_coord];

coord_foto=[coord_foto;coord_foto_aux];


end
coord_foto =coord_foto*10^3

%%                      2ª Parte - Calculo de coordenadas Foto 7                    

Ori_7 = []

X_ini7= -89710.750
Y_ini7= -100990.128
Z_ini7= 1095.365

%Angulos e Fatores de conversão angular
Fator_conv_rad = pi/180
Fator_conv_deg = 180/pi

Omega7 = 0.1208 * Fator_conv_rad
Fi7 = 0.2895   * Fator_conv_rad
Kapa7 = 15.7612 * Fator_conv_rad

%Vetor inicial dos parâmetros
Ori_7=[X_ini7;Y_ini7;Z_ini7;Omega7;Fi7;Kapa7];

% Elementos da matriz de rotação (omega fi kapa)

%Matrizes de rotação
%Rotação Omega
Romw = [1 0 0; 0 cos(Ori_7(4)) -sin(Ori_7(4)); 0 sin(Ori_7(4)) cos(Ori_7(4))];
%Rotação Fi
RfI = [cos(Ori_7(5)) 0 sin(Ori_7(5)); 0 1 0; -sin(Ori_7(5)) 0 cos(Ori_7(5))];
%Rotação Kapa
RkA = [cos(Ori_7(6)) -sin(Ori_7(6)) 0; sin(Ori_7(6)) cos(Ori_7(6)) 0; 0 0 1];
%Matriz de rotação FOTO 7(omega fi kapa)
R_7 = Romw*RfI*RkA;


r11_7 = R_7(1,1)
r21_7 = R_7(2,1)
r31_7 = R_7(3,1)
r12_7 = R_7(1,2)
r22_7 = R_7(2,2)
r32_7 = R_7(3,2)
r13_7 = R_7(1,3)
r23_7 = R_7(2,3)
r33_7 = R_7(3,3)
% r11_7=cos(Ori_7(5))*cos(Ori_7(6));
% r21_7=cos(Ori_7(4))*sin(Ori_7(6))+sin(Ori_7(4))*sin(Ori_7(5))*cos(Ori_7(6));
% r31_7=sin(Ori_7(4))*sin(Ori_7(6))-cos(Ori_7(4))*sin(Ori_7(5))*cos(Ori_7(6));
% 
% r12_7=-cos(Ori_7(5))*sin(Ori_7(6));
% r22_7=cos(Ori_7(4))*cos(Ori_7(6))-sin(Ori_7(4))*sin(Ori_7(5))*sin(Ori_7(6));
% r32_7=sin(Ori_7(4))*cos(Ori_7(6))-cos(Ori_7(4))*sin(Ori_7(5))*sin(Ori_7(6));
% 
% r13_7=sin(Ori_7(5));
% r23_7=-sin(Ori_7(4))*cos(Ori_7(5));
% r33_7=cos(Ori_7(4))*cos(Ori_7(5));

coord_foto7=[]; %Vector das coordenadas foto

%Vector das coordenadas terreno dos PFs
Lista_X_PF = [PF1(1);PF2(1);PF3(1);PF4(1); PF5(1);PF6(1)]
Lista_Y_PF = [PF1(2);PF2(2);PF3(2);PF4(2); PF5(2);PF6(2)]
Lista_Z_PF = [PF1(3);PF2(3);PF3(3);PF4(3); PF5(3);PF6(3)]

for i=1:n
% Elementos das equações de colinearidade

Nx1_7=r11_7*(Lista_X_PF(i)-Ori_7(1))+r21_7*(Lista_Y_PF(i)-Ori_7(2))+r31_7*(Lista_Z_PF(i)-Ori_7(3));

Ny1_7=r12_7*(Lista_X_PF(i)-Ori_7(1))+r22_7*(Lista_Y_PF(i)-Ori_7(2))+r32_7*(Lista_Z_PF(i)-Ori_7(3));

D1_7=r13_7*(Lista_X_PF(i)-Ori_7(1))+r23_7*(Lista_Y_PF(i)-Ori_7(2))+r33_7*(Lista_Z_PF(i)-Ori_7(3));


%Equações de colinearidade

x_coord_7=0-c*(Nx1_7/D1_7);

y_coord_7=0-c*(Ny1_7/D1_7);

%Vector das coordenadas foto
coord_foto_aux7=[x_coord_7;y_coord_7];

coord_foto7=[coord_foto7;coord_foto_aux7];
end
coord_foto7 =coord_foto7*10^3

%%                      3ª Parte - Determinação de coordenadas Terreno A, B e C

Ax6 = 38.898
Bx6 = 34.268
Cx6 = 41.986

x_x06 = [Ax6 Bx6 Cx6]*10^-3

Ay6 = -34.266
By6 = -47.658 
Cy6 = -50.164

y_y06 = [Ay6 By6 Cy6]*10^-3

Ax7 = 4.866	
Bx7 = 0.606	
Cx7 = 8.490

x_x07 = [Ax7 Bx7 Cx7]*10^-3

Ay7 = -38.166	
By7 = -51.966	
Cy7 = -54.402	

y_y07 = [Ay7 By7 Cy7]*10^-3


Xo7 = X_ini7
Xo6 = L_ini(1)
Yo6 = L_ini(2)
Yo7 = Y_ini7
Zo6 = L_ini(3)
Zo7 = Z_ini7

k_6x = []
k_6y = []
k_7x = []
k_7y = []

k_6xf = []
k_6yf = []
k_7xf = []
k_7yf = []

Z = []
Zf = []

for i=1:1:3
    k_6x = (r11*(x_x06(i))+  r12*(y_y06(i)) - r13*c)/ (r31*(x_x06(i)) + r32*(y_y06(i)) - r33*c)
    k_6xf =[k_6xf;k_6x]
    
    k_6y = (r21*(x_x06(i))+  r22*(y_y06(i)) - r23*c)/ (r31*(x_x06(i)) + r32*(y_y06(i)) - r33*c)
    k_6yf=[k_6yf;k_6y]
    

    k_7x = (r11_7*(x_x07(i))+  r12_7*(y_y07(i)) - r13_7*c)/ (r31_7*(x_x07(i)) + r32_7*(y_y07(i)) - r33_7*c)
    k_7xf=[k_7xf;k_7x]
    
    k_7y = (r21_7*(x_x07(i))+  r22_7*(y_y07(i)) - r23_7*c)/ (r31_7*(x_x07(i)) + r32_7*(y_y07(i)) - r33_7*c)
    k_7yf=[k_7yf;k_7y]
    
    Z =  (Xo7 - Zo7* k_7x + Zo6 * k_6x - Xo6) / (k_6x-k_7x)
    Zf = [Zf;Z]
    

end



XA1 =  Xo6 + (Zf(1)-Zo6) * k_6xf(1);
XA2 =  Xo7 + (Zf(1)-Zo7) * k_7xf(1);

YA1 =  Yo6 + (Zf(1)-Zo6) * k_6yf(1);
YA2 =  Yo7 + (Zf(1)-Zo7) * k_7yf(1);

MediaX_A = (XA1 + XA2)/2
MediaY_A = (YA1 + YA2)/2



XB1 =  Xo6 + (Zf(2)-Zo6) * k_6xf(2);
XB2 =  Xo7 + (Zf(2)-Zo7) * k_7xf(2);

YB1 =  Yo6 + (Zf(2)-Zo6) * k_6yf(2);
YB2 =  Yo7 + (Zf(2)-Zo7) * k_7yf(2);

MediaX_B = (XB1 + XB2)/2
MediaY_B = (YB1 + YB2)/2


XC1 =  Xo6 + (Zf(3)-Zo6) * k_6xf(3);
XC2 =  Xo7 + (Zf(3)-Zo7) * k_7xf(3);

YC1 =  Yo6 + (Zf(3)-Zo6) * k_6yf(3);
YC2 =  Yo7 + (Zf(3)-Zo7) * k_7yf(3);

MediaX_C = (XC1 + XC2)/2
MediaY_C = (YC1 + YC2)/2


XLista6 = [XA1 ; XB1 ; XC1]
XLista7 = [XA2 ; XB2 ; XC2]
YLista6 = [YA1 ; YB1 ; YC1]
YLista7 = [YA2 ; YB2;  YC2]

MediaX = [MediaX_A ; MediaX_B ; MediaX_C]
MediaY = [MediaY_A ;  MediaY_B ; MediaY_C]
MediaXY = [MediaX;MediaY]
n = 12
n0 = 2
A_jacob6 = []
A_conf6=[]
A_jacob7 =[]
A_conf7=[]
TermosOriten6 =[]
TermosOriten7=[]
conta =1
tota = 1
Media = []
Delta1 =  [1; 1; 1;1; 1; 1;1; 1; 1]
paragem_7 =  [1; 1; 1]
% for h =1:1:3
%     L_inicial6 = [XLista6(h); YLista6(h) ; Zf(h)]
%     L_inicial7 = [XLista7(h); YLista7(h) ; Zf(h)]
% end
L_inicial6 =[]
L_inicial6 = [L_inicial6; MediaX(1); MediaY(1); Zf(1);MediaX(2); MediaY(2); Zf(2);MediaX(3); MediaY(3); Zf(3)]
L_ = [MediaX_A ; MediaY_A ;Zf(1); MediaX_B; MediaY_B;Zf(2);MediaX_C;MediaY_C;Zf(3)] 
A_conf6 = []
A_conf62 = []
A_conf63 = []
Atotal = []
Temo_Inde = []
A = zeros(12,9)
while norm(Delta1,inf) > 0.119 & tota <50%Condição de paragem
    for i= 1:1:3
        
        % Nx representa o numerador do numerador da equação em x; (x = xo - c*(Nx/D))
        Nx1 =  R_Rot(1,1)*(MediaX(i)-Pf(1))+R_Rot(2,1)*(MediaY(i)-Pf(2))+R_Rot(3,1)*(Zf(i)-Pf(3));
        
        % Ny representa o numerador do numerador da equação em y; (y = yo - c*(Ny/D))
        Ny1 = R_Rot(1,2)*(MediaX(i)-Pf(1))+R_Rot(2,2)*(MediaY(i)-Pf(2))+R_Rot(3,2)*(Zf(i)-Pf(3));
        
        % D representa o denominador comum a ambas as equações
        D1 = R_Rot(1,3)*(MediaX(i)-Pf(1))+R_Rot(2,3)*(MediaY(i)-Pf(2))+R_Rot(3,3)*(Zf(i)-Pf(3));
        
        % Equações de colinearidade e a sua linearização
        x_coord6 = 0 - (c*Nx1/D1)
        y_coord6 = 0 - (c*Ny1/D1) 
        % Elementos das equações de colinearidade
        
        Nx1_7=r11_7*(MediaX(i)-Ori_7(1))+(r21_7)*(MediaY(i)-Ori_7(2))+r31_7*(Zf(i)-Ori_7(3));
        Ny1_7=r12_7*(MediaX(i)-Ori_7(1))+r22_7*(MediaY(i)-Ori_7(2))+r32_7*(Zf(i)-Ori_7(3)); 
        D1_7=r13_7*(MediaX(i)-Ori_7(1))+r23_7*(MediaY(i)-Ori_7(2))+r33_7*(Zf(i)-Ori_7(3));
        
        
        %Equações de colinearidade
        x_coord7=0-c*(Nx1_7/D1_7);
        y_coord7=0-c*(Ny1_7/D1_7);
        
        %Vector das coordenadas foto
        coord_foto_aux7=[x_coord_7;y_coord_7];
        coord_foto7=[coord_foto7;coord_foto_aux7];

        %Derivadas Parciais DX DY sobre Orientação Foto 6
        
        dpx_dx6 = (-c/(D1^2))*((D1*r11)-(Nx1*r13))
        dpx_dy6 = (-c/(D1^2))*((D1*r21)-(Nx1*r23))
        dpx_dz6 = (-c/(D1^2))*((D1*r31)-(Nx1*r33))
        dpy_dx6 = (-c/(D1^2))*((D1*r12)-(Ny1*r13))
        dpy_dy6 = (-c/(D1^2))*((D1*r22)-(Ny1*r23))
        dpy_dz6 = (-c/(D1^2))*((D1*r32)-(Ny1*r33))
        
        
        %Derivadas Parciais DX DY sobre Orientação Foto 7
        dpx_dx7 = (-c/(D1_7^2))*((D1_7*r11_7)-(Nx1_7*r13_7))
        dpx_dy7 = (-c/(D1_7^2))*((D1_7*r21_7)-(Nx1_7*r23_7))
        dpx_dz7 = (-c/(D1_7^2))*((D1_7*r31_7)-(Nx1_7*r33_7))
        dpy_dx7 = (-c/(D1_7^2))*((D1_7*r12_7)-(Ny1_7*r13_7))
        dpy_dy7 = (-c/(D1_7^2))*((D1_7*r22_7)-(Ny1_7*r23_7))
        dpy_dz7 = (-c/(D1_7^2))*((D1_7*r32_7)-(Ny1_7*r33_7))
        
        A_jacob6 = [dpx_dx6 dpx_dy6 dpx_dz6 dpy_dx6 dpy_dy6 dpy_dz6];
        A_jacob7=[ dpx_dx7 dpx_dy7 dpx_dz7 dpy_dx7 dpy_dy7 dpy_dz7];
        
        
        if i == 1
            
            %         A_conf6_1=[A_conf6_1;A_jacob67]
            A_conf6_1=[A_conf6;A_jacob6]
            A_conf7_1=[A_conf7;A_jacob7]
            A(1,1)= A_conf6_1(1)
            A(1,2)= A_conf6_1(2)
            A(1,3)= A_conf6_1(3)
            A(2,1)= A_conf6_1(4)
            A(2,2)= A_conf6_1(5)
            A(2,3)= A_conf6_1(6)
            A(3,1)= A_conf7_1(1)
            A(3,2)= A_conf7_1(2)
            A(3,3)= A_conf7_1(3)
            A(4,1)= A_conf7_1(4)
            A(4,2)= A_conf7_1(5)
            A(4,3)= A_conf7_1(6)
        elseif i ==2
            
            A_conf6_2=[A_conf6;A_jacob6]
            A_conf7_2=[A_conf7;A_jacob7]
            A(5,4)= A_conf6_2(1)
            A(5,5)= A_conf6_2(2)
            A(5,6)= A_conf6_2(3)
            A(6,4)= A_conf6_2(4)
            A(6,5)= A_conf6_2(5)
            A(6,6)= A_conf6_2(6)
            A(7,4)= A_conf7_2(1)
            A(7,5)= A_conf7_2(2)
            A(7,6)= A_conf7_2(3)
            A(8,4)= A_conf7_2(4)
            A(8,5)= A_conf7_2(5)
            A(8,6)= A_conf7_2(6)
            
        elseif i ==3
            
            A_conf6_3=[A_conf6;A_jacob6]
            A_conf7_3=[A_conf7;A_jacob7]
            % matriz A
            A(9,7)= A_conf6_3(1)
            A(9,8)= A_conf6_3(2)
            A(9,9)= A_conf6_3(3)
            A(10,7)= A_conf6_3(4)
            A(10,8)= A_conf6_3(5)
            A(10,9)= A_conf6_3(6)
            A(11,7)= A_conf7_3(1)
            A(11,8)= A_conf7_3(2)
            A(11,9)= A_conf7_3(3)
            A(12,7)= A_conf7_3(4)
            A(12,8)= A_conf7_3(5)
            A(12,9)= A_conf7_3(6)
            
            
        end
    
    

       
        T_Indp_6x = x_x06(i)-x_coord6;
        T_ind1_6y = y_y06(i)-y_coord6;
%         TermosOriten6=[TermosOriten6;T_Indp_6x ; T_ind1_6y]
 
        
        T_Indp_7x = x_x07(i)-x_coord7;
        T_ind1_7y = y_y07(i)-y_coord7;
%         TermosOriten7=[TermosOriten7;T_Indp_7x ; T_ind1_7y]
        
        
        
        Temo_Inde = [Temo_Inde; T_Indp_6x; T_ind1_6y;T_Indp_7x;T_ind1_7y]
        conta = conta + 1
        
%         
%         
    end
    Delta1 = inv(A'*A)* A' * Temo_Inde
     
    L_ = L_ + Delta1 
    
        
    A1=A;
    l1=Temo_Inde;
 
    A =[]
    Temo_Inde=[]
    VERIF = [L_inicial6(1),L_inicial6(2),L_inicial6(3);
            L_inicial6(4),L_inicial6(5),L_inicial6(6);
            L_inicial6(7),L_inicial6(8),L_inicial6(9)]
%     
%     
%     
%     
%     
%     
% %     MediaXA = ( L_inicial6(1)+L_inicial7(1) ) / 2
% %     MediaYA = ( L_inicial6(2)+L_inicial7(2) ) / 2
% %     MediaXB = ( L_inicial6(3)+L_inicial7(3) ) / 2
% %     MediaYB = ( L_inicial6(4)+L_inicial7(4) ) / 2
% %     MediaXC = ( L_inicial6(5)+L_inicial7(5) ) / 2
% %     MediaYC = ( L_inicial6(6)+L_inicial7(6) ) / 2
%     
%     conta = conta +1
tota = tota +1
 end


% Pontos = []
% Pontos = [Pontos; MediaXA MediaYA; MediaXB MediaYB; MediaXC MediaYC]
