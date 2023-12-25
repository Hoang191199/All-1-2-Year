class MenuClass<T> {
  MenuClass({
    this.menu_class,
  });

  T? menu_class;
  factory MenuClass.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return MenuClass<T>(
      menu_class:
          json?["menu_class"] == null ? null : create(json?['menu_class']),
    );
  }

  Map<String, dynamic> toJson() => {
        'menu_class': menu_class,
      };
}
