import 'dart:io';

import 'color.dart';
import 'triangle.dart';

void writeAsSquares({
  required Triangle triangle,
  required List<Color> colors,
  required String filePath,
  /// distance in abstract svg units between the tops of each row (half of the square's diagonal)
  int unit = 1,
}) {
  assert(triangle.mod == colors.length, "${colors.length} colors given for mod ${triangle.mod} triangle");

  // open the file
  IOSink writer = (File("$filePath.svg")..createSync(recursive: true)).openWrite();

  // figure out height and width
  int docHeight = (triangle.height * unit) + 1;
  int docWidth = triangle.height * 2*unit;

  // start writing
  writer.writeln('<svg '
    'width="$docWidth" '
    'height="$docHeight" '
    'style="background-color:${colors[0]}" '
    'xmlns="http://www.w3.org/2000/svg"'
  '>');
  // write each row
  int rowY = 0;
  int rowX = (docWidth ~/ 2) - unit;
  do {
    List<int> row = triangle.current;
    int cellX = rowX;
    for (int value in row) {
      writer.writeln('  <polygon '
        'points="'
          '${cellX + unit},${rowY} ' // top
          '${cellX},${rowY + unit} ' // left
          '${cellX + unit},${rowY + 2*unit} ' // bottom 
          '${cellX + 2*unit},${rowY + unit} ' // right
        '" '
        'style="fill:${colors[value]}"'
      '/>');
      cellX += 2*unit;
    }
    rowY += unit;
    rowX -= unit;
  } while (triangle.moveNext());
  // close document
  writer.writeln('</svg>');
}