within ICT4CSE.ControlBlocks.Modulating.Digital;

model PID_1dof_nonminimum
  extends BaseClasses.SISO_D_SP_PV_CS_200x200;
  parameter Real K = 1;
  parameter Real Ti = 10;
  parameter Real Td = 1;
  parameter Real N = 4;
  parameter Real CSmax = 1;
  parameter Real CSmin = -1;
  /* MAXIMA
  C   :  K*(1+1/s/Ti+s*Td/(1+s*Td/N));
  Cd  :  rat(subst(s=(z-1)/z/Ts,C),z);
  a1  : -factor(coeff(denom(Cd),z,1)/coeff(denom(Cd),z,2));
  a2  : -factor(coeff(denom(Cd),z,0)/coeff(denom(Cd),z,2));
  b0  :  factor(coeff(num(Cd),z,2)/coeff(denom(Cd),z,2));
  b1  :  factor(coeff(num(Cd),z,1)/coeff(denom(Cd),z,2));
  b2  :  factor(coeff(num(Cd),z,0)/coeff(denom(Cd),z,2));
         ratsimp(Cd-(b0+b1/z+b2/z^2)/(1-a1/z-a2/z^2));
  */
  discrete Real u1, u2, e, e1, e2;
protected
  parameter Real a1 = (N * Ts + 2 * Td) / (N * Ts + Td);
  parameter Real a2 = -Td / (N * Ts + Td);
  parameter Real b0 = K * (N * Ts ^ 2 + N * Ti * Ts + Td * Ts + N * Td * Ti + Td * Ti) / (Ti * (N * Ts + Td));
  parameter Real b1 = -K * (N * Ti * Ts + Td * Ts + 2 * N * Td * Ti + 2 * Td * Ti) / (Ti * (N * Ts + Td));
  parameter Real b2 = K * (N + 1) * Td / (N * Ts + Td);
algorithm
  when sample(0, Ts) then
    e := w - y;
    u := a1 * u1 + a2 * u2 + b0 * e + b1 * e1 + b2 * e2;
    u := max(CSmin, min(CSmax, u));
    e2 := e1;
    e1 := e;
    u2 := u1;
    u1 := u;
  end when;
initial algorithm
  u1 := 0;
  u2 := 0;
  e1 := 0;
  e2 := 0;
annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
  Icon(graphics = {Text(origin = {-1, -1}, extent = {{81, -87}, {-81, 87}}, textString = "PID
1dof
nonmin")}));
end PID_1dof_nonminimum;