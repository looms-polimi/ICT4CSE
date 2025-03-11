within ICT4CSE.ControlBlocks.Modulating.Digital;

model PID_1dof_nonminimum_incremental
  extends BaseClasses.SISO_D_SP_PV_CS_200x200;
  parameter Real K = 1;
  parameter Real Ti = 10;
  parameter Real Td = 1;
  parameter Real N = 4;
  parameter Real CSmax = 1;
  parameter Real CSmin = -1;
  discrete Real du, du1, du2, de, de1, de2, e, e1, u1;
protected
  parameter Real a1 = (N * Ts + 2 * Td) / (N * Ts + Td);
  parameter Real a2 = -Td / (N * Ts + Td);
  parameter Real b0 = K * (N * Ts ^ 2 + N * Ti * Ts + Td * Ts + N * Td * Ti + Td * Ti) / (Ti * (N * Ts + Td));
  parameter Real b1 = -K * (N * Ti * Ts + Td * Ts + 2 * N * Td * Ti + 2 * Td * Ti) / (Ti * (N * Ts + Td));
  parameter Real b2 = K * (N + 1) * Td / (N * Ts + Td);
algorithm
  when sample(0, Ts) then
    e   := w - y;
    de  := e - e1;
    du  := a1 * du1 + a2 * du2 + b0 * de + b1 * de1 + b2 * de2;
    u   := max(CSmin, min(CSmax, u1+du));
    de2 := de1;
    de1 := de;
    du2 := du1;
    du1 := du;
    e1  := e;
    u1  := u;
  end when;
initial algorithm
  du1 := 0;
  du2 := 0;
  de1 := 0;
  de2 := 0;
  e1  := 0;
annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
  Icon(graphics = {Text(origin = {-1, -1}, extent = {{81, -87}, {-81, 87}}, textString = "PID
1dof
nmin inc")}));
end PID_1dof_nonminimum_incremental;