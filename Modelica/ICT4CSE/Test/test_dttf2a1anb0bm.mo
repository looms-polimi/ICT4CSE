within ICT4CSE.Test;

model test_dttf2a1anb0bm
  extends ICT4CSE.Icons.TestModel;
  Real a[2], b[4];


equation  
  (a,b) = Functions.dttf2a1anb0bm({1,2,3},{4,5,6,7});

  assert(max(abs(a - {-2,-3})) < 1e-12, "dttf2a1anb0bm returned incorrect denominator coefficients");
  assert(max(abs(b - {4,5,6,7})) < 1e-12, "dttf2a1anb0bm returned incorrect numerator coefficients");

end test_dttf2a1anb0bm;