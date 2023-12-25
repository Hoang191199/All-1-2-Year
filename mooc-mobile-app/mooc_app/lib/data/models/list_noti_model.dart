import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/list_noti.dart';
import '../../domain/entities/noti.dart';
part 'list_noti_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ListNotiModel extends ListNoti {
  ListNotiModel(
      {this.error, this.message, this.notifications, this.status})
      : super(
      error: error,
      message: message,
      notifications: notifications,
      status: status,);

  bool? error;
  String? message;
  Noti? notifications;
  bool? status;

  factory ListNotiModel.fromJson(Map<String, dynamic> json) =>
      _$ListNotiModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListNotiModelToJson(this);
}