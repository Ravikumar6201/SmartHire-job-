class LinkedlinModel {
  String? sub;
  bool? emailVerified;
  String? name;
  Locale? locale;
  String? givenName;
  String? familyName;
  String? email;

  LinkedlinModel(
      {this.sub,
      this.emailVerified,
      this.name,
      this.locale,
      this.givenName,
      this.familyName,
      this.email});

  LinkedlinModel.fromJson(Map<String, dynamic> json) {
    sub = json['sub'];
    emailVerified = json['email_verified'];
    name = json['name'];
    locale =
        json['locale'] != null ? new Locale.fromJson(json['locale']) : null;
    givenName = json['given_name'];
    familyName = json['family_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub'] = this.sub;
    data['email_verified'] = this.emailVerified;
    data['name'] = this.name;
    if (this.locale != null) {
      data['locale'] = this.locale!.toJson();
    }
    data['given_name'] = this.givenName;
    data['family_name'] = this.familyName;
    data['email'] = this.email;
    return data;
  }
}

class Locale {
  String? country;
  String? language;

  Locale({this.country, this.language});

  Locale.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['language'] = this.language;
    return data;
  }
}