class UserProfile {
  final String name;
  final String userName;
  final String phoneNumber;
  final String gender;
  final int age;
  final String country;
  final int height;
  final int weight;
  final String measurementSystem;

  UserProfile({required this.name, required this.userName, required this.phoneNumber, required this.gender, required this.age, required this.country,
    required this.height, required this.weight, required this.measurementSystem});

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
    );
  }
}