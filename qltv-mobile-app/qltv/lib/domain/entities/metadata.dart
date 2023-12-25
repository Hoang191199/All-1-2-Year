import 'package:qltv/domain/entities/introduce.dart';
import 'package:qltv/domain/entities/metadata_data.dart';
import 'package:qltv/domain/entities/metadata_item.dart';
import 'package:qltv/domain/entities/metadata_model.dart';

class Metadata {
  Metadata({
    this.color,
    this.title,
    this.visible,
    this.description,
    this.items,
    this.book,
    this.audio,
    this.ebook,
    this.newspaper,
    this.video,
    this.introduce,
    this.basic,
    this.advanced,
    this.data,
    this.model,
    this.info,
    this.file_path,
    this.file_format,
    this.image_url,
    this.intro_pub,
    this.keywords,
    this.epub_file_path,
  });

  String? color;
  String? title;
  bool? visible;
  String? description;
  List<MetadataItem>? items;
  int? book;
  bool? audio;
  int? ebook;
  int? newspaper;
  int? video;
  Introduce? introduce;
  bool? basic;
  bool? advanced;
  MetadataData? data;
  List<MetadataModel>? model;
  String? info;
  String? file_path;
  String? file_format;
  String? image_url;
  String? intro_pub;
  String? keywords;
  String? epub_file_path;

  factory Metadata.fromJson(Map<String, dynamic>? json) {
    return Metadata(
      color: json?["color"] == null ? null : json?['color'] as String,
      title: json?["title"] == null ? null : json?['title'] as String,
      visible: json?["visible"] == null ? false : json?['visible'] as bool,
      description: json?["description"] == null ? null : json?['description'] as String,
      items: json?["items"] == null ? null : List<MetadataItem>.from(json?["items"].map((x) => MetadataItem.fromJson(x))),
      book: json?["book"] == null ? null : json?['book'] as int,
      audio: json?["audio"] == null ? false : json?['audio'] as bool,
      ebook: json?["ebook"] == null ? null : json?['ebook'] as int,
      newspaper: json?["newspaper"] == null ? null : json?['newspaper'] as int,
      video: json?["video"] == null ? null : json?['video'] as int,
      introduce: json?['introduce'] == null ? null : Introduce.fromJson(json?['introduce']),
      basic: json?["basic"] == null ? false : json?['basic'] as bool,
      advanced: json?["advanced"] == null ? false : json?['advanced'] as bool,
      data: json?['data'] == null ? null : MetadataData.fromJson(json?['data']),
      model: json?["model"] == null ? null : List<MetadataModel>.from(json?["model"].map((x) => MetadataModel.fromJson(x))),
      info: json?["info"] == null ? null : json?['info'] as String,
      file_path: json?["file_path"] == null ? null : json?['file_path'] as String,
      file_format: json?["file_format"] == null ? null : json?['file_format'] as String,
      image_url: json?["image_url"] == null ? null : json?['image_url'] as String,
      intro_pub: json?["intro_pub"] == null ? null : json?['intro_pub'] as String,
      keywords: json?["keywords"] == null ? null : json?['keywords'] as String,
      epub_file_path: json?["epub_file_path"] == null ? null : json?['epub_file_path'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'color': color,
    'title': title,
    'visible': visible,
    'description': description,
    'items': items,
    'book': book,
    'audio': audio,
    'ebook': ebook,
    'newspaper': newspaper,
    'video': video,
    'introduce': introduce,
    'basic': basic,
    'advanced': advanced,
    'data': data,
    'model': model,
    'info': info,
    'file_path': file_path,
    'file_format': file_format,
    'image_url': image_url,
    'intro_pub': intro_pub,
    'keywords': keywords,
    'epub_file_path': epub_file_path,
  };
}