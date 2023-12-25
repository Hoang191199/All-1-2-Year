class Events<T> {
  Events({
    this.events,
  });

  List<T>? events;
  factory Events.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return Events<T>(
      events: json?["events"] == null
          ? null
          : List<T>.from(json?["events"].map((x) => create(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'events': events,
      };
}
