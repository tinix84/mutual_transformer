% Here are the references:
% This reference explains mutual impedances including mutual resistances. This is the key to understanding ac resistances of windings.
% J. H. Spreen, "Electrical terminal representation of conductor loss in transformers," in IEEE
% Transactions on Power Electronics, vol. 5, no. 4, pp. 424-429, Oct. 1990.
% https://ieeexplore.ieee.org/document/60685
%
% This reference shows one way to model transformers that uses mutual impedances. They even show how to include capacitive effects.
% E. E. Mombello and K Moller, "New power transformer model for the calculation of electromagnetic
% resonant transient phenomena including frequency-dependent losses"
% IEEE TRANSACTIONS ON POWER DELIVERY, VOL. 15, NO. 1, JANUARY 2000, pp. 167-174.
% https://ieeexplore.ieee.org/document/847246

close all
clear all
clc

dbstop if error

set(0,'defaultTextInterpreter','none'); %trying to set the default
set(0,'defaultLegendInterpreter','none'); %trying to set the default

format SHORTENG
% Define a counter variable for the frequencies
Nf=[1:13]';
data_in;

w=2*pi*f;

R11ac=R11-Rdc1;
R22ac=R22-Rdc2;

figure(1)
loglog(f,R11,f,R22);
grid on; xlabel('f'); ylabel('R11, R22');
title('Fig. 1. Winding resistances.')
legend R11 R22;

figure(4)
loglog(f,L11,f,L22);
grid on; xlabel('f'); ylabel('L11, L22');
title('Fig. 4. Winding Inductances.')
legend L11 L22;

figure(5)
loglog(f,Rleak_12,f,Rleak_21);
grid on; xlabel('f'); ylabel('Rleak_12, Rleak_21');
title('Fig. 5. Leakage resistances.')
legend Rleak_12 Rleak_21;

figure(6)
loglog(f,Lleak_12,f,Lleak_21);
grid on; xlabel('f'); ylabel('Lleak_12, Lleak_21');
title('Fig. 6. Leakage inductances.')
legend Lleak_12 Lleak_21;

% Define frequency and resistance vectors for the proximity effect regime.
% Compute the coefficients for the proximity effect asymptotes.
m=[1:7]';
fpm=f(m); R11acpm=R11ac(m); R22acpm=R22ac(m);
PE1=polyfit(fpm,R11acpm,2)
PE2=polyfit(fpm,R22acpm,2)
Prox1=PE1(1).*f.^2;
Prox2=PE2(1).*f.^2;

%Define frequency and resistance vectors for the skin effect regime.
m=[1:4]'+9;
fpm=f(m); R11acpm=R11ac(m); R22acpm=R22ac(m);
SE1=polyfit(fpm,R11acpm,1)
SE2=polyfit(fpm,R22acpm,1)
Skin1=SE1(1).*f;
Skin2=SE2(1).*f;

figure(2)
loglog(f,R11ac, f,Prox1,'--', f,Skin1,'--');
grid on; xlabel('f'); ylabel('R11, Prox1, Skin1');
title('Fig. 2.  Proximity effect and skin effect asymptotes for winding 1.')
legend R11 Prox1 Skin1;

figure(3)
loglog(f,R22ac, f,Prox2,'--', f,Skin2,'--');
grid on; xlabel('f'); ylabel('R22, Prox2, Skin2');
title('Fig. 3.  Proximity effect and skin effect asymptotes for winding 2.')
legend R22 Prox2 Skin2;

Z11=R11+1j.*w.*L11;
Z22=R22+1j.*w.*L22;
Zleak_12=Rleak_12+1j.*w.*Lleak_12;
Zleak_21=Rleak_21+1j.*w.*Lleak_21;

%Compute the mutual impedances.
Z12=sqrt((Z11-Zleak_12).*Z22);
Z21=sqrt((Z22-Zleak_21).*Z11);
R12=real(Z12); R21=real(Z21);
L12=imag(Z12)./w; L21=imag(Z21)./w;

figure(8)
loglog(f,R12, f,R21,'x');
grid on; xlabel('f'); ylabel('R12, R21');
title('Fig. 8.  Mutual resistances.')
legend R12 R21;

figure(9)
loglog(f,L12, f,L21,'x');
grid on; xlabel('f'); ylabel('L12, L21');
title('Fig. 9.  Mutual inductances.')
legend L12 L21;

for n=1:length(f)
    Y(:,:,n)=inv([Z11(n), Z12(n); Z21(n), Z22(n)]);
    Ileak_12(:,:,n)=Y(:,:,n)*[1;0];
    Ileak_21(:,:,n)=Y(:,:,n)*[0;1];
    L(:,:,n)=[L11(n), L12(n); L21(n), L22(n)];
end

Zleak_12c=1./Ileak_12(1,:).'; Zleak_21c=1./Ileak_21(2,:).';
Rleak_12c=real(Zleak_12c); Rleak_21c=real(Zleak_21c);
Lleak_12c=imag(Zleak_12c)./w; Lleak_21c=imag(Zleak_21c)./w;

figure(10)
loglog(f,Rleak_12, f,Rleak_12c,'o', f,Rleak_21, f,Rleak_21c,'o');
grid on; xlabel('f'); ylabel('Rleak_12, Rleak_12c, Rleak_21,Rleak_21c');
title('Fig. 10.  Measured and computed leakage resistances. ')
legend Rleak_12 Rleak_12c Rleak_21 Rleak_21c;

figure(11)
loglog(f,Lleak_12, f,Lleak_12c,'o', f,Lleak_21, f,Lleak_21c,'o');
grid on; xlabel('f'); ylabel('Rleak_12, Rleak_12c, Rleak_21,Rleak_21c');
title('Fig. 11.  Measured and computed leakage inductances. ')
legend Lleak_12 Lleak_12c Lleak_21 Lleak_21c;

Lb=L(:,:,1);
LA = [Lb(1,1); Lb(1,1); Lb(2,2); Lb(2,2)];
Rb=[Rdc1,0;0,Rdc2];

N=2; r=2;
M=ones(N, N*r);


%Guess values
RA = [400;6000;350;6000];
M =[ 1.3e-4, 1e-4, 1.6e-4, 1.6e-4; ...
    1.6e-4, 1.6e-4, 3.3e-4, 3.2e-4];

%run optimizer
x0=[RA; reshape(M',1,[])'];
xs_mathcad=[277.5980; 6.7350e3; 344.5523; 6.2452e3; 1.2658e-4; 1.7846e-4; 1.4899e-4; 1.5551e-4; 1.2946e-4; 3.0500e-4; 3.1596e-4; 3.1620e-4];
err=f_goal(xs_mathcad, f, R11, Rleak_12, Rleak_21, R22, LA, L11, Lleak_12, Lleak_21, L22, Rb, Lb)
%x0=xs_mathcad;

lb=zeros(size(x0));
ub=[];

f_goal_x0=f_goal(x0, f, R11, Rleak_12, Rleak_21, R22, LA, L11, Lleak_12, Lleak_21, L22, Rb, Lb);

options = optimoptions('fmincon','Display','iter');
[xs,fs,exitflag,output,lambda,grad,hessian] =...
    fmincon(@(x)f_goal(x, f, R11, Rleak_12, Rleak_21, R22, LA, L11, Lleak_12, Lleak_21, L22, Rb, Lb),...
    x0,[],[],[],[],lb,ub,[],options);
abs(xs-xs_mathcad)./xs*100

% xs=xs_mathcad

Rf=xs(1:4); Lf=LA;
M=reshape(xs(5:end),4,[]).';


LC11=zeros(length(f),1);
LC22=zeros(length(f),1);
RC11=zeros(length(f),1);
RC22=zeros(length(f),1);

Zleak12C=zeros(length(f),1);
Rleak12C=zeros(length(f),1);
Lleak12C=zeros(length(f),1);

Zleak21C=zeros(length(f),1);
Rleak21C=zeros(length(f),1);
Lleak21C=zeros(length(f),1);

for n=1:length(f)
    Zb=Rb+1j.*w(n).*Lb;
    Zm=1j.*w(n).*M;
    ZA=diag(Rf+1j.*w(n).*Lf);
    Yf=inv(ZA);
    Gf=real(Yf); Bf=-imag(Yf)/w(n);
    
    Rw=[R11(n), R12(n); R21(n), R22(n)];
    Lw=[L11(n), L12(n); L21(n), L22(n)];
    RC_n=Rb+w(n)^2*M*Gf*M';
    LC_n=Lb-w(n)^2*M*Bf*M';
    
    L11C(n,1)=LC_n(1,1);
    L22C(n,1)=LC_n(2,2);
    R11C(n,1)=RC_n(1,1);
    R22C(n,1)=RC_n(2,2);
    
    Zsys_n=[[Zb,Zm];[Zm.',ZA]];
    Ileak12=(Zsys_n)\[1;zeros(5,1)];
    Zleak12C(n,1)=1./Ileak12(1,1);
    Rleak12C(n,1)=real(Zleak12C(n,1));
    Lleak12C(n,1)=imag(Zleak12C(n,1))/w(n);
    
    Ileak21=(Zsys_n)\[0;1;zeros(4,1)];
    Zleak21C(n,1)=1./Ileak21(2,1);
    Rleak21C(n,1)=real(Zleak21C(n,1));
    Lleak21C(n,1)=imag(Zleak21C(n,1))/w(n);
end

Z11C=R11C+1j.*w.*L11C;
Z22C=R22C+1j.*w.*L22C;
Z12C=sqrt((Z11C-Zleak12C).*Z22C);
R12C=real(Z12C); L12C=imag(Z12C)./w;

figure(13)
loglog(f,R11, f, R11C,'o', f, R22, f,R22C,'o');
grid on; xlabel('f'); ylabel('R11, R11C, R22, R22C');
title('Fig. 13.  Measured and calculated winding Resistances.')
legend R11 R11C R22 R22C

figure(14)
loglog(f,L11, f, L11C,'o', f, L22, f,L22C,'o');
grid on; xlabel('f'); ylabel('L11, L11C, L22, L22C');
title('Fig. 14. Measured and calculated winding Inductances.')
legend L11 L11C L22 L22C

figure(15)
loglog(f,Rleak_12, f, Rleak12C,'o', f, Rleak_21, f, Rleak21C,'o');
grid on; xlabel('f'); ylabel('Rleak_12, Rleak12C, Rleak_21, Rleak21C');
title('Fig. 15 Measured and computed leakage resistances. ')
legend Rleak_12 Rleak12C Rleak_21 Rleak21C

kr12=R12./sqrt(R11.*R22)
kr12C=R12C./sqrt(R11C.*R22C)

figure(19)
loglog(f,kr12, f, kr12C,'x');
grid on; xlabel('f'); ylabel('kr12, kr12C');
title('Fig. 19.  Measured and modeled mutual resistance couplings.')
legend kr12 kr12C