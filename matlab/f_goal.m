function f_goal = f_goal(x, f, R11, R12, R21, R22, Lf, L11, L12, L21, L22, Rb, Lb)

Rf=x(1:4);
M=reshape(x(5:end),4,[]).';
w=2*pi*f;

err=100*ones(8*length(f),1);

for n=1:length(f)
    Zb=Rb+1j.*w(n).*Lb;
    Zm=1j.*w(n).*M;
    ZA=diag(Rf+1j.*w(n).*Lf);
    Yf=inv(ZA);
    Gf=real(Yf); Bf=-imag(Yf)/w(n);
    Zsys=[[Zb,Zm];[Zm.',ZA]];
    
    Rw=[R11(n), R12(n); R21(n), R22(n)];
    Lw=[L11(n), L12(n); L21(n), L22(n)];
    errR_fi=Rw-Rb+w(n)^2*M*Gf*M.';
    errL_fi=Lw-Lb+w(n)^2*M*Bf*M.';
    
    err(8*n-7:8*n)=[reshape(errR_fi,4,[]); reshape(errL_fi,4,[])];
end

f_goal = sum(abs(err).^2)
%f_goal=err;
end

