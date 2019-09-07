class CommBean {
  String msg;
  String ver;
  Object data;
  bool success;
  String code;

  CommBean({this.msg, this.ver, this.data, this.success, this.code});

  CommBean.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    ver = json['ver'];
    data = json['data'];
    success = json['success'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['ver'] = this.ver;
    data['data'] = this.data;
    data['success'] = this.success;
    data['code'] = this.code;
    return data;
  }
}
