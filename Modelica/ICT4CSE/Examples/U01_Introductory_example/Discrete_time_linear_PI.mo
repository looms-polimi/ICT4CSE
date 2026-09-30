within ICT4CSE.Examples.U01_Introductory_example;

model Discrete_time_linear_PI
  extends Icons.ExampleModel;
  parameter Real K=1 "Gain";
  parameter Real Ti=1 "Integral time";
  parameter Real Ts=0.01"Sampling time";

  Modelica.Blocks.Interfaces.RealInput w annotation(
    Placement(visible = true, transformation(origin = {-122, 42}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 42}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput y annotation(
    Placement(visible = true, transformation(origin = {-120, -38}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput u annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  Real e,up,ui,ui_prev;
equation

algorithm
  when sample(0,Ts) then
       e  := w-y;
       up := K*e;
       ui := ui_prev+K*Ts/Ti*e;
       u  := up+ui;
       ui_prev := ui;
  end when;

end Discrete_time_linear_PI;