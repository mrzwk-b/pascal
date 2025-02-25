class Triangle implements Iterator<List<int>> {
  int mod;
  int height;
  List<int> values = [1];
  Triangle({required this.mod, required this.height}) {
    assert(mod > 1, "$mod is not valid modulus");
    assert(height > 0, "$height is not a valid height");
  }

  @override
  get current => values;
  
  @override
  bool moveNext() {
    if (values.length >= height) return false;
    List<int> left = [0] + values;
    List<int> right = values + [0];
    values = [];
    for (int i = 0; i < left.length; i++) {
      values.add((left[i] + right[i]) % mod);
    }
    return true;
  }
}