class LoginModel {
  String? nameA;
  String? nameE;
  String? userName;
  String? password;
  String? tel;
  String? email;
  String? mangerNameA;
  String? mangerNameE;
  String? depnameA;
  String? depnameE;
  String? userId;

  LoginModel(
      {this.nameA,
        this.nameE,
        this.userName,
        this.password,
        this.tel,
        this.email,
        this.mangerNameA,
        this.mangerNameE,
        this.depnameA,
        this.depnameE,
        this.userId});

  LoginModel.fromJson(Map<String, dynamic> json) {
    nameA = json['nameA'];
    nameE = json['nameE'];
    userName = json['userName'];
    password = json['password'];
    tel = json['tel'];
    email = json['email'];
    mangerNameA = json['mangerNameA'];
    mangerNameE = json['mangerNameE'];
    depnameA = json['depnameA'];
    depnameE = json['depnameE'];
    userId = json['userId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameA'] = this.nameA;
    data['nameE'] = this.nameE;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['tel'] = this.tel;
    data['email'] = this.email;
    data['mangerNameA'] = this.mangerNameA;
    data['mangerNameE'] = this.mangerNameE;
    data['depnameA'] = this.depnameA;
    data['depnameE'] = this.depnameE;
    data['userId'] = this.userId.toString();
    return data;
  }
}