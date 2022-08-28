class AuthUserModel {
  AuthUserModel(
      {this.emailAddress, this.password, this.fullNames, this.studentNumber});

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      emailAddress: json['email_address'],
      password: json['password'],
      studentNumber: json['student_number'],
      fullNames: json['full_names'],
    );
  }

  final String? emailAddress, password, studentNumber, fullNames;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'email_address': emailAddress,
      'password': password,
      'full_names': fullNames,
      'student_number': studentNumber
    };

    return map..removeWhere((key, value) => value == '' || value == null);
  }
}
