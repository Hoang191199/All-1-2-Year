class EpubMargin {
  double side;
  double top;
  double bottom;

  EpubMargin({
    required this.side,
    required this.top,
    required this.bottom,
  });

  EpubMargin.fromJson(Map<String, dynamic> json)
    : side = json['side'],
      top = json['top'],
      bottom = json['bottom'];

  Map<String, dynamic> toJson() {
    return {
      'side': side,
      'top': top,
      'bottom': bottom,
    };
  }
}