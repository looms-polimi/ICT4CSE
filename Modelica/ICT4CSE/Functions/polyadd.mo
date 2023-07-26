within ICT4CSE.Functions;

function polyadd
  extends Modelica.Icons.Function;

  input Real[:] cp1 "coeffs of poly 1 (dec pwr)";
  input Real[:] cp2 "coeffs of poly 2 (dec pwr)";
  input Real zlc=1e-9 "set leading coeff to 0 if smaller in mag, use neg val to disable";
  output Real[:] cpo  "coeffs of sum (dec pwr)";
  
protected 
  Integer n1,n2;
  Real cp1e[:],cp2e[:]; 
  
algorithm
 
  n1   := size(cp1,1);
  n2   := size(cp2,1);
  cp1e := if n2>n1 then vector([zeros(n2-n1,1);cp1]) else cp1;
  cp2e := if n1>n2 then vector([zeros(n1-n2,1);cp2]) else cp2;
  cpo  := cp1e+cp2e;
  while abs(cpo[1])<zlc loop
    cpo := cpo[2:end];
  end while;

end polyadd;