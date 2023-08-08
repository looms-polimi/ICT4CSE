within ICT4CSE.Functions;

function c2d_a1anb0bm_ie
  "continuous-time TF y/u = num/den & amping time Ts to a and b
   s.t. y(k) = a(1)y(k-1)...+a(n)y(k-n)+b(1)u(k)...+b(m+1)u(k-m),
   implicit Euler (backward difference) method"
  extends Modelica.Icons.Function;
  
  input Real[:] num "coeffs of CT num (dec pwr)";
  input Real[:] den "coeffs of CT den (dec pwr)";
  input Real Ts "sampling time";
  output Real[:] a;
  output Real[:] b;
protected
  Integer degnum,degden;
  Real[:] dtnum,dtden,pterm;
  
algorithm
degnum := size(num,1)-1;
degden := size(den,1)-1;
dtnum  := {0};
dtden  := {0};

for i in 1:degnum+1 loop
   pterm := num[i]*Functions.polymul(
               Functions.polypow({Ts,0},i-1),
               Functions.polypow({1,-1},degnum-i+1)
            )/Ts^degnum;
   dtnum := Functions.polyadd(dtnum,pterm);
end for;

for i in 1:degden+1 loop
   pterm := den[i]*Functions.polymul(
               Functions.polypow({Ts,0},i-1),
               Functions.polypow({1,-1},degden-i+1)
            )/Ts^degden;
   dtden := Functions.polyadd(dtden,pterm);
end for;

if degden>degnum then
  dtnum := Functions.polymul(
             dtnum,
             Functions.polypow({1,0},degden-degnum)
           );
end if;

(a,b) := Functions.dttf2a1anb0bm(dtnum,dtden);

end c2d_a1anb0bm_ie;