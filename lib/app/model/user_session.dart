class UserSession {
  String? email;
  bool? isLogin;
  bool? isViaGoogle;
  UserSession({this.email, this.isLogin, this.isViaGoogle});

   factory UserSession.fromJson(Map<String, dynamic> json) => UserSession(
        email: json["email"],
        isLogin: json["isLogin"],
        isViaGoogle: json["isViaGoogle"]
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "isLogin": isLogin,
        "isViaGoogle": isViaGoogle
    };
}