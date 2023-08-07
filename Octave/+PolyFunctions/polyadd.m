function cpo = polyadd(cp1,cp2)
  n1 = length(cp1);
  n2 = length(cp2); 
  if n2>n1 cp1e = [zeros(1,n2-n1),cp1];
      else cp1e = cp1;
  endif
  if n1>n2 cp2e = [zeros(1,n1-n2),cp2];
      else cp2e = cp2;
  endif
  cpo = cp1e+cp2e;
  while abs(cpo(1))<1e-9
    cpo = cpo(2:end);
  endwhile;
endfunction
