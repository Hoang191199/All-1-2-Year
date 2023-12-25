class MenuChild<T> {
  MenuChild({
    this.menu_child,
  });

  T? menu_child;
  factory MenuChild.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return MenuChild<T>(
      menu_child:
          json?["menu_child"] == null ? null : create(json?['menu_child']),
    );
  }

  Map<String, dynamic> toJson() => {
        'menu_child': menu_child,
      };
}
