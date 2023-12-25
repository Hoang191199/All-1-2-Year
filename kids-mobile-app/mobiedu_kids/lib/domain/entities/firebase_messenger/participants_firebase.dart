class ParticipantsFirebase {
  final int? isAdmin;
  final int? isSeen;
  final String? name;
  final int? isTyping;

  ParticipantsFirebase({
    this.isAdmin,
    this.isSeen,
    this.name,
    this.isTyping
  });


  factory ParticipantsFirebase.fromJson(Map<String, dynamic>? json) {
    return ParticipantsFirebase(
      isSeen: json?["isSeen"] == null ? null : json?['isSeen'] as int,
      isAdmin: json?["isAdmin"] == null ? null : json?['isAdmin'] as int,
      name: json?["name"] == null ? null : json?['name'] as String,
      isTyping: json?["isTyping"] == null ? null : json?['isTyping'] as int,
    );
  }

   Map<String, dynamic> toJson() => {
    "isSeen": isSeen,
    "isAdmin": isAdmin,
    "name": name,
    "isTyping": isTyping,
  };
}