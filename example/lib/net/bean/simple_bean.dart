class SimpleBean {
  String msg;
  String ver;
  List<SimpleDataBean> data;
  bool success;
  String code;

  SimpleBean({this.msg, this.ver, this.data, this.success, this.code});

  SimpleBean.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    ver = json['ver'];
    if (json['data'] != null) {
      data = new List<SimpleDataBean>();
      json['data'].forEach((v) {
        data.add(new SimpleDataBean.fromJson(v));
      });
    }
    success = json['success'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['ver'] = this.ver;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['code'] = this.code;
    return data;
  }
}

class SimpleDataBean {
  String imageUrl;
  String id;
  String name;
  String petName;

  SimpleDataBean({this.imageUrl, this.id, this.name, this.petName});

  SimpleDataBean.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    id = json['id'];
    name = json['name'];
    petName = json['pet_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    data['id'] = this.id;
    data['name'] = this.name;
    data['pet_name'] = this.petName;
    return data;
  }
}