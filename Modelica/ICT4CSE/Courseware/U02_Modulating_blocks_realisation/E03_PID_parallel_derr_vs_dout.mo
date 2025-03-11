within ICT4CSE.Courseware.U02_Modulating_blocks_realisation;

model E03_PID_parallel_derr_vs_dout
  "Parallel antiwindup PID realisation, error versus output derivative:
   compare SP, PV and CS in the two PIDs"
   extends Icons.CourseworkModel;

  parameter Real K=2;
  parameter Real Ti=10;
  parameter Real Td=1;
  parameter Real N=4;
  parameter Real CSmax=1;
  parameter Real CSmin=-1;
  parameter Real Ts=0.05;
  parameter Real Pn[:]={1};
  parameter Real Pd[:]={10,11,1};
  
  Modelica.Blocks.Continuous.TransferFunction P_parallel_derr(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression SP(y = if time < 1 then 0 elseif time < 100 then 0.8
   elseif time < 200 then 1.2 elseif time<300 then 0.2    elseif time < 400 then 0.8 else 0.5) annotation(
    Placement(visible = true, transformation(origin = {-170, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_parallel_dout(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ICT4CSE.ControlBlocks.Modulating.Digital.PID_parallel_derr PID_parallel_derr(K=K,Ti=Ti,Td=Td,N=N,CSmax=CSmax,CSmin=CSmin,Ts=Ts) annotation(
    Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ControlBlocks.Modulating.Digital.PID_parallel_dout PID_parallel_dout(K=K,Ti=Ti,Td=Td,N=N,CSmax=CSmax,CSmin=CSmin,Ts=Ts) annotation(
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(PID_parallel_derr.CS, P_parallel_derr.u) annotation(
    Line(points = {{-78, 70}, {-22, 70}}, color = {0, 0, 127}));
  connect(PID_parallel_dout.CS, P_parallel_dout.u) annotation(
    Line(points = {{-78, 30}, {-22, 30}}, color = {0, 0, 127}));
  connect(P_parallel_derr.y, PID_parallel_derr.PV) annotation(
    Line(points = {{2, 70}, {10, 70}, {10, 52}, {-112, 52}, {-112, 64}, {-102, 64}}, color = {0, 0, 127}));
  connect(P_parallel_dout.y, PID_parallel_dout.PV) annotation(
    Line(points = {{2, 30}, {10, 30}, {10, 10}, {-112, 10}, {-112, 24}, {-102, 24}}, color = {0, 0, 127}));
  connect(SP.y, PID_parallel_derr.SP) annotation(
    Line(points = {{-158, 76}, {-102, 76}}, color = {0, 0, 127}));
  connect(SP.y, PID_parallel_dout.SP) annotation(
    Line(points = {{-158, 76}, {-120, 76}, {-120, 36}, {-102, 36}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 500, Tolerance = 1e-06, Interval = 0.1),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "rungekutta"));
end E03_PID_parallel_derr_vs_dout;