class UserData {
  String? id;
  String? name;
  String? goal;
  String? workoutLevel;
  List<String>? targetParts;
  int? frequency;

  String? gender;
  int? height;
  int? weight;
  DateTime? birthDate;

  String? email;
  String? token;

  UserData({
    this.id = '',
    this.name = '',
    this.goal = '',
    this.workoutLevel = '',
    this.targetParts = const [],
    this.frequency = 0,
    this.gender = '',
    this.height = 0,
    this.weight = 0,
    this.birthDate,
    this.email = '',
    this.token = '',
  });
  @override
  String toString() {
    return 'UserData(id: $id, email: $email, token: $token)';
  }
}
