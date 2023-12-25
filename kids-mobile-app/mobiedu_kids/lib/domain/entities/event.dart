class Event<T> {
  Event({
    this.event,
  });

  T? event;
  factory Event.fromJson(Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return Event(
      event: json?["event"] == null
          ? null
          : create(json?['event']),
    );
  }

  Map<String, dynamic> toJson() => {
        'event': event,
      };
}
