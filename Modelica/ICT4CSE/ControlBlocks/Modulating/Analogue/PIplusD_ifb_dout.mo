within ICT4CSE.ControlBlocks.Modulating.Analogue;

model PIplusD_ifb_dout
  "Analogue output derivation PIplusD with AW by internal feedback in the PI part"
  extends BaseClasses.SISO_A_SP_PV_CS_200x200;
  
  parameter Real K=1;
  parameter Real Ti=10;
  parameter Real Td=1;
  parameter Real N=4;
  parameter Real CSmax=1;
  parameter Real CSmin=-1;
  
  /* Maxima:
    C : K*(1+1/s/Ti+s*Td/(1+s*Td/N));
        rat(solve(1/(1-Gfb)=C,Gfb),s);
  */
  
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
  Modelica.Blocks.Nonlinear.Limiter sat_out( uMax = CSmax, uMin = CSmin) annotation(
    Placement(visible = true, transformation(origin = {110, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add_PI_D annotation(
    Placement(visible = true, transformation(origin = {70, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain Kgain(k = K)  annotation(
    Placement(visible = true, transformation(origin = {-90, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction GD(a = {Td / N, 1}, b = {Td, 0}) annotation(
    Placement(visible = true, transformation(origin = {-10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain mKgain(k = -K) annotation(
    Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
  connect(sat_PI.y, add_PI_D.u1) annotation(
    Line(points = {{22, 54}, {58, 54}}, color = {0, 0, 127}));
  connect(GD.y, add_PI_D.u2) annotation(
    Line(points = {{2, -30}, {50, -30}, {50, 42}, {58, 42}}, color = {0, 0, 127}));
  connect(add_PI_D.y, sat_out.u) annotation(
    Line(points = {{82, 48}, {98, 48}}, color = {0, 0, 127}));
  connect(sat_out.y, CS) annotation(
    Line(points = {{122, 48}, {140, 48}, {140, 60}, {190, 60}}, color = {0, 0, 127}));
  connect(PV, mKgain.u) annotation(
    Line(points = {{-180, 20}, {-130, 20}, {-130, -30}, {-102, -30}}, color = {0, 0, 127}));
  connect(mKgain.y, GD.u) annotation(
    Line(points = {{-79, -30}, {-22, -30}}, color = {0, 0, 127}));
annotation(
    Icon(graphics = {Text(origin = {0, -3}, extent = {{-100, 85}, {100, -85}}, textString = "PID
dout
ifb-PI")}));
end PIplusD_ifb_dout;