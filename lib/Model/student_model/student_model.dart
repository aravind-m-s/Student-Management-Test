class StudentModel {
  String id;
  String name;
  String qualification;
  String email;
  String gender;
  String mobile;
  String file;
  StudentModel({
    required this.id,
    required this.name,
    required this.qualification,
    required this.email,
    required this.gender,
    required this.mobile,
    required this.file,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'qualification': qualification,
        'email': email,
        'gender': gender,
        'mobile': mobile,
        'file': file,
      };
  factory StudentModel.fromJson(json) {
    return StudentModel(
      file: json['file'],
      email: json['email'],
      id: json['id'],
      name: json['name'],
      qualification: json['qualification'],
      gender: json['gender'],
      mobile: json['mobile'],
    );
  }
}
