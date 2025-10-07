import '../../domain/entities/cast.dart';

class CastModel extends Cast {
  const CastModel({
    required int id,
    required String name,
    required String character,
    required String profilePath,
  }) : super(
    id: id,
    name: name,
    character: character,
    profilePath: profilePath,
  );

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      profilePath: json['profile_path'] ?? '',
    );
  }
}
