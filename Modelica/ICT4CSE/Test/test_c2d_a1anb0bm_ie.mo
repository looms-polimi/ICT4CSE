within ICT4CSE.Test;

model test_c2d_a1anb0bm_ie
  extends ICT4CSE.Icons.TestModel;
  Real a[3],b[3];


equation
 
    (a,b) = Functions.c2d_a1anb0bm_ie({10,7,1},{1,3,3,1},0.5);

  
end test_c2d_a1anb0bm_ie;