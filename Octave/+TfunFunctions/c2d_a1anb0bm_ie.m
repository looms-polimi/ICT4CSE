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
# m      : 4;
# ctnum  : sum(b[i]*s^(m-i+1),i,1,m+1);
# dsc    : s=(z-1)/z/Ts;
# dtnum1 : num(rat(subst(dsc,ctnum),z));
# dtnum2 : rat(sum(b[i]*Ts^(i-1)*z^(i-1)*(z-1)^(m-i+1),i,1,m+1),z);
#          ratsimp(dtnum1-dtnum2);



degnum = length(num)-1;
degden = length(den)-1;
dtnum  = [0];
dtden  = [0];

for i=1:degnum+1
   pterm = num(i)*PolyFunctions.polymul(
              PolyFunctions.polypow([Ts,0],i-1),
              PolyFunctions.polypow([1,-1],degnum-i+1)
           )/Ts^degnum;
   dtnum = PolyFunctions.polyadd(dtnum,pterm)
endfor

for i=1:degden+1
   pterm = den(i)*PolyFunctions.polymul(
              PolyFunctions.polypow([Ts,0],i-1),
              PolyFunctions.polypow([1,-1],degden-i+1)
           )/Ts^degden;
   dtden = PolyFunctions.polyadd(dtden,pterm)
endfor

if degden>degnum
  dtnum = PolyFunctions.polymul(...
            dtnum,
            PolyFunctions.polypow([1,0],degden-degnum)
          );
endif

[a,b] = TfunFunctions.dttf2a1anb0bm(dtnum,dtden)

endfunction
