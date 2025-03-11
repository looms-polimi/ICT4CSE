within ICT4CSE.ControlBlocks.Modulating.Digital;

model PIplusD_ifb_dout
  "Digital output derivation PIplusD with AW by internal feedback in the PI part"
  extends BaseClasses.SISO_D_SP_PV_CS_200x200;
  
  parameter Real K=1;
  parameter Real Ti=10;
  parameter Real Td=1;
  parameter Real N=4;
  parameter Real CSmax=1;
  parameter Real CSmin=-1;
  
/* MAXIMA
  kill(all);
  CPI    :  (1+1/s/Ti);
  CD     :  s*Td/(1+s*Td/N);
  disc   :  s=(z-1)/z/Ts;
  GfbPI  :  rhs(solve(1/(1-G)=CPI,G)[1]);
  GfbPId :  rat(subst(disc,GfbPI),z);
  CDD    :  rat(subst(disc,CD),z);
  api1   : -factor(coeff(denom(GfbPId),z,0)/coeff(denom(GfbPId),z,1));
  bpi0   :  factor(coeff(num(GfbPId),z,1)/coeff(denom(GfbPId),z,1));
  bpi1   :  factor(coeff(num(GfbPId),z,0)/coeff(denom(GfbPId),z,1));
            ratsimp(GfbPId-(bpi0+bpi1/z)/(1-api1/z));
  ad1    : -factor(coeff(denom(CDD),z,0)/coeff(denom(CDD),z,1));
  bd0    :  factor(coeff(num(CDD),z,1)/coeff(denom(CDD),z,1));
  bd1    :  factor(coeff(num(CDD),z,0)/coeff(denom(CDD),z,1));
            ratsimp(CDD-(bd0+bd1/z)/(1-ad1/z));
*/

  discrete Real e,y1,xpi,xpi1,upi,upi1,ud,ud1,u;

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
       upi  := max(CSmin,min(CSmax,K*e+xpi));
       xpi  := api1*xpi1+bpi0*upi+bpi1*upi1;
       xpi1 := xpi;
       upi1 := upi;       
       ud   := ad1*ud1-bd0*K*y-bd1*K*y1;
       ud1  := ud;
       y1   := y;
       u    := max(CSmin,min(CSmax,upi+ud));
  end when;  

initial algorithm
  xpi  := 0;
  xpi1 := 0;
  upi1 := 0;
  ud1  := 0;
  y1   := 0;
 annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
  Icon(graphics = {Text(origin = {0, -3}, extent = {{-100, 85}, {100, -85}}, textString = "PI+D
dout
ifb-PI")}));
end PIplusD_ifb_dout;