function [a,b] = dttf2a1anb0bm(num,den)
# Takes a discrete-time transfer function in the form num(z)/den(z)
# with input u and output y, and returns vectors a and b such that 
#
# y(k) = a(1)y(k-1)...+a(n)y(k-n)+b(1)u(k)...+b(m+1)u(k-m)
#
# where m and n are respectively the degrees of num(z) and den(z)
  
degnum = length(num)-1;
degden = length(den)-1;
reldeg = degden-degnum;
a      = -den(2:end)/den(1);
b      = [zeros(1,reldeg),num/den(1)];
while abs(b(end))<1e-9
   b = b(1:end-1);
endwhile;
endfunction
