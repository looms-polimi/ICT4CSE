within ICT4CSE.Courseware.U04_CaseStudy_02;

model __Node_ModulatingControl
  parameter Real Ki=1;
  parameter Real Tii=2;
  parameter Real Tdi=0;
  parameter Real Ni=1;
  parameter Real bi=1;
  parameter Real ci=0;
  parameter Real Ke=1;
  parameter Real Tie=10;
  parameter Real Tde=2;
  parameter Real Ne=4;
  parameter Real be=1;
  parameter Real ce=0;
  parameter Real umax=1;
  parameter Real umin=-1;
  parameter Real Ts=0.1;

  Modelica.Blocks.Interfaces.RealOutput u annotation(
    Placement(visible = true, transformation(origin = {140, 52}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput ye annotation(
    Placement(visible = true, transformation(origin = {-130, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 0), iconTransformation(origin = {-40, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput yi annotation(
    Placement(visible = true, transformation(origin = {-10, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  ICT4CSE.ControlBlocks.Modulating.Digital.PID_ISA_2dof_bias_tracking_locks_ovr PIDe(CSmax = Modelica.Constants.inf, CSmin = -Modelica.Constants.inf, K = Ke, N = Ne, Td = Tde, Ti = Tie, Ts = Ts, b = be, c = ce,hasLocks = true, hasTracking = true)  annotation(
    Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-20, -40}, {20, 40}}, rotation = 0)));
  ICT4CSE.ControlBlocks.Modulating.Digital.PID_ISA_2dof_bias_tracking_locks_ovr PIDi(CSmax = umax, CSmin = umin, K = Ki, N = Ni, Td = Tdi, Ti = Tii, Ts = Ts, b = bi, c = ci,hasLocks = false, hasTracking = true)  annotation(
    Placement(visible = true, transformation(origin = {60, 20}, extent = {{-20, -40}, {20, 40}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput we annotation(
    Placement(visible = true, transformation(origin = {-130, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput TRK annotation(
    Placement(visible = true, transformation(origin = {-130, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput uTRK annotation(
    Placement(visible = true, transformation(origin = {-10, 22}, extent = {{-10, 10}, {10, -10}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(PIDe.CS, PIDi.SP) annotation(
    Line(points = {{-36, 52}, {36, 52}}, color = {0, 0, 127}));
  connect(yi, PIDi.PV) annotation(
    Line(points = {{-10, 40}, {36, 40}}, color = {0, 0, 127}));
  connect(ye, PIDe.PV) annotation(
    Line(points = {{-130, 40}, {-84, 40}}, color = {0, 0, 127}));
  connect(PIDi.HIsat, PIDe.noInc) annotation(
    Line(points = {{84, 12}, {100, 12}, {100, -40}, {-100, -40}, {-100, 14}, {-84, 14}}, color = {255, 0, 255}));
  connect(PIDi.LOsat, PIDe.noDec) annotation(
    Line(points = {{84, 4}, {94, 4}, {94, -34}, {-94, -34}, {-94, 6}, {-84, 6}}, color = {255, 0, 255}));
  connect(PIDi.CS, u) annotation(
    Line(points = {{84, 52}, {140, 52}}, color = {0, 0, 127}));
  connect(we, PIDe.SP) annotation(
    Line(points = {{-130, 52}, {-84, 52}}, color = {0, 0, 127}));
  connect(uTRK, PIDi.TR) annotation(
    Line(points = {{-10, 22}, {36, 22}}, color = {0, 0, 127}));
  connect(TRK, PIDi.TS) annotation(
    Line(points = {{-130, -52}, {-20, -52}, {-20, 30}, {36, 30}}, color = {255, 0, 255}));
  connect(TRK, PIDe.TS) annotation(
    Line(points = {{-130, -52}, {-112, -52}, {-112, 30}, {-84, 30}}, color = {255, 0, 255}));
  connect(yi, PIDe.TR) annotation(
    Line(points = {{-10, 40}, {10, 40}, {10, -46}, {-106, -46}, {-106, 22}, {-84, 22}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Rectangle(fillColor = {170, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(extent = {{-100, 100}, {100, -100}}, textString = "MC")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end __Node_ModulatingControl;