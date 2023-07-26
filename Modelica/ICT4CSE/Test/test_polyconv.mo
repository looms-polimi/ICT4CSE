within ICT4CSE.Test;

model test_polyconv
  extends ICT4CSE.Icons.TestModel;
  Real[:] y = Functions.polyconv({1,1,1,1},{-1,-1,2,3});

end test_polyconv;