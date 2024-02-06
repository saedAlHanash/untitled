
class ForgetPassRequestRequest {
  String? phoneOrEmail;
  // String? password;
  // String? code;


  ForgetPassRequestRequest({
    this.phoneOrEmail ,
    // this.password ,
    // this.code,

  }) ;

  ForgetPassRequestRequest copyWith({
    String? phoneOrEmail,
    // String? password,

  }) {
    return ForgetPassRequestRequest(
      phoneOrEmail: phoneOrEmail ?? this.phoneOrEmail,
      // password: password ?? this.password,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': phoneOrEmail,
      // 'password': password,

    };
  }
}
