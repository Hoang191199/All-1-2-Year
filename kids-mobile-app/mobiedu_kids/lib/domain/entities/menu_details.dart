class MenuDetails<T> {
  MenuDetails({
    this.menu_detail,
  });

  T? menu_detail;
  factory MenuDetails.fromJson(Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return MenuDetails(
      menu_detail: json?["menu_detail"] == null
          ? null
          : create(json?['menu_detail']),
    );
  }

  Map<String, dynamic> toJson() => {
        'menu_detail': menu_detail,
      };
}
