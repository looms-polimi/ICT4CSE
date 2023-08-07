function pp = polypow(p,n)
  if n==0
     pp = [1];
  else
     pp = p;
     for i=2:n
       pp = PolyFunctions.polymul(pp,p);
     endfor
  endif
endfunction
