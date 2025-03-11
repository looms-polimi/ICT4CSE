within ICT4CSE.Courseware.U04_CaseStudy_02;

model Node_Process
  parameter Real[:] nPi = {1} "Internal process numerator";
  parameter Real[:] dPi = {2,1} "Internal process denominator";
  parameter Real[:] nPe = {1} "External process numerator";
  parameter Real[:] dPe = {50,15,1} "External process denominator";
  parameter Real yistart = 0 "Initial valur for internal process output";
  parameter Real yestart = 0 "Initial valur for external process output";
  Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(visible = true, transformation(origin = {-160, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput di annotation(
    Placement(visible = true, transformation(origin = {-60, 60}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput de annotation(
    Placement(visible = true, transformation(origin = {80, 60}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {42, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput ye annotation(
    Placement(visible = true, transformation(origin = {150, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput yi annotation(
    Placement(visible = true, transformation(origin = {150, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction Pi(a = dPi, b = nPi, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = yistart)  annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction Pe(a = dPe, b = nPe, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = yestart)  annotation(
    Placement(visible = true, transformation(origin = {40, 6}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Add adi annotation(
    Placement(visible = true, transformation(origin = {-30, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add ade annotation(
    Placement(visible = true, transformation(origin = {110, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(u, Pi.u) annotation(
    Line(points = {{-160, 0}, {-124, 0}}, color = {0, 0, 127}));
  connect(Pi.y, adi.u2) annotation(
    Line(points = {{-78, 0}, {-42, 0}}, color = {0, 0, 127}));
  connect(adi.y, Pe.u) annotation(
    Line(points = {{-19, 6}, {15, 6}}, color = {0, 0, 127}));
  connect(Pe.y, ade.u2) annotation(
    Line(points = {{62, 6}, {98, 6}}, color = {0, 0, 127}));
  connect(di, adi.u1) annotation(
    Line(points = {{-60, 60}, {-60, 12}, {-42, 12}}, color = {0, 0, 127}));
  connect(de, ade.u1) annotation(
    Line(points = {{80, 60}, {80, 18}, {98, 18}}, color = {0, 0, 127}));
  connect(ade.y, ye) annotation(
    Line(points = {{121, 12}, {149, 12}}, color = {0, 0, 127}));
  connect(adi.y, yi) annotation(
    Line(points = {{-19, 6}, {0, 6}, {0, -30}, {150, -30}}, color = {0, 0, 127}));

annotation(
    Icon(graphics = {Rectangle(fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(extent = {{-100, 100}, {100, -100}}, textString = "P")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end Node_Process;