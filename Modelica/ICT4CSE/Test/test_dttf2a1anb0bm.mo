within ICT4CSE.Test;

model test_dttf2a1anb0bm
  extends ICT4CSE.Icons.TestModel;
  Real a[3], b[4];


equation  
  (a,b) = Functions.dttf2a1anb0bm({1,2,3},{4,5,6,7});

end test_dttf2a1anb0bm;