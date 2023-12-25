import 'package:mooc_app/domain/entities/payment_name.dart';

class OrderHistory {
  OrderHistory({
  this.id,
  this.displayOrder,
  this.code,
  this.idUser,
  this.fullname,
  this.phone,
  this.createdDate,
  this.paymentTypeName,
  this.status,
  this.sale,
  this.totalAmount,
  this.paymentFee,
  this.paymentStatusName,
  this.province,
  this.courseNames,
  this.activeDate
  });

  String? id;
  int? displayOrder;
  String? code;
  int? idUser;
  String? fullname;
  String? phone;
  String? createdDate;
  String? paymentTypeName;
  String? status;
  String? sale;
  String? totalAmount;
  String? paymentFee;
  PaymentName? paymentStatusName;
  String? province;
  String? courseNames;
  String? activeDate;

  factory OrderHistory.fromJson(Map<String, dynamic>? json) {
    return OrderHistory(
      id: json?["id"] == null ? null : json?['id'] as String,
      displayOrder: json?["displayOrder"] == null ? null : json?['displayOrder'] as int,
      code: json?["code"] == null ? null : json?['code'] as String,
      idUser: json?["idUser"] == null ? null : json?['idUser'] as int,
      fullname: json?["fullname"] == null ? null : json?['fullname'] as String,
      phone: json?["phone"] == null ? null : json?['phone'] as String,
      createdDate: json?["createdDate"] == null ? null : json?['createdDate'] as String,
      paymentTypeName: json?["paymentTypeName"] == null ? null : json?['paymentTypeName'] as String,
      status: json?["status"] == null ? null : json?['status'] as String,
      sale: json?["sale"] == null ? null : json?['sale'] as String,
      totalAmount: json?["totalAmount"] == null ? null : json?['totalAmount'] as String,
      paymentFee: json?["paymentFee"] == null ? null : json?['paymentFee'] as String,
      paymentStatusName: json?["paymentStatusName"] == null ? null : PaymentName.fromJson(json?['paymentStatusName']),
      province: json?["province"] == null ? null : json?['province'] as String,
      courseNames: json?["courseNames"] == null ? null : json?['courseNames'] as String,
      activeDate: json?["activeDate"] == null ? null : json?['activeDate'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "displayOrder": displayOrder,
    "code": code,
    "idUser": idUser,
    "fullname": fullname,
    "phone": phone,
    "createdDate": createdDate,
    "paymentTypeName": paymentTypeName,
    "status": status,
    "sale": sale,
    "totalAmount": totalAmount,
    "paymentFee": paymentFee,
    "paymentStatusName": paymentStatusName,
    "province": province,
    "courseNames": courseNames,
    "activeDate": activeDate
  };
}