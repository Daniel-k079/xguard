class MyRequestModel {
  MyRequestModel(
      {this.personToMeet,
      this.permitted,
      this.userID,
      this.docID,
      this.visitDate,
      this.visitReason,
      this.studentName});

  factory MyRequestModel.fromJson(Map<String, dynamic> json) {
    return MyRequestModel(
      userID: json['user_id'],
      docID: json['doc_id'],
      permitted: json['permitted'],
      personToMeet: json['person_to_visit'],
      visitDate: json['visit_date'],
      visitReason: json['visit_reason'],
      studentName: json['student_name'],
    );
  }

  final String? personToMeet,
      docID,
      userID,
      visitDate,
      visitReason,
      studentName;
  final int? permitted;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': userID,
      'permitted': permitted,
      'person_to_meet': personToMeet,
      'visit_date': visitDate,
      'visit_reason': visitReason,
      'student_name': studentName,
    };

    return map..removeWhere((key, value) => value == '' || value == null);
  }
}
