within ICT4CSE.Test;

model test_polyadd
  extends ICT4CSE.Icons.TestModel;
  Real[:] y1 = Functions.polyadd({1,1,1,1},{2,2});
  Real[:] y2 = Functions.polyadd({1,1,1,1},{-1,-1,2,3});

end test_polyadd;
