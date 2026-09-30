within ICT4CSE.Test;

model test_polymul
  extends ICT4CSE.Icons.TestModel;
  Real[:] y = Functions.polymul({1,1,1,1},{-1,-1,2,3});

equation
  assert(max(abs(y - {-1,-2,0,3,4,5,3})) < 1e-12, "polymul failed");

end test_polymul;
