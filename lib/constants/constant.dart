const token = 'token';

class Helper {
  final String? sorted;

  /// big to small: desc
  /// small to big: asc
  final String? direction;
  final int? limit;
  final String? query;

  Helper({this.query, this.sorted, this.direction, this.limit});

  Map<String, dynamic> toJson() => {
        'query': query,
        'sorted': sorted,
        'flow': direction,
        'limit': limit == null ? null : '$limit',
      };
}

class Messenger {
  final String mess;
  const Messenger(this.mess);

  @override
  String toString() {
    return mess;
  }
}
