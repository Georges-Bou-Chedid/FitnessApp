class UserProfile {
  final String? name;
  final String? userName;
  final String? phoneNumber;
  final String? gender;
  final int? age;
  final String? country;
  final int? height;
  final int? weight;
  final String? measurementSystem;
  final bool? darkMode;

  UserProfile({this.name, this.userName, this.phoneNumber, this.gender, this.age, this.country,
    this.height, this.weight, this.measurementSystem, this.darkMode});

  // Factory method to convert data from Firebase to UserProfile
  factory UserProfile.fromMap(Map<String?, dynamic> map) {
    return UserProfile(
      name: map['name'],
      userName: map['user_name'],
      phoneNumber: map['phone_number'],
      gender: map['gender'],
      age: map['age'],
      country: map['country'],
      height: map['height'],
      weight: map['weight'],
      measurementSystem: map['measurement_system'],
      darkMode: map['dark_mode']
    );
  }
}