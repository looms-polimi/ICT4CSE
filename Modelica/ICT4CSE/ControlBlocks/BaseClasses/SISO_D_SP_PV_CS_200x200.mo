within ICT4CSE.ControlBlocks.BaseClasses;

partial model SISO_D_SP_PV_CS_200x200
  "SISO digital controller with Set Point and Process Variable inputs and Control Signal output"
  extends Icons.DigitalController_200x200;
  
  parameter Real Ts;
  
  Modelica.Blocks.Interfaces.RealInput SP annotation(
    Placement(visible = true, transformation(origin = {-180, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput PV annotation(
    Placement(visible = true, transformation(origin = {-180, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput CS annotation(
    Placement(visible = true, transformation(origin = {190, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  Real w,y,u;

equation

  w = SP;
  y = PV;
  u = CS;
  
annotation(
    Icon(graphics = {Text(origin = {0, -120}, extent = {{-140, 20}, {140, -20}}, textString = "%name")}));
end SISO_D_SP_PV_CS_200x200;