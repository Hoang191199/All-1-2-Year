import 'package:mobiedu_kids/domain/entities/journals_details.dart';

class Journal {
  Journal({
    this.journal,
  });

  JournalsDetails? journal;

  factory Journal.fromJson(Map<String, dynamic>? json) {
    return Journal(
      journal: json?['journal'] == null
          ? null
          : JournalsDetails.fromJson(json?['journal']),
    );
  }

  Map<String, dynamic> toJson() => {
        'journal': journal,
      };
}
