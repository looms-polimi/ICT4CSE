function [a,b] = c2d_a1anb0bm_ie(num,den,Ts)
# Takes a continuous-time transfer function in the form num(s)/den(s)
# with input u and output y and a sampling time Ts, and returns vectors
# a and b such that 
#
# y(k) = a(1)y(k-1)...+a(n)y(k-n)+b(1)u(k)...+b(m+1)u(k-m)
#
# using the Implicit Euler (backward difference) method

### Maxima ---------------------------------------------------------------------
# kill(all);
# n     : 4;
# m     : 3;
# Gc    : sum(b[i]*s^(m-i+1),i,1,m+1)/sum(a[i]*s^(n-i+1),i,1,n+1);
# dsc   : s=(z-1)/z/Ts;
# Gd    : subst(dsc,Gc);
# numd  : sum(b[i]*(z-1)^(m-i+1)*(z*Ts)^(i-1),i,1,m+1);
# dend  : sum(a[i]*(z-1)^(n-i+1)*(z*Ts)^(i-1),i,1,n+1);
# kgrel : (z*Ts)^(n-m);
# Gdd   : kgrel*numd/dend;
#         ratsimp(Gd-Gdd);



degnum = length(num)-1;
degden = length(den)-1;
dtnum  = [0];
dtden  = [0];

for i=1:degnum+1
   pterm = num(i)*PolyFunctions.polymul(
              PolyFunctions.polypow([Ts,0],i-1),
              PolyFunctions.polypow([1,-1],degnum-i+1)
           );
   dtnum = PolyFunctions.polyadd(dtnum,pterm);
endfor

for i=1:degden+1
   pterm = den(i)*PolyFunctions.polymul(
              PolyFunctions.polypow([Ts,0],i-1),
              PolyFunctions.polypow([1,-1],degden-i+1)
           );
   dtden = PolyFunctions.polyadd(dtden,pterm);
endfor

if degden>degnum
  dtnum = PolyFunctions.polymul(...
            dtnum,
            PolyFunctions.polypow([Ts,0],degden-degnum)
          );
endif

dtnum
dtden

[a,b] = TfunFunctions.dttf2a1anb0bm(dtnum,dtden);

endfunction
