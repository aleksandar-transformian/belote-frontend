import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String username,
    required String email,
    required int eloRating,
    required int totalGames,
    required int wins,
    required int losses,
    required DateTime createdAt,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}

extension UserEntityX on UserEntity {
  double get winRate => totalGames > 0 ? wins / totalGames : 0.0;
  String get winRatePercentage => '${(winRate * 100).toStringAsFixed(1)}%';
}
