import 'package:args/args.dart';

class Triangle {
  int mod;
  int height;
  List<List<int>> values = [[1]];
  Triangle({required this.mod, required this.height}) {
    assert(mod > 1, "$mod is not valid modulus");
    assert(height > 0, "$height is not a valid height");
    
    while (values.length < height) {
      List<int> left = [0] + values.last;
      List<int> right = values.last + [0];
      List<int> sum = [];
      for (int i = 0; i < left.length; i++) {
        sum.add((left[i] + right[i]) % mod);
      }
      values.add(sum);
    }
  }

  @override
  bool operator ==(Object other) => 
    other is Triangle &&
    mod == other.mod &&
    height == other.height
  ;

  @override
  String toString() => values.map((row) => row.toString()).join("\n");
}

class Color {
  int red;
  int green;
  int blue;
  Color(this.red, this.green, this.blue);

  Color operator +(Color other) => 
}

List<Color> makeColorScheme(int count) {

  return []; // TODO
}

void main(List<String> argStrs) {
  ArgResults args = (ArgParser()
    ..addOption("mod", abbr: 'm', mandatory: true,)
    ..addOption("height", abbr: 'h', mandatory: true,)
    ..addOption("shape", abbr: 's',)
  ).parse(argStrs);
  int mod = int.parse(args.option("mod")!);
  int height = int.parse(args.option("height")!);

  // make a color scheme
  // convert to svg
}