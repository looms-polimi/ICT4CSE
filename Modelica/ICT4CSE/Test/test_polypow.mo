within ICT4CSE.Test;

model test_polypow
  extends ICT4CSE.Icons.TestModel;
  Real[:] y = Functions.polypow({1,1},5);

equation
  assert(max(abs(y - {1,5,10,10,5,1})) < 1e-12, "polypow failed");

end test_polypow;