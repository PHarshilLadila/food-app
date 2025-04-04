class DemoModel {
  String? status;
  List<Data>? data;
  String? message;

  DemoModel({this.status, this.data, this.message});

  DemoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  String? employeeName;
  int? employeeSalary;
  int? employeeAge;
  String? profileImage;

  Data(
      {this.id,
      this.employeeName,
      this.employeeSalary,
      this.employeeAge,
      this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeName = json['employee_name'];
    employeeSalary = json['employee_salary'];
    employeeAge = json['employee_age'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['employee_name'] = employeeName;
    data['employee_salary'] = employeeSalary;
    data['employee_age'] = employeeAge;
    data['profile_image'] = profileImage;
    return data;
  }
}
