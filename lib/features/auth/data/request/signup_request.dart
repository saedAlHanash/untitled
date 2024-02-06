

class SignupRequest {
  SignupRequest({
    this.name ,

    this.phoneOrEmail ,
    this.password ,
  });

  String? name;

  String? phoneOrEmail;
  String? password;
  String? rePassword;


  //--------
  bool? isAcceptPolicy = false;

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": phoneOrEmail,
        "password": password,

      };

}
