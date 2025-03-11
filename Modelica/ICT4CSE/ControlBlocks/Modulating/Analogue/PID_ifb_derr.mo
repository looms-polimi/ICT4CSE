within ICT4CSE.ControlBlocks.Modulating.Analogue;

model PID_ifb_derr
  "Analogue 1-dof PID with AW by internal feedback"
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
  
  Modelica.Blocks.Continuous.TransferFunction Gfb
   (a = {(K * N + K) * Td * Ti, K * N * Ti + K * Td, K * N},
    b = {(K * N + K - 1) * Td * Ti, (K - 1) * N * Ti + K * Td, K * N})
    annotation(
    Placement(visible = true, transformation(origin = {-30, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback error annotation(
    Placement(visible = true, transformation(origin = {-130, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add pos_fb annotation(
    Placement(visible = true, transformation(origin = {-70, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter saturation( uMax = CSmax, uMin = CSmin)  annotation(
    Placement(visible = true, transformation(origin = {-30, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(SP, error.u1) annotation(
    Line(points = {{-180, 60}, {-138, 60}}, color = {0, 0, 127}));
  connect(PV, error.u2) annotation(
    Line(points = {{-180, 20}, {-130, 20}, {-130, 52}}, color = {0, 0, 127}));
  connect(error.y, pos_fb.u1) annotation(
    Line(points = {{-120, 60}, {-82, 60}}, color = {0, 0, 127}));
  connect(Gfb.y, pos_fb.u2) annotation(
    Line(points = {{-40, 10}, {-100, 10}, {-100, 48}, {-82, 48}}, color = {0, 0, 127}));
  connect(pos_fb.y, saturation.u) annotation(
    Line(points = {{-58, 54}, {-42, 54}}, color = {0, 0, 127}));
  connect(saturation.y, CS) annotation(
    Line(points = {{-18, 54}, {20, 54}, {20, 60}, {190, 60}}, color = {0, 0, 127}));
  connect(saturation.y, Gfb.u) annotation(
    Line(points = {{-18, 54}, {20, 54}, {20, 10}, {-18, 10}}, color = {0, 0, 127}));
annotation(
    Icon(graphics = {Text(origin = {0, -3}, extent = {{-100, 85}, {100, -85}}, textString = "PID
1dof
ifb")}));
end PID_ifb_derr;