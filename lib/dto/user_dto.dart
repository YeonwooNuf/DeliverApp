//users를  json형태로 스프링 부트 프로젝트에 전송해서 DB에 저장하는 코드
class UserDto {
  final String userId;
  final String password;
  final String name;
  final String phone;
  final String email;

  UserDto({
    required this.userId,
    required this.password,
    required this.name,
    required this.phone,
    required this.email,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    if (json['userId'] == null ||
        json['password'] == null ||
        json['name'] == null ||
        json['phone'] == null ||
        json['email'] == null) {
      throw FormatException("Invalid JSON data: missing required fields");
    }

    return UserDto(
      userId: json['userId'],
      password: json['password'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'password': password,
        'name': name,
        'phone': phone,
        'email': email,
      };

  @override
  String toString() {
    return 'UserDto(userId: $userId, password: $password, name: $name, phone: $phone, email: $email)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDto &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          password == other.password &&
          name == other.name &&
          phone == other.phone &&
          email == other.email;

  @override
  int get hashCode =>
      userId.hashCode ^
      password.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      email.hashCode;
}
