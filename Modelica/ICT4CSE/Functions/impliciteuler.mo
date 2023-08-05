within ICT4CSE.Functions;

function impliciteuler
  extends Modelica.Icons.Function;

  input Real[:] ctnum "continuous-time TF numerator (dec pwr)";
  input Real[:] ctden "continuous-time TF denominator (dec pwr)";
  input Real Ts "sampling time";
  input Real[:] dtnum "discrete-time TF numerator (dec pwr)";
  input Real[:] dtden "discrete-time TF denominator (dec pwr)";
protected 
  Integer n1,n2;  
algorithm
 
  n1 := size(cp1,1);
  n2 := size(cp2,1);

  for i in 1:n1+n2-1 loop
    cpo[i] := 0;
    for j in 1:n2 loop
        if i-j+1>0 and i-j+1<=n1 then
           cpo[i] := cpo[i]+cp1[i-j+1]*cp2[j];
        end if;
    end for;
end for;

end impliciteuler;