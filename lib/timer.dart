class SetTime {
  final int hour;
  final int minute;
  final int second;

  SetTime({this.hour = 0, this.minute = 0, this.second = 0});

  @override
  String toString() => 'SetTime(hour: $hour, minute: $minute, second: $second)';
}
