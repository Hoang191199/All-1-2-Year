class DataConversationInfoFirebase {
  final String? avatarGroup;
  final int? isGroup;
  final String? lastMessage;
  final String? nameGroup;
  final String? lastTimeUpdated;

  DataConversationInfoFirebase({
    this.avatarGroup,
    this.isGroup,
    this.lastMessage,
    this.nameGroup,
    this.lastTimeUpdated
  });


  factory DataConversationInfoFirebase.fromJson(Map<String, dynamic>? json) {
    return DataConversationInfoFirebase(
      isGroup: json?["isGroup"] == null ? null : json?['isGroup'] as int,
      avatarGroup: json?["avatarGroup"] == null ? null : json?['avatarGroup'] as String,
      lastMessage: json?["lastMessage"] == null ? null : json?['lastMessage'] as String,
      nameGroup: json?["nameGroup"] == null ? null : json?['nameGroup'] as String,
      lastTimeUpdated: json?["lastTimeUpdated"] == null ? null : json?['lastTimeUpdated'] as String,
    );
  }

   Map<String, dynamic> toJson() => {
    "isGroup": isGroup,
    "avatarGroup": avatarGroup,
    "lastMessage": lastMessage,
    "nameGroup": nameGroup,
    "lastTimeUpdated": lastTimeUpdated,
  };
}