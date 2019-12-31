class LoginModel {
  bool status;
  String message;
  List<LoginData> data;
  LoginModel({this.status, this.message, this.data});

  LoginModel.map(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<LoginData>();
      json['data'].forEach((v) {
        data.add(new LoginData.map(v));
      });
    }
  }
}

class LoginData {
  int id;
  String firstname;
  String lastname;
  String email;
  String mobile;
  String latitude;
  String longitude;
  String profilePicture;

  LoginData(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.mobile,
      this.latitude,
      this.longitude,
      this.profilePicture});

  LoginData.map(dynamic json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    mobile = json['mobile'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    profilePicture = json['profile_picture'];
  }
}