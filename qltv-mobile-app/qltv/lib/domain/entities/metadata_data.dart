import 'package:qltv/domain/entities/metadata_data_model.dart';

class MetadataData {
  MetadataData({
    this.model,
    this.visible,
  });

  List<MetadataDataModel>? model;
  bool? visible;

  factory MetadataData.fromJson(Map<String, dynamic>? json) {
    return MetadataData(
      model: json?["model"] == null ? null : List<MetadataDataModel>.from(json?["model"].map((x) => MetadataDataModel.fromJson(x))),
      visible: json?["visible"] == null ? false : json?['visible'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'model': model,
    'visible': visible,
  };
}