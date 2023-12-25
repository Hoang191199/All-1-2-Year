class ParticipantOldPC {
  ParticipantOldPC({this.childs, this.parents});

  List<String>? childs;
  List<String>? parents;

  factory ParticipantOldPC.fromJson(Map<String, dynamic>? json) {
    return ParticipantOldPC(
      childs: json?["childs"] == null
          ? null
          : List<String>.from(
              json?["childs"].map((x) => json["childs"] as String)),
      parents: json?["parents"] == null
          ? null
          : List<String>.from(
              json?["parents"].map((x) => json["parents"] as String)),
    );
  }

  Map<String, dynamic> toJson() => {
        "childs": childs,
        "parents": parents,
      };
}
