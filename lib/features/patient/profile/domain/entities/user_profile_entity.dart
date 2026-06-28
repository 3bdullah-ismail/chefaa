class UserProfileEntity {
  final String? userName;
  final String? userAddress;
  final num? age;
  final String? userGender;
  final num? userHeight;
  final num? userWeight;
  final String? userBloodType;
  final List<String>? allergiesList;
  final List<String>? chronicConditionsList;

  UserProfileEntity({
    required this.userName,
    required this.userAddress,
    required this.age,
    required this.userGender,
    required this.userHeight,
    required this.userWeight,
    required this.userBloodType,
    required this.allergiesList,
    required this.chronicConditionsList,
  });
}
