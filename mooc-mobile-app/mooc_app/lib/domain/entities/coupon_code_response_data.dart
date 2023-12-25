class CouponCodeResponseData {
  
  CouponCodeResponseData({
    required this.idCourses,
    required this.couponCode,
    required this.discount,
    required this.price,
    required this.discountPercent,
    required this.total_price,
    required this.status,
  });

  List<int>? idCourses;
  String? couponCode;
  double? discount;
  double? price;
  int? discountPercent;
  double? total_price;
  bool? status;

  factory CouponCodeResponseData.fromJson(Map<String, dynamic>? json) {
    return CouponCodeResponseData(
      idCourses: json?["idCourses"] == null ? null : List<int>.from(json?["idCourses"].map((x) => x)),
      couponCode: json?["couponCode"] == null ? null : json?['couponCode'] as String,
      discount: json?['discount'] == null ? 0.0 : json?['discount'].toDouble(),
      price: json?["price"] == null ? 0.0 : json?['price'].toDouble(),
      discountPercent: json?["discountPercent"] == null ? 0 : json?['discountPercent'] as int,
      total_price: json?["total_price"] == null ? 0.0 : json?['total_price'].toDouble(),
      status: json?["status"] == null ? false : json?['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'idCourses': idCourses,
    'couponCode': couponCode,
    'discount': discount,
    'price': price,
    'discountPercent': discountPercent,
    'total_price': total_price,
    'status': status,
  };
}