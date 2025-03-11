within ICT4CSE.ControlBlocks.BaseClasses;

partial model SISO_A_SP_PV_CS_200x400
  "SISO analogue controller with Set Point and Process Variable inputs and Control Signal output"
  extends Icons.AnalogueController_200x400;
  
  Modelica.Blocks.Interfaces.RealInput SP annotation(
    Placement(visible = true, transformation(origin = {-180, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 160}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput PV annotation(
    Placement(visible = true, transformation(origin = {-180, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput CS annotation(
    Placement(visible = true, transformation(origin = {190, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, 160}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  Real w,y,u;

equation

  w = SP;
  y = PV;
  u = CS;
  
annotation(
    Icon(graphics = {Text(origin = {-2, -220}, extent = {{-140, 20}, {140, -20}}, textString = "%name")}));
end SISO_A_SP_PV_CS_200x400;