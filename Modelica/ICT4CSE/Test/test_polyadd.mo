within ICT4CSE.Test;

model test_polyadd
  extends ICT4CSE.Icons.TestModel;
  Real[:] y1 = Functions.polyadd({1,1,1,1},{2,2});
  Real[:] y2 = Functions.polyadd({1,1,1,1},{-1,-1,2,3});

equation
  assert(max(abs(y1 - {1,1,3,3})) < 1e-12, "polyadd failed for unequal polynomial lengths");
  assert(max(abs(y2 - {3,4})) < 1e-12, "polyadd failed to remove negligible leading coefficients");

end test_polyadd;
