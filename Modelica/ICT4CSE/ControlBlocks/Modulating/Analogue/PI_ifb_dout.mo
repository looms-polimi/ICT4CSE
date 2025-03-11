within ICT4CSE.ControlBlocks.Modulating.Analogue;

model PI_ifb_dout
  "Analogue output derivation PI with AW by internal feedback"
  extends BaseClasses.SISO_A_SP_PV_CS_200x200;
  
  parameter Real K=1;
  parameter Real Ti=10;
  parameter Real CSmax=1;
  parameter Real CSmin=-1;
  
  Modelica.Blocks.Continuous.TransferFunction Gfb_PI(a = {Ti, 1},
    b = {1})
    annotation(
    Placement(visible = true, transformation(origin = {-10, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback error annotation(
    Placement(visible = true, transformation(origin = {-130, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add pos_fb annotation(
    Placement(visible = true, transformation(origin = {-30, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter sat_PI( uMax = CSmax, uMin = CSmin)  annotation(
    Placement(visible = true, transformation(origin = {10, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain Kgain(k = K)  annotation(
    Placement(visible = true, transformation(origin = {-90, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(SP, error.u1) annotation(
    Line(points = {{-180, 60}, {-138, 60}}, color = {0, 0, 127}));
  connect(PV, error.u2) annotation(
    Line(points = {{-180, 20}, {-130, 20}, {-130, 52}}, color = {0, 0, 127}));
  connect(Gfb_PI.y, pos_fb.u2) annotation(
    Line(points = {{-21, 10}, {-59, 10}, {-59, 48}, {-43, 48}}, color = {0, 0, 127}));
  connect(pos_fb.y, sat_PI.u) annotation(
    Line(points = {{-19, 54}, {-3, 54}}, color = {0, 0, 127}));
  connect(error.y, Kgain.u) annotation(
    Line(points = {{-120, 60}, {-102, 60}}, color = {0, 0, 127}));
  connect(Kgain.y, pos_fb.u1) annotation(
    Line(points = {{-78, 60}, {-42, 60}}, color = {0, 0, 127}));
  connect(sat_PI.y, Gfb_PI.u) annotation(
    Line(points = {{21, 54}, {39, 54}, {39, 10}, {2, 10}}, color = {0, 0, 127}));
  connect(sat_PI.y, CS) annotation(
    Line(points = {{22, 54}, {80, 54}, {80, 60}, {190, 60}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Text(origin = {0, -3}, extent = {{-100, 85}, {100, -85}}, textString = "PI
dout
ifb")}));
end PI_ifb_dout;