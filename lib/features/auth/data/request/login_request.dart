
class LoginRequest {
  String? phoneOrEmail;
  String? password;
  String? code;


  LoginRequest({
    this.phoneOrEmail ,
    this.password ,
    this.code,

  }) ;

  LoginRequest copyWith({
    String? phoneOrEmail,
    String? password,

  }) {
    return LoginRequest(
      phoneOrEmail: phoneOrEmail ?? this.phoneOrEmail,
      password: password ?? this.password,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': phoneOrEmail,
      'password': password,
      'confirmation_code': code,
    };
  }
}
