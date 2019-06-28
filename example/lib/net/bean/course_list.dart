class CourseList {
  String msg;
  String ver;
  List<CourseListData> data;
  bool success;
  String code;

  CourseList({this.msg, this.ver, this.data, this.success, this.code});

  CourseList.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    ver = json['ver'];
    if (json['data'] != null) {
      data = new List<CourseListData>();
      json['data'].forEach((v) {
        data.add(new CourseListData.fromJson(v));
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

class CourseListData {
  String imageUrl;
  String id;
  String bCourseInfoId;
  String courseType;
  String name;
  String majorName;
  String courseStatus;
  String petName;
  String createTime;
  String sNum;

  CourseListData(
      {this.imageUrl,
        this.id,
        this.bCourseInfoId,
        this.courseType,
        this.name,
        this.majorName,
        this.courseStatus,
        this.petName,
        this.createTime,
        this.sNum});

  CourseListData.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    id = json['id'];
    bCourseInfoId = json['b_course_info_id'];
    courseType = json['course_type'];
    name = json['name'];
    majorName = json['major_name'];
    courseStatus = json['course_status'];
    petName = json['pet_name'];
    createTime = json['create_time'];
    sNum = json['s_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    data['id'] = this.id;
    data['b_course_info_id'] = this.bCourseInfoId;
    data['course_type'] = this.courseType;
    data['name'] = this.name;
    data['major_name'] = this.majorName;
    data['course_status'] = this.courseStatus;
    data['pet_name'] = this.petName;
    data['create_time'] = this.createTime;
    data['s_num'] = this.sNum;
    return data;
  }
}
