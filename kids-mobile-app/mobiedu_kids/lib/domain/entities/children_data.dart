class ChildrenData {
  ChildrenData({
    this.child_id,
    this.child_name,
    this.child_picture,
    this.user_id,
    this.child_parent_id,
    this.school_id,
    this.status,
    this.description,
    this.child_code,
    this.first_name,
    this.last_name,
    this.child_nickname,
    this.child_admin,
    this.is_pregnant,
    this.foetus_begin_date,
    this.due_date_of_childbearing,
    this.birthday,
    this.gender,
    this.parent_name,
    this.parent_phone,
    this.parent_job,
    this.parent_name_dad,
    this.parent_phone_dad,
    this.parent_job_dad,
    this.parent_email,
    this.parent_img1,
    this.parent_img2,
    this.parent_img3,
    this.parent_img4,
    this.address,
    this.blood_type,
    this.hobby,
    this.allergy,
    this.created_user_id,
    this.name_for_sort,
    this.school_status,
    this.child_picture_path,
    this.pregnant_week,
    this.group_name,
    this.group_id,
    this.group_title,
    this.group_picture,
    this.camera_url,
    this.page_id,
    this.page_title,
    this.page_name,
    this.page_picture,
    this.telephone,
    this.allow_parent_register_service,
    this.camera_guide,
    this.grade,
    this.begin_at,
  });

  String? child_id;
  String? child_name;
  String? child_picture;
  String? user_id;
  String? child_parent_id;
  String? school_id;
  String? status;
  String? description;
  String? child_code;
  String? first_name;
  String? last_name;
  String? child_nickname;
  String? child_admin;
  String? is_pregnant;
  String? foetus_begin_date;
  String? due_date_of_childbearing;
  String? birthday;
  String? gender;
  String? parent_name;
  String? parent_phone;
  String? parent_job;
  String? parent_name_dad;
  String? parent_phone_dad;
  String? parent_job_dad;
  String? parent_email;
  String? parent_img1;
  String? parent_img2;
  String? parent_img3;
  String? parent_img4;
  String? address;
  String? blood_type;
  String? hobby;
  String? allergy;
  String? created_user_id;
  String? name_for_sort;
  String? school_status;
  String? child_picture_path;
  String? pregnant_week;
  String? group_name;
  String? group_id;
  String? group_title;
  String? group_picture;
  String? camera_url;
  String? page_id;
  String? page_title;
  String? page_name;
  String? page_picture;
  String? telephone;
  bool? allow_parent_register_service;
  String? camera_guide;
  String? grade;
  String? begin_at;

  factory ChildrenData.fromJson(Map<String, dynamic>? json) {
    return ChildrenData(
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      child_name:
          json?["child_name"] == null ? null : json?['child_name'] as String,
      child_picture: json?["child_picture"] == null
          ? null
          : json?['child_picture'] as String,
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      child_parent_id: json?["child_parent_id"] == null
          ? null
          : json?['child_parent_id'] as String,
      school_id:
          json?["school_id"] == null ? null : json?['school_id'] as String,
      status: json?["status"] == null ? null : json?['status'] as String,
      description:
          json?["description"] == null ? null : json?['description'] as String,
      child_code:
          json?["child_code"] == null ? null : json?['child_code'] as String,
      first_name:
          json?["first_name"] == null ? null : json?['first_name'] as String,
      last_name:
          json?["last_name"] == null ? null : json?['last_name'] as String,
      child_nickname: json?["child_nickname"] == null
          ? null
          : json?['child_nickname'] as String,
      child_admin:
          json?["child_admin"] == null ? null : json?['child_admin'] as String,
      is_pregnant:
          json?["is_pregnant"] == null ? null : json?['is_pregnant'] as String,
      foetus_begin_date: json?["foetus_begin_date"] == null
          ? null
          : json?['foetus_begin_date'] as String,
      due_date_of_childbearing: json?["due_date_of_childbearing"] == null
          ? null
          : json?['due_date_of_childbearing'] as String,
      birthday: json?["birthday"] == null ? null : json?['birthday'] as String,
      gender: json?["gender"] == null ? null : json?['gender'] as String,
      parent_name:
          json?["parent_name"] == null ? null : json?['parent_name'] as String,
      parent_phone: json?["parent_phone"] == null
          ? null
          : json?['parent_phone'] as String,
      parent_job:
          json?["parent_job"] == null ? null : json?['parent_job'] as String,
      parent_name_dad: json?["parent_name_dad"] == null
          ? null
          : json?['parent_name_dad'] as String,
      parent_phone_dad: json?["parent_phone_dad"] == null
          ? null
          : json?['parent_phone_dad'] as String,
      parent_job_dad: json?["parent_job_dad"] == null
          ? null
          : json?['parent_job_dad'] as String,
      parent_email: json?["parent_email"] == null
          ? null
          : json?['parent_email'] as String,
      parent_img1:
          json?["parent_img1"] == null ? null : json?['parent_img1'] as String,
      parent_img2:
          json?["parent_img2"] == null ? null : json?['parent_img2'] as String,
      parent_img3:
          json?["parent_img3"] == null ? null : json?['parent_img3'] as String,
      parent_img4:
          json?["parent_img4"] == null ? null : json?['parent_img4'] as String,
      address: json?["address"] == null ? null : json?['address'] as String,
      blood_type:
          json?["blood_type"] == null ? null : json?['blood_type'] as String,
      hobby: json?["hobby"] == null ? null : json?['hobby'] as String,
      allergy: json?["allergy"] == null ? null : json?['allergy'] as String,
      created_user_id: json?["created_user_id"] == null
          ? null
          : json?['created_user_id'] as String,
      name_for_sort: json?["name_for_sort"] == null
          ? null
          : json?['name_for_sort'] as String,
      school_status: json?["school_status"] == null
          ? null
          : json?['school_status'] as String,
      child_picture_path: json?["child_picture_path"] == null
          ? null
          : json?['child_picture_path'] as String,
      pregnant_week: json?["pregnant_week"] == null
          ? null
          : json?['pregnant_week'] as String,
      group_name:
          json?["group_name"] == null ? null : json?['group_name'] as String,
      group_id: json?["group_id"] == null ? null : json?['group_id'] as String,
      group_title:
          json?["group_title"] == null ? null : json?['group_title'] as String,
      group_picture: json?["group_picture"] == null
          ? null
          : json?['group_picture'] as String,
      camera_url:
          json?["camera_url"] == null ? null : json?['camera_url'] as String,
      page_id: json?["page_id"] == null ? null : json?['page_id'] as String,
      page_title:
          json?["page_title"] == null ? null : json?['page_title'] as String,
      page_name:
          json?["page_name"] == null ? null : json?['page_name'] as String,
      page_picture: json?["page_picture"] == null
          ? null
          : json?['page_picture'] as String,
      telephone:
          json?["telephone"] == null ? null : json?['telephone'] as String,
      allow_parent_register_service:
          json?["allow_parent_register_service"] == null
              ? null
              : json?['allow_parent_register_service'] as bool,
      camera_guide: json?["camera_guide"] == null
          ? null
          : json?['camera_guide'] as String,
      grade: json?["grade"] == null ? null : json?['grade'] as String,
      begin_at: json?["begin_at"] == null ? null : json?['begin_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'child_id': child_id,
        'child_name': child_name,
        'child_picture': child_picture,
        "user_id": user_id,
        "child_parent_id": child_parent_id,
        "school_id": school_id,
        "status": status,
        "description": description,
        "child_code": child_code,
        "first_name": first_name,
        "last_name": last_name,
        "child_nickname": child_nickname,
        "child_admin": child_admin,
        "is_pregnant": is_pregnant,
        "foetus_begin_date": foetus_begin_date,
        "due_date_of_childbearing": due_date_of_childbearing,
        "birthday": birthday,
        "gender": gender,
        "parent_name": parent_name,
        "parent_phone": parent_phone,
        "parent_job": parent_job,
        "parent_name_dad": parent_name_dad,
        "parent_phone_dad": parent_phone_dad,
        "parent_job_dad": parent_job_dad,
        "parent_email": parent_email,
        "parent_img1": parent_img1,
        "parent_img2": parent_img2,
        "parent_img3": parent_img3,
        "parent_img4": parent_img4,
        "address": address,
        "blood_type": blood_type,
        "hobby": hobby,
        "allergy": allergy,
        "created_user_id": created_user_id,
        "name_for_sort": name_for_sort,
        "school_status": school_status,
        "child_picture_path": child_picture_path,
        "pregnant_week": pregnant_week,
        'group_name': group_name,
        "group_id": group_id,
        "group_title": group_title,
        "group_picture": group_picture,
        "camera_url": camera_url,
        "page_id": page_id,
        "page_title": page_title,
        "page_name": page_name,
        "page_picture": page_picture,
        "telephone": telephone,
        "allow_parent_register_service": allow_parent_register_service,
        "camera_guide": camera_guide,
        "grade": grade,
        "begin_at": begin_at,
      };
}
