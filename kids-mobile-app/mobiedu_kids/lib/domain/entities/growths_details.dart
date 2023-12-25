class GrowthsDetails {
  GrowthsDetails(
      {this.blood_pressure,
      this.child_growth_id,
      this.child_parent_id,
      this.created_user_id,
      this.description,
      this.ear,
      this.eye,
      this.file_name,
      this.heart,
      this.height,
      this.is_parent,
      this.nose,
      this.nutriture_status,
      this.recorded_at,
      this.source_file,
      this.source_file_path,
      this.weight,
      this.bmi});

  String? blood_pressure;
  String? child_growth_id;
  String? child_parent_id;
  String? created_user_id;
  String? description;
  String? ear;
  String? eye;
  String? file_name;
  String? heart;
  String? height;
  String? is_parent;
  String? nose;
  String? nutriture_status;
  String? recorded_at;
  String? source_file;
  String? source_file_path;
  String? weight;
  String? bmi;
  factory GrowthsDetails.fromJson(Map<String, dynamic>? json) {
    return GrowthsDetails(
      child_parent_id: json?["child_parent_id"] == null
          ? null
          : json?['child_parent_id'] as String,
      blood_pressure: json?["blood_pressure"] == null
          ? null
          : json?['blood_pressure'] as String,
      child_growth_id: json?["child_growth_id"] == null
          ? null
          : json?['child_growth_id'] as String,
      created_user_id: json?["created_user_id"] == null
          ? null
          : json?['created_user_id'] as String,
      description:
          json?["description"] == null ? null : json?['description'] as String,
      ear: json?["ear"] == null ? null : json?['ear'] as String,
      eye: json?["eye"] == null ? null : json?['eye'] as String,
      file_name:
          json?["file_name"] == null ? null : json?['file_name'] as String,
      heart: json?["heart"] == null ? null : json?['heart'] as String,
      height: json?["height"] == null ? null : json?['height'] as String,
      is_parent:
          json?["is_parent"] == null ? null : json?['is_parent'] as String,
      nose: json?["nose"] == null ? null : json?['nose'] as String,
      nutriture_status: json?["nutriture_status"] == null
          ? null
          : json?['nutriture_status'] as String,
      recorded_at:
          json?["recorded_at"] == null ? null : json?['recorded_at'] as String,
      source_file:
          json?["source_file"] == null ? null : json?['source_file'] as String,
      source_file_path: json?["source_file_path"] == null
          ? null
          : json?['source_file_path'] as String,
      weight: json?["weight"] == null ? null : json?['weight'] as String,
      bmi: json?["bmi"] == null ? null : json?['bmi'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "blood_pressure": blood_pressure,
        "child_growth_id": child_growth_id,
        "child_parent_id": child_parent_id,
        "created_user_id": created_user_id,
        "description": description,
        "ear": ear,
        "eye": eye,
        "file_name": file_name,
        "heart": heart,
        "height": height,
        "is_parent": is_parent,
        "nose": nose,
        "nutriture_status": nutriture_status,
        "recorded_at": recorded_at,
        "source_file": source_file,
        "source_file_path": source_file_path,
        "weight": weight,
        "bmi": bmi
      };
}
