within ICT4CSE.Functions;

function polypow
  extends Modelica.Icons.Function;

  input Real[:] cp "coeffs of poly (dec pwr)";
  input Integer n(min=0) "exponent (nonnegative)";
  output Real[:] cpo;

algorithm
  if n==0 then
    cpo := {1};
  else
    cpo := cp;
    for i in 2:n loop
      cpo := polymul(cpo,cp);
    end for;
  end if;
end polypow;