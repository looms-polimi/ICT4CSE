within ICT4CSE.ControlBlocks.Modulating.Digital;

model PI_ifb_dout
  "Digital output derivation PIplusD with AW by internal feedback in the PI part"
  extends BaseClasses.SISO_D_SP_PV_CS_200x200;
  
  parameter Real K=1;
  parameter Real Ti=10;
  parameter Real CSmax=1;
  parameter Real CSmin=-1;
  
  discrete Real e,q,q1,u;

protected
  parameter Real beta = K*(1+Ts/Ti);
  parameter Real b0H =  Ts/(Ts+Ti);
  parameter Real a1H =  Ti/(Ts+Ti);

algorithm
  when sample(0,Ts) then
       e  := w-y;
       u  := max(CSmin,min(CSmax,beta*e+q));
       q  := a1H*q1+b0H*u;
       q1 := q;
  end when;  

initial algorithm
  q1 := 0;
 annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
  Icon(graphics = {Text(origin = {0, -3}, extent = {{-100, 85}, {100, -85}}, textString = "PI
dout
ifb")}));
end PI_ifb_dout;