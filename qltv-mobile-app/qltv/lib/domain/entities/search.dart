class Search {
  Search({
    this.id,
    this.title,
    this.authors,
    this.remain,
    this.image_url, 
    this.image,
    this.publication_year,
    this.object_type,
    this.intro_pub,
    this.print_length,
    this.seen,
    this.publisher,
    this.dimension,
    this.cover_type,
    this.tag,
    this.info,
    this.format,
    this.model,
    this.subject
  });

  int? id;
  String? title;
  int? remain;
  String? authors;
  String? image_url;
  String? image;
  int? publication_year;
  String? object_type;
  String? intro_pub;
  int? print_length;
  int? seen;
  String? publisher;
  String? dimension;
  String? cover_type;
  String? tag;
  String? info;
  String? format;
  String? model;
  String? subject;


  factory Search.fromJson(Map<String, dynamic>? json) {
    return Search(
      id: json?["id"] == null ? null : json?['id'] as int,
      title: json?["title"] == null ? null : json?['title'] as String,
      remain: json?["remain"] == null ? null : json?['remain'] as int,
      authors:json?["authors"] == null ? null : json?['authors'] as String,
      image_url: json?["image_url"] == null ? null : json?['image_url'] as String,
      image: json?["image"] == null ? null : json?['image'] as String,
      publication_year: json?["publication_year"] == null ? null : json?['publication_year'] as int,
      intro_pub: json?["intro_pub"] == null ? null : json?['intro_pub'] as String,
      object_type: json?["object_type"] == null ? null : json?['object_type'] as String,
      print_length: json?["print_length"] == null ? null : json?['print_length'] as int,
      seen: json?["seen"] == null ? null : json?['seen'] as int,
      publisher: json?["publisher"] == null ? null : json?['publisher'] as String,
      dimension: json?["dimension"] == null ? null : json?['dimension'] as String,
      cover_type: json?["cover_type"] == null ? null : json?['cover_type'] as String,
      tag: json?["tag"] == null ? null : json?['tag'] as String,
      info: json?["info"] == null ? null : json?['info'] as String,
      format: json?["format"] == null ? null : json?['format'] as String,
      model: json?["model"] == null ? null : json?['model'] as String,
      subject: json?["subject"] == null ? null : json?['subject'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'remain': remain,
        'authors': authors,
        'image_url': image_url,
        'image': image,
        'publication_year': publication_year,
        'intro_pub': intro_pub,
        'object_type': object_type,
        'print_length': print_length,
        'seen': seen,
        'publisher': publisher,
        'dimension': dimension,
        'cover_type' : cover_type,
        'tag': tag,
        'info': info,
        'format': format,
        'model': model,
        'subject': subject
      };
}
