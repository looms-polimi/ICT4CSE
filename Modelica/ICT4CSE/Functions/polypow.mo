within ICT4CSE.Functions;

function polypow
  extends Modelica.Icons.Function;

  input Real[:] cp "coeffs of poly (dec pwr)";
  input Integer n "exponent";
  output Real[:] cpo;

algorithm
  cpo := cp;
  for i in 2:n loop
    cpo := polymul(cpo,cp);
  end for;

end polypow;