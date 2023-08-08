within ICT4CSE.Functions.Utilities;

function print_real_vector
  extends Modelica.Icons.Function;
  input Real[:] v;
  input String name="";
protected
  String s;
algorithm
  s := name+" ";
  for i in 1:size(v,1) loop
    s := s+"["+String(i)+"] "+String(v[i])+" ";
  end for;
  Modelica.Utilities.Streams.print(s);

end print_real_vector;