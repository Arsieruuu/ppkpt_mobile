class Profile {
  final String? nim;
  final String? fullName;
  final String? jurusan;
  final String? phoneNumber;

  Profile({
    this.nim,
    this.fullName,
    this.jurusan,
    this.phoneNumber,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      nim: json['nim'],
      fullName: json['full_name'],
      jurusan: json['jurusan'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nim': nim,
      'full_name': fullName,
      'jurusan': jurusan,
      'phone_number': phoneNumber,
    };
  }

  bool get isComplete =>
      nim != null &&
      nim!.isNotEmpty &&
      fullName != null &&
      fullName!.isNotEmpty &&
      jurusan != null &&
      jurusan!.isNotEmpty &&
      phoneNumber != null &&
      phoneNumber!.isNotEmpty;
}

class User {
  final int id;
  final String identityNumber;
  final String role;
  final Profile? profile;

  User({
    required this.id,
    required this.identityNumber,
    required this.role,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      identityNumber: json['identity_number'],
      role: json['role'],
      profile: json['profile'] != null 
          ? Profile.fromJson(json['profile']) 
          : null,
    );
  }
}
