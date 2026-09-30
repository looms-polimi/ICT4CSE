within ICT4CSE.Examples.U04_CaseStudy_02;

model CompleteSystem
  ICT4CSE.Examples.U04_CaseStudy_02.Node_Process Process annotation(
    Placement(visible = true, transformation(origin = {59, -1}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
  ICT4CSE.Examples.U04_CaseStudy_02.Node_ModulatingControl ModulatingControl annotation(
    Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Sources.Trapezoid we(amplitude = 0.4, falling = 5, offset = 0.4, period = 50, rising = 5, startTime = 50, width = 20) annotation(
    Placement(visible = true, transformation(origin = {-148, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression annotation(
    Placement(visible = true, transformation(origin = {-170, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression annotation(
    Placement(visible = true, transformation(origin = {-172, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ModulatingControl.u, Process.u) annotation(
    Line(points = {{-16, 0}, {34, 0}}, color = {0, 0, 127}));
  connect(Process.ye, ModulatingControl.ye) annotation(
    Line(points = {{84, 8}, {110, 8}, {110, -50}, {-48, -50}, {-48, -24}}, color = {0, 0, 127}));
  connect(Process.yi, ModulatingControl.yi) annotation(
    Line(points = {{84, -10}, {100, -10}, {100, -40}, {-32, -40}, {-32, -24}}, color = {0, 0, 127}));
  connect(realExpression.y, ModulatingControl.uTRK) annotation(
    Line(points = {{-158, -52}, {-96, -52}, {-96, -12}, {-64, -12}}, color = {0, 0, 127}));
  connect(realExpression.y, Process.di) annotation(
    Line(points = {{-158, -52}, {-96, -52}, {-96, 58}, {50, 58}, {50, 24}}, color = {0, 0, 127}));
  connect(realExpression.y, Process.de) annotation(
    Line(points = {{-158, -52}, {-96, -52}, {-96, 58}, {68, 58}, {68, 24}}, color = {0, 0, 127}));
  connect(we.y, ModulatingControl.we) annotation(
    Line(points = {{-137, 12}, {-64, 12}}, color = {0, 0, 127}));
  connect(booleanExpression.y, ModulatingControl.TRK) annotation(
    Line(points = {{-160, -28}, {-114, -28}, {-114, 0}, {-64, 0}}, color = {255, 0, 255}));
  annotation(
    Icon(graphics = {Rectangle(fillColor = {228, 230, 231}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(extent = {{-100, 100}, {100, -100}}, textString = "S")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.04),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=none -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end CompleteSystem;