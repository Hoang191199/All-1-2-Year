class DataTuitionDetail {
  DataTuitionDetail({
    this.tuition_child_id,
    this.fee_name,
    this.service_name,
    this.unit_price,
    this.quantity,
    this.unit_price_deduction,
    this.quantity_deduction,
  });

  String? tuition_child_id;
  String? fee_name;
  String? service_name;
  String? unit_price;
  String? quantity;
  String? unit_price_deduction;
  String? quantity_deduction;

  factory DataTuitionDetail.fromJson(Map<String, dynamic>? json) {
    return DataTuitionDetail(
      tuition_child_id: json?["tuition_child_id"] == null ? null : json?['tuition_child_id'] as String,
      fee_name: json?["fee_name"] == null ? null : json?['fee_name'] as String,
      service_name: json?["service_name"] == null ? null : json?['service_name'] as String,
      unit_price: json?["unit_price"] == null ? null : json?['unit_price'] as String,
      quantity: json?["quantity"] == null ? null : json?['quantity'] as String,
      unit_price_deduction: json?["unit_price_deduction"] == null ? null : json?['unit_price_deduction'] as String,
      quantity_deduction: json?["quantity_deduction"] == null ? null : json?['quantity_deduction'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'tuition_child_id': tuition_child_id,
        'fee_name': fee_name,
        'service_name': service_name,
        'unit_price': unit_price,
        'quantity': quantity,
        'unit_price_deduction': unit_price_deduction,
        'quantity_deduction': quantity_deduction,
      };
}
