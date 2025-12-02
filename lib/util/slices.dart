List<List<T>> partition<T>(List<T> list, int partitionSize) {
  if (partitionSize > list.length) {
    return [list];
  }

  List<List<T>> result =
      List.generate((list.length / partitionSize).ceil(), (_) => []);

  result[0].add(list.first);

  for (var i = 1; i < list.length; i++) {
    result[(i ~/ partitionSize)].add(list[i]);
  }

  return result;
}
