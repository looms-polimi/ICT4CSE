within ICT4CSE.Test;

model test_polypow
  extends ICT4CSE.Icons.TestModel;
  Real[:] y = Functions.polypow({1,1},5);

end test_polypow;