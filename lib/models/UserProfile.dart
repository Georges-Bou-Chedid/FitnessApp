class UserProfile {
  final String? name;
  final String? phoneNumber;
  final String? gender;
  final int? age;
  final String? country;
  final int? height;
  final int? weight;
  final String? measurementSystem;
  final bool? darkMode;

  UserProfile({this.name, this.phoneNumber, this.gender, this.age, this.country,
    this.height, this.weight, this.measurementSystem, this.darkMode});

  // Factory method to convert data from Firebase to UserProfile
  factory UserProfile.fromMap(Map<String?, dynamic> map) {
    return UserProfile(
      name: map['name'],
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

  UserProfile copyWith(Map<String, dynamic> updateData) {
    return UserProfile(
      name: updateData['name'] ?? name,
      phoneNumber: updateData['phone_number'] ?? phoneNumber,
      gender: updateData['gender'] ?? gender,
      age: updateData['age'] ?? age,
      country: updateData['country'] ?? country,
      height: updateData['height'] ?? height,
      weight: updateData['weight'] ?? weight,
      measurementSystem: updateData['measurement_system'] ?? measurementSystem,
      darkMode: updateData['dark_mode'] ?? darkMode,
    );
  }
}