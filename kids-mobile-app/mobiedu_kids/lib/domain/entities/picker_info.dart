class PickerInfo {
  PickerInfo(
      {this.child_info_id,
      this.child_id,
      this.picker_name,
      this.picker_relation,
      this.picker_phone,
      this.picker_source_file,
      this.picker_file_name,
      this.picker_address,
      this.status,
      this.created_at,
      this.updated_at,
      this.created_user_id,
      this.user_fullname,
      this.source_file});

  String? child_info_id;
  String? child_id;
  String? picker_name;
  String? picker_relation;
  String? picker_phone;
  String? picker_source_file;
  String? picker_file_name;
  String? picker_address;
  String? status;
  String? created_at;
  String? updated_at;
  String? created_user_id;
  String? user_fullname;
  String? source_file;

  factory PickerInfo.fromJson(Map<String, dynamic>? json) {
    return PickerInfo(
      child_info_id: json?["child_info_id"] == null
          ? null
          : json?['child_info_id'] as String,
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      picker_name:
          json?["picker_name"] == null ? null : json?['picker_name'] as String,
      picker_relation: json?["picker_relation"] == null
          ? null
          : json?['picker_relation'] as String,
      picker_phone: json?["picker_phone"] == null
          ? null
          : json?['picker_phone'] as String,
      picker_source_file: json?["picker_source_file"] == null
          ? null
          : json?['picker_source_file'] as String,
      picker_file_name: json?["picker_file_name"] == null
          ? null
          : json?['picker_file_name'] as String,
      picker_address: json?["picker_address"] == null
          ? null
          : json?['picker_address'] as String,
      status: json?["status"] == null ? null : json?['status'] as String,
      created_at:
          json?["created_at"] == null ? null : json?['created_at'] as String,
      updated_at:
          json?["updated_at"] == null ? null : json?['updated_at'] as String,
      created_user_id: json?["created_user_id"] == null
          ? null
          : json?['created_user_id'] as String,
      user_fullname: json?["user_fullname"] == null
          ? null
          : json?['user_fullname'] as String,
      source_file:
          json?["source_file"] == null ? null : json?['source_file'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "child_info_id": child_info_id,
        "child_id": child_id,
        "picker_name": picker_name,
        "picker_relation": picker_relation,
        "picker_phone": picker_phone,
        "picker_source_file": picker_source_file,
        "picker_file_name": picker_file_name,
        "picker_address": picker_address,
        "status": status,
        "created_at": created_at,
        "updated_at": updated_at,
        "created_user_id": created_user_id,
        "user_fullname": user_fullname,
        "source_file": source_file
      };
}
