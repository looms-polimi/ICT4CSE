within ICT4CSE.Functions;

function dttf2a1anb0bm
  "discrete-time TF y/u = num/den to a and b s.t.
   y(k) = a(1)y(k-1)...+a(n)y(k-n)+b(1)u(k)...+b(m+1)u(k-m)"
  extends Modelica.Icons.Function;

  input Real[:] num "coeffs of num (dec pwr)";
  input Real[:] den "coeffs of den (dec pwr)";
  input Real ztc=Constants.negligible_TF_coeff "set trailing coeff to 0 if smaller in mag, use neg val to disable";
  output Real[:] a;
  output Real[:] b;
protected
  Integer degnum, degden, reldeg;
  
algorithm
  degnum := size(num,1)-1;
  degden := size(den,1)-1;
  reldeg := degden-degnum;
  a      := -den[2:end]/den[1];
  b      := vector([zeros(reldeg,1);num/den[1]]);
  
  while abs(b[end])<ztc loop
    b := b[1:end-1];
  end while;

end dttf2a1anb0bm;