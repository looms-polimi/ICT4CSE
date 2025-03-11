within ICT4CSE.ControlBlocks.Modulating.Analogue;

model PID_parallel_dout
  "Analogue parallel PID with error derivation and AW by integral action recomputation"
  extends BaseClasses.SISO_A_SP_PV_CS_200x200;
  parameter Real K = 1;
  parameter Real Ti = 10;
  parameter Real Td = 1;
  parameter Real N = 4;
  parameter Real CSmax = 1;
  parameter Real CSmin = -1;
  Modelica.Blocks.Math.Gain up(k = K)  annotation(
    Placement(visible = true, transformation(origin = {-90, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain dui(k = K / Ti * tau)  annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback error annotation(
    Placement(visible = true, transformation(origin = {-130, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add pos_fb annotation(
    Placement(visible = true, transformation(origin = {-50, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction Gfb_I(a = {tau, 1}, b = {1})  annotation(
    Placement(visible = true, transformation(origin = {-30, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter sat(uMax = CSmax, uMin = CSmin)  annotation(
    Placement(visible = true, transformation(origin = {70, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction GD(a = {Td / N, 1}, b = {-K * Td, 0})  annotation(
    Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add_pid annotation(
    Placement(visible = true, transformation(origin = {24, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 state_I(k2 = -1, k3 = -1)  annotation(
    Placement(visible = true, transformation(origin = {50, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
protected
  final parameter Real tau=if Td>0 then Td/10 else Ti/100;

equation
  connect(SP, error.u1) annotation(
    Line(points = {{-180, 60}, {-138, 60}}, color = {0, 0, 127}));
  connect(PV, error.u2) annotation(
    Line(points = {{-180, 20}, {-130, 20}, {-130, 52}}, color = {0, 0, 127}));
  connect(error.y, up.u) annotation(
    Line(points = {{-120, 60}, {-102, 60}}, color = {0, 0, 127}));
  connect(dui.y, pos_fb.u1) annotation(
    Line(points = {{-79, 10}, {-63, 10}}, color = {0, 0, 127}));
  connect(Gfb_I.y, pos_fb.u2) annotation(
    Line(points = {{-41, -30}, {-71, -30}, {-71, -2}, {-63, -2}}, color = {0, 0, 127}));
  connect(error.y, dui.u) annotation(
    Line(points = {{-120, 60}, {-110, 60}, {-110, 10}, {-102, 10}}, color = {0, 0, 127}));
  connect(pos_fb.y, add_pid.u2) annotation(
    Line(points = {{-38, 4}, {12, 4}}, color = {0, 0, 127}));
  connect(GD.y, add_pid.u3) annotation(
    Line(points = {{-78, -70}, {0, -70}, {0, -4}, {12, -4}}, color = {0, 0, 127}));
  connect(up.y, add_pid.u1) annotation(
    Line(points = {{-78, 60}, {0, 60}, {0, 12}, {12, 12}}, color = {0, 0, 127}));
  connect(add_pid.y, sat.u) annotation(
    Line(points = {{36, 4}, {58, 4}}, color = {0, 0, 127}));
  connect(sat.y, CS) annotation(
    Line(points = {{82, 4}, {140, 4}, {140, 60}, {190, 60}}, color = {0, 0, 127}));
  connect(sat.y, state_I.u1) annotation(
    Line(points = {{82, 4}, {100, 4}, {100, -22}, {62, -22}}, color = {0, 0, 127}));
  connect(up.y, state_I.u2) annotation(
    Line(points = {{-78, 60}, {120, 60}, {120, -30}, {62, -30}}, color = {0, 0, 127}));
  connect(GD.y, state_I.u3) annotation(
    Line(points = {{-78, -70}, {80, -70}, {80, -38}, {62, -38}}, color = {0, 0, 127}));
  connect(state_I.y, Gfb_I.u) annotation(
    Line(points = {{40, -30}, {-18, -30}}, color = {0, 0, 127}));
  connect(PV, GD.u) annotation(
    Line(points = {{-180, 20}, {-130, 20}, {-130, -70}, {-102, -70}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Text(origin = {-1, -1}, extent = {{81, -87}, {-81, 87}}, textString = "PID
parallel
derr")}));
end PID_parallel_dout;