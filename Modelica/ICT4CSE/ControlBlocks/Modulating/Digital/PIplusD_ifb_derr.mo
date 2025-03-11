within ICT4CSE.ControlBlocks.Modulating.Digital;

model PIplusD_ifb_derr
  "Digital 1-dof PIplusD with AW by internal feedback in the PI part"
  extends BaseClasses.SISO_D_SP_PV_CS_200x200;
  
  parameter Real K=1;
  parameter Real Ti=10;
  parameter Real Td=1;
  parameter Real N=4;
  parameter Real CSmax=1;
  parameter Real CSmin=-1;
  

  discrete Real e,e1,xpi1,upi,ud,ud1,u;

protected
  parameter Real api1 =  Ti/(Ts+Ti);
  parameter Real bpi0 =  Ts/(Ts+Ti);
  parameter Real bpi1 =  0;
  parameter Real ad1  =  Td/(N*Ts+Td);
  parameter Real bd0  =  (N*Td)/(N*Ts+Td);
  parameter Real bd1  = -(N*Td)/(N*Ts+Td);
  

algorithm
  when sample(0,Ts) then
       e    := w-y;

       upi  := max(CSmin,min(CSmax,(api1*xpi1+K*e)/(bpi0+1)));
       xpi1 := api1*xpi1+bpi0*upi;
       
       ud   := ad1*ud1+bd0*K*e+bd1*K*e1;
       ud1  := ud;
       e1   := e;
       u    := max(CSmin,min(CSmax,upi+ud));
  end when;  

initial algorithm
  xpi1 := 0;
  ud1  := 0;
  e1   := 0;
 annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
  Icon(graphics = {Text(origin = {0, -3}, extent = {{-100, 85}, {100, -85}}, textString = "PI+D
1dof
ifb-PI")}));
end PIplusD_ifb_derr;