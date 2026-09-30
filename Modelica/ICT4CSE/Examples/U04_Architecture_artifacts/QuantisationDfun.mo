within ICT4CSE.Examples.U04_Architecture_artifacts;

model QuantisationDfun
  Real A, w, u,y,D;
equation
  A = 0.01*floor(time/0.01);
  w = 6.28/0.001;
  u = A*sin(w*time);
  if u>0 then
     y = 0.1*(if u-floor(u/0.1)<0.05 then floor(u/0.1) else ceil(u/0.1));
  else
     y = 0.1*(if ceil(floor(u/0.1)-u)<0.05 then ceil(u/0.1) else floor(u/0.1));
  end if;
algorithm
  when sample(0,0.001) then
    if abs(u)>0.001 then
       D := y/u;
    else
       D := 0;
    end if;
  end when;
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 1.00001e-05),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end QuantisationDfun;