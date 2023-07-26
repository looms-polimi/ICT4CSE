within ICT4CSE.Test;

model test_polyadd
  extends ICT4CSE.Icons.TestModel;
  Real[:] y = Functions.polyadd({1,1,1,1},{-1,-1,2,3});

end test_polyadd;
