within ICT4CSE.Blocks;

model DiscreteTimeTF
  extends BaseClasses.BaseDigitalSISO200x200;
  parameter Real[:] num = {0.5} "coeffs of CT num (dec pwr)";
  parameter Real[:] den = {1,3,3,1} "coeffs of CT den (dec pwr)";
  parameter Real Ts = 0.1 "sampling time";
  parameter Real t0 = 0 "time of 1st sample";
  
protected
  parameter Real a1an[size(den, 1) - 1](each fixed = false) annotation(Evaluate = true);
  parameter Real b0bm[size(num,1)](each fixed=false) annotation(Evaluate = true);
  discrete Real yy,uVec[size(b0bm,1)],yVec[size(a1an,1)];
  
equation
  y = yy;
  
algorithm
  when sample(t0+1e-6*Ts,Ts) then
    uVec := cat(1,{u},uVec[1:end-1]);
    yy   := a1an*yVec+b0bm*uVec;
    yVec := cat(1,{yy},yVec[1:end-1]);
  end when;

initial equation
  (a1an,b0bm) = Functions.c2d_a1anb0bm_ie(num,den,Ts);
annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", variableFilter = ".*"));
end DiscreteTimeTF;