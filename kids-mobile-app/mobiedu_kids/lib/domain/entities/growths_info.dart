class GrowthsInfo {
  GrowthsInfo({
    this.child_growth_id,
    this.height,
    this.weight,
    this.recorded_at
  });

    String? child_growth_id;
    String? height;
    String? weight;
    String? recorded_at;

  factory GrowthsInfo.fromJson(Map<String, dynamic>? json) {
    return GrowthsInfo(
      child_growth_id:
          json?["child_growth_id"] == null ? null : json?['child_growth_id'] as String,
      height:
          json?["height"] == null ? null : json?['height'] as String,
      weight:
          json?["weight"] == null ? null : json?['weight'] as String,
      recorded_at:
          json?["recorded_at"] == null ? null : json?['recorded_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
                "child_growth_id": child_growth_id,
                "height": height,
                "weight": weight,
                "recorded_at": recorded_at
      };
}
