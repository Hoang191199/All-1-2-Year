import 'package:mobiedu_kids/domain/entities/profile_details.dart';

class Profile {
  Profile({
    this.profile,
  });

  ProfileDetails? profile;
  factory Profile.fromJson(Map<String, dynamic>? json) {
    return Profile(
      profile: json?["profile"] == null
          ? null
          : ProfileDetails.fromJson(json?['profile']),
    );
  }

  Map<String, dynamic> toJson() => {
        'profile': profile,
      };
}
