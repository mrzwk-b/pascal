import 'dart:math';

class Color {
  final int r;
  final int g;
  final int b;
  const Color(red, green, blue):
    r = red % 256,
    g = green % 256,
    b = blue % 256
  ;
  Color.random():
    r = Random().nextInt(255),
    g = Random().nextInt(255),
    b = Random().nextInt(255)
  ;

  Color operator +(Color other) => Color(r + other.r, g + other.g, b + other.b);
  Color operator -(Color other) => Color(r - other.r, g - other.g, b - other.b);
  Color operator *(int multiplier) => Color(r * multiplier, g * multiplier, b * multiplier);
  Color operator ~/(int dividend) => Color(r ~/ dividend, g ~/ dividend, b ~/ dividend);
  Color operator %(int modulus) => Color(r % modulus, g % modulus, b % modulus);

  num magnitudeDifference(Color other) => sqrt(
    pow(r - other.r, 2) +
    pow(g - other.g, 2) +
    pow(b - other.b, 2)
  );

  @override
  String toString() => "#"
    "${r.toRadixString(16).padLeft(2, '0')}"
    "${g.toRadixString(16).padLeft(2, '0')}"
    "${b.toRadixString(16).padLeft(2, '0')}"
  ;

  @override
  bool operator ==(Object other) => 
    other is Color && r == other.r && g == other.g && b == other.b
  ;

  @override
  int get hashCode => ((((r + 17) * g) + 31) * b) + 127;
}

int powerCount(int n, {required int base}) {
  int power = 0;
  int current = 1;
  while (current <= n) {
    current *= base;
    power++;
  }
  return power - 1;
}

/// uses trial division, we expect to work with small numbers
Map<int, int> primeFactorization(int n) {
  Map<int, int> factorization = {};
  if (n % 2 == 0) {
    factorization[2] = powerCount(n, base: 2);
  }
  for (int potentialFactor = 3; potentialFactor < sqrt(n); potentialFactor += 2) {
    if (n % potentialFactor == 0) {
      factorization[potentialFactor] = powerCount(n, base: potentialFactor);
    }
  }
  return factorization;
}

Set<Color> getComplementaries(int count, {Set<Color> used = const {}}) {
  // i feel like better can be done but this will have to do for now
  final Color interval = Color(256 ~/ count, 256 ~/ count, 256 ~/ count);
  Set<Color> output = {};
  Color current = Color.random();
  while (output.length < count) {
    if (used.contains(current)) {
      output = {};
      current = Color.random();
    }
    else {
      output.add(current);
      current += interval;
    }
  }
  return output;
}

List<Color> makeColorScheme(int count) {
  Map<int, int> factorization = primeFactorization(count);
  Set<Color> usedColors = {};
  List<Color?> colors = List.filled(count, null);
  colors[0] = Color(0, 0, 0);
  colors[1] = Color(255, 255, 255);
  int remaining = count - 2;
  for (MapEntry<int, int> factor in factorization.entries) {
    int index = factor.key;
    for (Color color in getComplementaries((count ~/ factor.key) - 1, used: usedColors)) {
      colors[index] = color;
      usedColors.add(color);
      index += factor.key;
      remaining -= 1;
    }
  }
  for (Color color in getComplementaries(remaining, used: usedColors)) {
    colors[colors.indexWhere((element) => element == null)] = color;
  }
  return colors.map((color) => color!).toList();
}