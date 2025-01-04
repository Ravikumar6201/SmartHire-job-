
class CountryCode {
  String? id;
  String? name;
  String? phonecode;

  CountryCode({this.id, this.name, this.phonecode});

  CountryCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phonecode = json['phonecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phonecode'] = this.phonecode;
    return data;
  }
}