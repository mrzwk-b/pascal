class Color {
  final int r;
  final int g;
  final int b;
  const Color(red, green, blue):
    r = red % 256,
    g = green % 256,
    b = blue % 256
  ;

  Color operator +(Color other) => Color(r + other.r, g + other.g, b + other.b);
  Color operator -(Color other) => Color(r - other.r, g - other.g, b - other.b);
  Color operator *(int multiplier) => Color(r * multiplier, g * multiplier, b * multiplier);
  Color operator ~/(int dividend) => Color(r ~/ dividend, g ~/ dividend, b ~/ dividend);
  Color operator %(int modulus) => Color(r % modulus, g % modulus, b % modulus);

  @override
  String toString() => "#"
    "${r.toRadixString(16).padLeft(2, '0')}"
    "${g.toRadixString(16).padLeft(2, '0')}"
    "${b.toRadixString(16).padLeft(2, '0')}"
  ;
}

List<Color> makeColorScheme(int count) {
  // i want this to be better
  // but it'll have to do for now while i build the more important stuff
  // also it doesn't work past 8
  return [
    Color(0, 0, 0),
    Color(255, 255, 255),
    Color(255, 0, 0),
    Color(0, 255, 0),
    Color(0, 0, 255),
    Color(0, 255, 255),
    Color(255, 0, 255),
    Color(255, 255, 0),
  ].take(count).toList();
}