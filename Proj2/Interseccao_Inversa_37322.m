%{
                      Fotogrametria Analítica

    Determinação da orientação externa de uma foto por intersecção inversa
         espacial expressa por funções trigonométricas
            
                    Sofia Henriques, n.º 37322
                     14 de Dezembro de 2012
%}

echo off 
clear all
close all
clc
format long G

%% Coordenadas Terreno dos PFs (ERTS89-PT-TM06) [m]:

%PF1 - Nome original PF2-2011
X1=-90222.174;
Y1=-100513.617;
Z1=94.806;

%PF2 - Nome original PF1-2011
X2=-90216.249;
Y2=-100513.413;
Z2=94.756;

%PF3 - Nome original PF2-2012
X3=-89935.314;
Y3=-100539.978;
Z3=91.972;

%PF4 - Nome original PF1-2012
X4=-89947.481;
Y4=-100521.651;
Z4=92.271;

%PF6 - Nome original PF101-2012
X6=-89552.726;
Y6=-101521.817;
Z6=101.545;

%PF7 - Nome original PF12-2010
X7=-89718.597;
Y7=-101340.159;
Z7=94.246;

%PF8 - Nome original PF1-2010
X8=-89804.410;
Y8=-100336.681;
Z8=95.489;

%PF10 - Nome original PF1-2010
X10=-89257.260;
Y10=-101399.855;
Z10=100.926;

%% Informações sobre a obtenção da foto

% A imagem foi obtida sobre a Cidade Universitária de Lisboa por uma câmara
% digital DMC e tem um GSD de 10cm aproximadamente.

%A foto em questão é a foto 7 do bloco das aulas práticas

%Características da câmara DMC
c=0.120; % [m]
pixel=(12*10^-6);
s1=7680*pixel;
s2=13824*pixel;
x0=0;
y0=0;
GDS=0.10; %[m]

%Cálculo do módulo da escala da foto
mf=GDS/pixel; %[m]

%Cálculo da altura de voo
h=c*mf; %[m]

%% Coordenadas foto dos PFs [mm]:

%PF1
x1=-42.8580;
y1=70.9140;

%PF2
x2=-42.1800;
y2=70.7400;

%PF3
x3=-11.5260;
y3=60.9820;

%PF4
x4=-10.7268;
y4=58.5468;

%PF6
x6=1.4460;
y6=-67.5660;

%PF7
x7=-11.8020;
y7=-40.6054;

%PF8
x8=10.9320;
y8=77.8980;

%PF10
x10=39.858;
y10=-63.114;

%% DETERMINAÇÃO DA ORIENTAÇÃO EXTERNA DE UMA FOTO POR INTERSECÇÃO INVERSA
%% ESPACIAL POR FUNÇÕES TRIGONOMÉTRICAS

%Valores iniciais aproximados dos parâmetros de orientação externa:

X0=-89705.300;
Y0=-101025.100;
Z0=h;
omega=0*(pi/180);
fi=0*(pi/180);
kapa=((pi/2)-67.71*(pi/180));

%Vector com os valores iniciais dos parâmetros
P=[X0;Y0;Z0;omega;fi;kapa];

%-------------- Ajustamento pelo Método dos Mínimos Quadrados --------------%

%Número total de observações
n=8;

%Parâmetros
u=6; %desconhecidos

%Número mínimo de observações
n0=4;

%Número de graus de liberdade
df=n-n0;

%Variância a priori
sigma0_2 = 1;

%Vectores das coordenadas X,Y e Z dos PFs a utilizar no ajustamento
X=[X1;X8;X6;X10];
Y=[Y1;Y8;Y6;Y10];
Z=[Z1;Z8;Z6;Z10];

%Vector coordenadas foto dos PFs a utilizar no ajustamento
x=[x1;x8;x6;x10]*10^-3; %[m]
y=[y1;y8;y6;y10]*10^-3; %[m]

delta_c=[1;1;1];
delta_a=[1;1;1];

A=[]; %Matriz de configuração
l=[]; %Vector dos termos independentes

s=1; %Contador de iterações
%pag 10 certificado da cam
while (norm(delta_c,inf) > 0.1) || (norm(delta_a,inf) > 0.0001) %Condição de paragem
    
    %Matrizes de rotação
    
    %Rotação Omega
    Rw=[1 0 0;
        0 cos(P(4)) -sin(P(4));
        0 sin(P(4)) cos(P(4))];
    
    %Rotação Fi
    Rf=[cos(P(5)) 0 sin(P(5));
        0 1 0;
        -sin(P(5)) 0 cos(P(5))];
    
    %Rotação Kapa
    Rk=[cos(P(6)) -sin(P(6)) 0;
        sin(P(6)) cos(P(6)) 0;
        0 0 1];
    
    %Matriz de rotação (omega fi kapa)
    R=Rw*Rf*Rk;
    
    for i=1:n0
        % Elementos das equações de colinearidade
        
        Nx= R(1,1)*(X(i)-P(1))+R(2,1)*(Y(i)-P(2))+R(3,1)*(Z(i)-P(3));
        
        Ny= R(1,2)*(X(i)-P(1))+R(2,2)*(Y(i)-P(2))+R(3,2)*(Z(i)-P(3));
        
        D= R(1,3)*(X(i)-P(1))+R(2,3)*(Y(i)-P(2))+R(3,3)*(Z(i)-P(3));
        
        %Equações de colinearidade
        x_ecol=x0-c*(Nx/D);
        
        y_ecol=y0-c*(Ny/D);
        
        %Expressões das derivadas parciais que entram nas equações linearizadas das
        %equações de colinearidade
        
        dpx_dpX0 = -(c/D^2)*(R(1,3)*Nx-R(1,1)*D);
        dpy_dpX0 = -(c/D^2)*(R(1,3)*Ny-R(1,2)*D);
        
        dpx_dpY0 = -(c/D^2)*(R(2,3)*Nx-R(2,1)*D);
        dpy_dpY0 = -(c/D^2)*(R(2,3)*Ny-R(2,2)*D);
        
        dpx_dpZ0 = -(c/D^2)*(R(3,3)*Nx-R(3,1)*D);
        dpy_dpZ0 = -(c/D^2)*(R(3,3)*Ny-R(3,2)*D);
        
        dpx_dpomega = -(c/D)*( ( (Y(i)-P(2))*R(3,3)-(Z(i)-P(3))*R(2,3) )*(Nx/D)-(Y(i)-P(2))*R(3,1)+(Z(i)-P(3))*R(2,1) );
        dpy_dpomega = -(c/D)*( ( (Y(i)-P(2))*R(3,3)-(Z(i)-P(3))*R(2,3) )*(Ny/D)-(Y(i)-P(2))*R(3,2)+(Z(i)-P(3))*R(2,2) );
        
        dpx_dpfi = (c/D)*( ( Nx*cos(P(6))-Ny*sin(P(6)) )*(Nx/D)+D*cos(P(6)) );
        dpy_dpfi = (c/D)*( ( Nx*cos(P(6))-Ny*sin(P(6)) )*(Ny/D)-D*sin(P(6)) );
        
        dpx_dpkapa = -(c/D)*Ny;
        dpy_dpkapa =  (c/D)*Nx;
        
        %Matriz de configuração (coeficientes dos parâmetros)
        
        A_Aux=[dpx_dpX0 dpx_dpY0 dpx_dpZ0 dpx_dpomega dpx_dpfi dpx_dpkapa;
            dpy_dpX0 dpy_dpY0 dpy_dpZ0 dpy_dpomega dpy_dpfi dpy_dpkapa];
        
        A=[A;A_Aux];
        
        
        %Equações linearizadas das equações de colinearidade
        
        % vx =dx0+ (dpx/dpc)*dc (dpx/dpf)*df + (dpx/dpw)*dw + (dpx/dpk)*dk + ...
        %     (dpx/dpX0)*dX0 + (dpx/dpY0)*dY0 + (dpx/dpZ0)*dZ0 + (x-xm);
        %
        % vy =dy0+ (dpy/dpc)*dc (dpy/dpf)*df + (dpy/dpw)*dw + (dpy/dpk)*dk + ...
        %     (dpy/dpX0)*dX0 + (dpy/dpY0)*dY0 + (dpy/dpZ0)*dZ0 + (y-ym);
        
        
        %Vector dos termos independentes
        l_aux=[x(i)-x_ecol;y(i)-y_ecol];
        l=[l;l_aux];
        
    end
    
    %Vector das correcções aos parâmetros a determinar
	%meter os pesos
    delta = inv(A'*A)*A'*l; %estes valores saem em metros
    
    delta_c=[delta(1);delta(2);delta(3)];
    delta_a=[delta(4);delta(5);delta(6)];
    
    P = P + delta;
    
    A1=A;
    l1=l;
    
    A=[];
    l=[];
    
    s=s+1;
end

%Vector das correcções às coordenadas
v=A1*delta-l1; %estes valores saem em metros

%% Verificação dos resultados [calculando os valores das coordenadas fotos
%% e comparando com os dados do enunciado]

%Parâmetros finais
Pf=P;

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
Xt=[X1;X2;X3;X4;X6;X7;X8;X10];
Yt=[Y1;Y2;Y3;Y4;Y6;Y7;Y8;Y10];
Zt=[Z1;Z2;Z3;Z4;Z6;Z7;Z8;Z10];

for i=1:n
% Elementos das equações de colinearidade

Nx=r11*(Xt(i)-Pf(1))+r21*(Yt(i)-Pf(2))+r31*(Zt(i)-Pf(3));

Ny=r12*(Xt(i)-Pf(1))+r22*(Yt(i)-Pf(2))+r32*(Zt(i)-Pf(3));

D=r13*(Xt(i)-Pf(1))+r23*(Yt(i)-Pf(2))+r33*(Zt(i)-Pf(3));


%Equações de colinearidade

x_coord=x0-c*(Nx/D);

y_coord=y0-c*(Ny/D);

%Vector das coordenadas foto
coord_foto_aux=[x_coord;y_coord];

coord_foto=[coord_foto;coord_foto_aux];

end

%% Armazenamento dos dados

nome=char('Sofia Paulino Henriques, nr. 37322');
data=datestr(now);

fid = fopen('Intersecção Inversa.txt','wt');

fprintf(fid,'** DETERMINAÇÃO DA ORIENTAÇÃO EXTERNA DE UMA FOTO POR INTERSECÇÃO INVERSA\n');
fprintf(fid,'EXPRESSA POR FUNÇÕES TRIGONOMÉTRICAS **\n\n');
fprintf(fid,'Projecto executado por: %s\n',nome);
fprintf(fid,'Data de execução:       %s\n\n',data);


fprintf(fid,'\n********************** CARACTERÍSTICAS DA CÂMARA ********************\n\n');
fprintf(fid,'Câmara fotográfica: DMC \n\n');
fprintf(fid,'Constante da câmara (c):  %5.3f m\n\n',c);
fprintf(fid,'Parâmetros da orientação interna da fotografia: \n');
fprintf(fid,'     x0: %5.2f m      y0: %5.2fm\n\n',x0,y0); 

fprintf(fid,'\n****************** INFORMAÇÕES ADICIONAIS *******************\n\n');
fprintf(fid,' Escala da Foto (1/mf): 1/%5.0f\n\n',mf);
fprintf(fid,' Altura de voo (h):  %5.2fm\n\n',h);

fprintf(fid,'\n************* COORDENADAS TERRENO DOS PFs ****************\n\n');
fprintf(fid,'  PF1:   X: %9.3f m      Y: %9.3f m      Z: %9.3f m\n\n',X1,Y1,Z1);
fprintf(fid,'  PF2:   X: %9.3f m      Y: %9.3f m      Z: %9.3f m\n\n',X2,Y2,Z2);
fprintf(fid,'  PF3:   X: %9.3f m      Y: %9.3f m      Z: %9.3f m\n\n',X3,Y3,Z3);
fprintf(fid,'  PF4:   X: %9.3f m      Y: %9.3f m      Z: %9.3f m\n\n',X4,Y4,Z4);
fprintf(fid,'  PF6:   X: %9.3f m      Y: %9.3f m      Z: %9.3f m\n\n',X6,Y6,Z6);
fprintf(fid,'  PF7:   X: %9.3f m      Y: %9.3f m      Z: %9.3f m\n\n',X7,Y7,Z7);
fprintf(fid,'  PF8:   X: %9.3f m      Y: %9.3f m      Z: %9.3f m\n\n',X8,Y8,Z8);
fprintf(fid,'  PF10:  X: %9.3f m      Y: %9.3f m      Z: %9.3f m\n\n',X10,Y10,Z10);

fprintf(fid,'\n************* COORDENADAS FOTO DOS PFs ****************\n\n');
fprintf(fid,'  PF1:   X: %9.4f mm      Y: %9.4f mm\n\n',x1,y1);
fprintf(fid,'  PF2:   X: %9.4f mm      Y: %9.4f mm\n\n',x2,y2);
fprintf(fid,'  PF3:   X: %9.4f mm      Y: %9.4f mm\n\n',x3,y3);
fprintf(fid,'  PF4:   X: %9.4f mm      Y: %9.4f mm\n\n',x4,y4);
fprintf(fid,'  PF6:   X: %9.4f mm      Y: %9.4f mm\n\n',x6,y6);
fprintf(fid,'  PF7:   X: %9.4f mm      Y: %9.4f mm\n\n',x7,y7);
fprintf(fid,'  PF8:   X: %9.4f mm      Y: %9.4f mm\n\n',x8,y8);
fprintf(fid,'  PF10:  X: %9.4f mm      Y: %9.4f mm\n\n',x10,y10);

fprintf(fid,'\n*** VALORES INICIAIS APROXIMADOS ***\n\n');
fprintf(fid,'  X0:  %9.3f m\n\n',X0);
fprintf(fid,'  Y0: %9.3f m\n\n',Y0);
fprintf(fid,'  Z0:   %9.3f m\n\n',Z0);
fprintf(fid,'  Omega:%9.4f º\n\n',rad2deg(omega));
fprintf(fid,'  Fi:   %9.4f º\n\n',rad2deg(fi));
fprintf(fid,'  Kapa: %9.4f º\n\n',rad2deg(kapa));

fprintf(fid,'\n**** DETERMINAÇÃO DOS PARÂMETROS DE ORIENTAÇÃO EXTERNA DE UMA FOTO ******\n\n');

fprintf(fid,' As coordenadas foto utilizadas no ajustamento pelo método dos mínimos quadrados são as do PF1, PF6, PF8 e PF10.\n\n');

fprintf (fid, 'Vector dos termos independentes =\n');
fprintf (fid,'%10.7f\n',l1);
fprintf (fid,'\n');

fprintf (fid, 'Vector das correcções aos parâmetros a determinar =\n');
fprintf (fid,'%10.7f\n',delta);
fprintf (fid,'\n');

fprintf (fid, 'Vector das correcções às coordenadas =\n');
fprintf (fid,'%10.7f\n',v);
fprintf (fid,'\n');

fprintf(fid,'Valores finais dos parâmetros:\n\n');
fprintf(fid,'  X0:  %9.3f m\n\n',Pf(1));
fprintf(fid,'  Y0: %9.3f m\n\n',Pf(2));
fprintf(fid,'  Z0:   %9.3f m\n\n',Pf(3));
fprintf(fid,'  Omega:%9.4f º\n\n',rad2deg(Pf(4)));
fprintf(fid,'  Fi:   %9.4f º\n\n',rad2deg(Pf(5)));
fprintf(fid,'  Kapa: %9.4f º\n\n',rad2deg(Pf(6)));

fclose(fid);