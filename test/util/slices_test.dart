import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/util/slices.dart';

void main() {
  test("test list splicing", () {
    expect(partition([1, 2, 3, 4], 1), [[1], [2], [3], [4]]);
    expect(partition([1, 2, 3, 4], 2), [[1, 2], [3, 4]]);
    expect(partition([1, 2, 3, 4], 3), [[1, 2, 3], [4]]);
  });
}