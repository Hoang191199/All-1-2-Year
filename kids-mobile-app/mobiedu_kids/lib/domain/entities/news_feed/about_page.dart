class AboutPage {
  AboutPage({
    this.school_id,
    this.page_admin,
    this.page_name,
    this.page_title,
    this.page_description,
    this.page_picture,
    this.page_cover,
    this.page_likes,
    this.telephone,
    this.website,
    this.email,
    this.address,
    this.short_overview,
    this.start_age,
    this.end_age,
    this.start_tuition_fee,
    this.end_tuition_fee,
    this.facility_pool,
    this.facility_playground_out,
    this.facility_playground_in,
    this.facility_library,
    this.facility_camera,
    this.service_breakfast,
    this.service_belated,
    this.service_saturday,
    this.service_bus,
    this.info_leader,
    this.info_method,
    this.type,
  });

  String? school_id;
  String? page_admin;
  String? page_name;
  String? page_title;
  String? page_description;
  String? page_picture;
  String? page_cover;
  String? page_likes;
  String? telephone;
  String? website;
  String? email;
  String? address;
  String? short_overview;
  String? start_age;
  String? end_age;
  String? start_tuition_fee;
  String? end_tuition_fee;
  String? facility_pool;
  String? facility_playground_out;
  String? facility_playground_in;
  String? facility_library;
  String? facility_camera;
  String? service_breakfast;
  String? service_belated;
  String? service_saturday;
  String? service_bus;
  String? info_leader;
  String? info_method;
  String? type;

  factory AboutPage.fromJson(Map<String, dynamic>? json) {
    return AboutPage(
      school_id: json?["school_id"] == null ? null : json?['school_id'] as String,
      page_admin: json?["page_admin"] == null ? null : json?['page_admin'] as String,
      page_name: json?["page_name"] == null ? null : json?['page_name'] as String,
      page_title: json?["page_title"] == null ? null : json?['page_title'] as String,
      page_description: json?["page_description"] == null ? null : json?['page_description'] as String,
      page_picture: json?["page_picture"] == null ? null : json?['page_picture'] as String,
      page_cover: json?["page_cover"] == null ? null : json?['page_cover'] as String,
      page_likes: json?["page_likes"] == null ? null : json?['page_likes'] as String,
      telephone: json?["telephone"] == null ? null : json?['telephone'] as String,
      website: json?["website"] == null ? null : json?['website'] as String,
      email: json?["email"] == null ? null : json?['email'] as String,
      address: json?["address"] == null ? null : json?['address'] as String,
      short_overview: json?["short_overview"] == null ? null : json?['short_overview'] as String,
      start_age: json?["start_age"] == null ? null : json?['start_age'] as String,
      end_age: json?["end_age"] == null ? null : json?['end_age'] as String,
      start_tuition_fee: json?["start_tuition_fee"] == null ? null : json?['start_tuition_fee'] as String,
      end_tuition_fee: json?["end_tuition_fee"] == null ? null : json?['end_tuition_fee'] as String,
      facility_pool: json?["facility_pool"] == null ? null : json?['facility_pool'] as String,
      facility_playground_out: json?["facility_playground_out"] == null ? null : json?['facility_playground_out'] as String,
      facility_playground_in: json?["facility_playground_in"] == null ? null : json?['facility_playground_in'] as String,
      facility_library: json?["facility_library"] == null ? null : json?['facility_library'] as String,
      facility_camera: json?["facility_camera"] == null ? null : json?['facility_camera'] as String,
      service_breakfast: json?["service_breakfast"] == null ? null : json?['service_breakfast'] as String,
      service_belated: json?["service_belated"] == null ? null : json?['service_belated'] as String,
      service_saturday: json?["service_saturday"] == null ? null : json?['service_saturday'] as String,
      service_bus: json?["service_bus"] == null ? null : json?['service_bus'] as String,
      info_leader: json?["info_leader"] == null ? null : json?['info_leader'] as String,
      info_method: json?["info_method"] == null ? null : json?['info_method'] as String,
      type: json?["type"] == null ? null : json?['type'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'school_id': school_id,
    'page_admin': page_admin,
    'page_name': page_name,
    'page_title': page_title,
    'page_description': page_description,
    'page_picture': page_picture,
    'page_cover': page_cover,
    'page_likes': page_likes,
    'telephone': telephone,
    'website': website,
    'email': email,
    'address': address,
    'short_overview': short_overview,
    'start_age': start_age,
    'end_age': end_age,
    'start_tuition_fee': start_tuition_fee,
    'end_tuition_fee': end_tuition_fee,
    'facility_pool': facility_pool,
    'facility_playground_out': facility_playground_out,
    'facility_playground_in': facility_playground_in,
    'facility_library': facility_library,
    'facility_camera': facility_camera,
    'service_breakfast': service_breakfast,
    'service_belated': service_belated,
    'service_saturday': service_saturday,
    'service_bus': service_bus,
    'info_leader': info_leader,
    'info_method': info_method,
    'type': type,
  };
}