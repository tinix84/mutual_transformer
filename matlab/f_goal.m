function f_goal = f_goal(x, f, R11, R12, R21, R22, Lf, L11, L12, L21, L22, Rb, Lb)


w=2*pi*f;
err=0*ones(8*length(f),1);

Rf=x(1:4);
M=reshape(x(5:end),4,[]).';



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
    
    Zsys_n=[[Zb,Zm];[Zm.',ZA]];
    Ileak12=(Zsys_n)\[1;zeros(5,1)];
    Zleak12C=1./Ileak12(1,1);
    Rleak12C=real(Zleak12C);
    Lleak12C=imag(Zleak12C)/w(n);
    
    Ileak21=(Zsys_n)\[1;zeros(5,1)];
    Zleak21C=1./Ileak21(1,1);
    Rleak21C=real(Zleak21C);
    Lleak21C=imag(Zleak21C)/w(n);
    
    LC_n(1,2) = Lleak12C; LC_n(2,1) = Lleak21C;
    RC_n(1,2) = Rleak12C; RC_n(2,1) = Rleak21C;
    
    errR_n=((Rw-RC_n)./Rw).^2;
    errL_n=((Lw-LC_n)./Lw).^2;
    
    err(8*n-7:8*n)=[reshape(errR_n,4,[]); reshape(errL_n,4,[])];
    
end

f_goal = sum(err);
%f_goal=err;
end

