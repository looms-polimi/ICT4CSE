within ICT4CSE.ControlBlocks.Modulating.Digital;

model PID_2dof_nonminimum
  extends BaseClasses.SISO_D_SP_PV_CS_200x200;
  parameter Real K = 1;
  parameter Real Ti = 10;
  parameter Real Td = 1;
  parameter Real N = 4;
  parameter Real b = 1;
  parameter Real c = 0;
  parameter Real CSmax = 1;
  parameter Real CSmin = -1;
  /* MAXIMA
  kill(all);
  U     :  K*(b*W-Y+1/s/Ti*(W-Y)+s*Td/(1+s*Td/N)*(c*W-Y));
  disc  :  s=(z-1)/z/Ts;
  Cwwd  :  rat(subst(disc,diff(U,W)),z);
  Cfbd  :  rat(subst(disc,diff(-U,Y)),z);
  Cffd  :  rat(Cwwd/Cfbd,z);
  afb1  : -factor(coeff(denom(Cfbd),z,1)/coeff(denom(Cfbd),z,2));
  afb2  : -factor(coeff(denom(Cfbd),z,0)/coeff(denom(Cfbd),z,2));
  bfb0  :  factor(coeff(num(Cfbd),z,2)/coeff(denom(Cfbd),z,2));
  bfb1  :  factor(coeff(num(Cfbd),z,1)/coeff(denom(Cfbd),z,2));
  bfb2  :  factor(coeff(num(Cfbd),z,0)/coeff(denom(Cfbd),z,2));
  aff1  : -factor(coeff(denom(Cffd),z,1)/coeff(denom(Cffd),z,2));
  aff2  : -factor(coeff(denom(Cffd),z,0)/coeff(denom(Cffd),z,2));
  bff0  :  factor(coeff(num(Cffd),z,2)/coeff(denom(Cffd),z,2));
  bff1  :  factor(coeff(num(Cffd),z,1)/coeff(denom(Cffd),z,2));
  bff2  :  factor(coeff(num(Cffd),z,0)/coeff(denom(Cffd),z,2));
           ratsimp(Cfbd-(bfb0+bfb1/z+bfb2/z^2)/(1-afb1/z-afb2/z^2));
           ratsimp(Cffd-(bff0+bff1/z+bff2/z^2)/(1-aff1/z-aff2/z^2));
  */
  discrete Real wf, wf1, wf2, w1, w2, u1, u2, ef, ef1, ef2;
protected
  parameter Real afb1 = (N * Ts + 2 * Td) / (N * Ts + Td);
  parameter Real afb2 = -Td / (N * Ts + Td);
  parameter Real bfb0 = K * (N * Ts ^ 2 + N * Ti * Ts + Td * Ts + N * Td * Ti + Td * Ti) / (Ti * (N * Ts + Td));
  parameter Real bfb1 = -K * (N * Ti * Ts + Td * Ts + 2 * N * Td * Ti + 2 * Td * Ti) / (Ti * (N * Ts + Td));
  parameter Real bfb2 = K * (N + 1) * Td / (N * Ts + Td);
  parameter Real aff1 = (N * Ti * Ts + Td * Ts + 2 * N * Td * Ti + 2 * Td * Ti) / (N * Ts ^ 2 + N * Ti * Ts + Td * Ts + N * Td * Ti + Td * Ti);
  parameter Real aff2 = -(N + 1) * Td * Ti / (N * Ts ^ 2 + N * Ti * Ts + Td * Ts + N * Td * Ti + Td * Ti);
  parameter Real bff0 = (N * Td * Ti * c + N * Ti * Ts * b + Td * Ti * b + N * Ts ^ 2 + Td * Ts) / (N * Ts ^ 2 + N * Ti * Ts + Td * Ts + N * Td * Ti + Td * Ti);
  parameter Real bff1 = -(2 * N * Td * Ti * c + N * Ti * Ts * b + 2 * Td * Ti * b + Td * Ts) / (N * Ts ^ 2 + N * Ti * Ts + Td * Ts + N * Td * Ti + Td * Ti);
  parameter Real bff2 = Td * Ti * (N * c + b) / (N * Ts ^ 2 + N * Ti * Ts + Td * Ts + N * Td * Ti + Td * Ti);
algorithm
  when sample(0, Ts) then
    wf := aff1 * wf1 + aff2 * wf2 + bff0 * w + bff1 * w1 + bff2 * w2;
    ef := wf - y;
    u := afb1 * u1 + afb2 * u2 + bfb0 * ef + bfb1 * ef1 + bfb2 * ef2;
    u := max(CSmin, min(CSmax, u));
    wf2 := wf1;
    wf1 := wf;
    w2 := w1;
    w1 := w;
    ef2 := ef1;
    ef1 := ef;
    u2 := u1;
    u1 := u;
  end when;
initial algorithm
  wf1 := 0;
  wf2 := 0;
  w1  := 0;
  w2  := 0;
  u1  := 0;
  u2  := 0;
  ef1 := 0;
  ef2 := 0;

  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
  Icon(graphics = {Text(origin = {-1, -1}, extent = {{81, -87}, {-81, 87}}, textString = "PID
2dof
nonmin")}));
end PID_2dof_nonminimum;