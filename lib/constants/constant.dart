const token = 'token';

class SortedHelper {
  final String? sorted;

  /// big to small: desc
  /// small to big: asc
  final String? direction;

  SortedHelper({this.sorted, this.direction});

  Map<String, dynamic> toJson() => {
        'sorted': sorted ?? '',
        'flow': direction ?? '',
      };

  @override
  String toString() => 'sorted=$sorted&flow=$direction';
}
