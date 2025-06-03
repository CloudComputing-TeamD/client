class UserData {
  String workoutLevel;
  String goal;
  List<String> targetParts;
  int frequency;

  UserData({
    this.workoutLevel = '',
    this.goal = '',
    this.targetParts = const [],
    this.frequency = 0,
  });
}
