class ProfileModel {
  final String? uid;
  final String? email;
  final String? fname;
  final String? lname;
  final String? location;
  final String? mobile;
  final String? name;
  final String? profileImage;

  ProfileModel({
    this.uid,
    this.email,
    this.fname,
    this.lname,
    this.location,
    this.mobile,
    this.name,
    this.profileImage,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> data) {
    return ProfileModel(
      uid: data["uid"] ?? "",
      email: data["email"] ?? "",
      fname: data["fname"] ?? "",
      lname: data["lname"] ?? "",
      location: data["location"] ?? "",
      mobile: data["mobile"] ?? "",
      name: data["name"] ?? "",
      profileImage: data["profileImage"] ?? "",
    );
  }
}
