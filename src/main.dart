import 'dart:io';
import 'package:args/args.dart';
import 'color.dart';
import 'svg_writer.dart';
import 'triangle.dart';

void main(List<String> argStrs) {
  ArgResults args = (ArgParser()
    ..addOption("mod", abbr: 'm', mandatory: true,)
    ..addOption("height", abbr: 'h', mandatory: true,)
    ..addOption("fileName", abbr: 'n', mandatory: true,)
    ..addOption("shape", abbr: 's',)
  ).parse(argStrs);
  int mod = int.parse(args.option("mod")!);
  int height = int.parse(args.option("height")!);
  String fileName = args.option("fileName")!;
  
  writeAsSquares(
    triangle: Triangle(mod: mod, height: height),
    colors: makeColorScheme(mod),
    filePath: [".", "output", fileName].join(Platform.pathSeparator)
  );
}