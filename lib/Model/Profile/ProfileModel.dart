class ProfileGet {
  dynamic userid;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic jobtitle;
  dynamic profileimg;
  dynamic location;
  dynamic website;
  dynamic about;
  dynamic success;
  dynamic message;

  ProfileGet(
      {this.userid,
      this.name,
      this.email,
      this.phone,
      this.jobtitle,
      this.profileimg,
      this.location,
      this.website,
      this.about,
      this.success,
      this.message});

  ProfileGet.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    jobtitle = json['jobtitle'];
    profileimg = json['profileimg'];
    location = json['location'];
    website = json['website'];
    about = json['about'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['jobtitle'] = this.jobtitle;
    data['profileimg'] = this.profileimg;
    data['location'] = this.location;
    data['website'] = this.website;
    data['about'] = this.about;
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}