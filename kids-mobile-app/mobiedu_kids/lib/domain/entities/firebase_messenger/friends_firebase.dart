class FriendsFirebase {
  final String? user_id;

  FriendsFirebase({ this.user_id});

  factory FriendsFirebase.fromJson(Map<String, dynamic>? json) {
    return FriendsFirebase(
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": user_id,
  };
}
