import 'package:freezed_annotation/freezed_annotation.dart';

part 'locations.freezed.dart';
part 'locations.g.dart';

/// ユーザーの現在地を保持するクラス。
@freezed
class Location with _$Location {
  const factory Location({
    required double lat, // 緯度
    required double lng, // 経度
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

/// 個々の飲食店に関する詳細情報を保持するクラス。
@freezed
class RepositoryDetail with _$RepositoryDetail {
  const factory RepositoryDetail({
    @Default('') String formattedAddress, // 住所
    required Geometry geometry, // ジオメトリ情報
    @Default('') String name, // 名前
    List<dynamic>? photos, // 写真リスト
    @Default('') String placeId, // 場所のID
    double? rating, // 評価
  }) = _RepositoryDetail;

  factory RepositoryDetail.fromJson(Map<String, dynamic> json) =>
      _$RepositoryDetailFromJson(json);
}

/// 飲食店の情報リストと選択された飲食店情報を保持するクラス。
@freezed
class Repositories with _$Repositories {
  const factory Repositories({
    required List<RepositoryDetail> repositoryList, // 飲食店情報のリスト
    RepositoryDetail? selectedRepository, // 選択された飲食店情報
  }) = _Repositories;
}

/// 場所のジオメトリ情報（主に緯度と経度）を保持するクラス。
@freezed
class Geometry with _$Geometry {
  const factory Geometry({
    required Location location,
  }) = _Geometry;

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
}
