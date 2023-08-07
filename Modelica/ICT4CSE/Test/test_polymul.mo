within ICT4CSE.Test;

model test_polymul
  extends ICT4CSE.Icons.TestModel;
  Real[:] y = Functions.polymul({1,1,1,1},{-1,-1,2,3});

end test_polymul;
