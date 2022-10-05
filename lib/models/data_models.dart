class MyRequestModel {
  MyRequestModel(
      {this.personToMeet, this.visitDate, this.visitReason, this.studentName});

  factory MyRequestModel.fromJson(Map<String, dynamic> json) {
    return MyRequestModel(
      personToMeet: json['person_to_visit'],
      visitDate: json['visit_date'],
      visitReason: json['visit_reason'],
      studentName: json['student_name'],
    );
  }

  final String? personToMeet, visitDate, visitReason, studentName;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'person_to_meet': personToMeet,
      'visit_date': visitDate,
      'visit_reason': visitReason,
      'student_name': studentName,
    };

    return map..removeWhere((key, value) => value == '' || value == null);
  }
}
