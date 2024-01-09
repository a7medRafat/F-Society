class RegisterBody {
  String? name;
  String? email;
  String? password;
  String? phone;


  RegisterBody({
    required this.name,
    required this.email,
    this.password,
    required this.phone,

  });

  RegisterBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}
