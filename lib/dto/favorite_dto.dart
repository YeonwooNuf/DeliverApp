//favorite를  json형태로 스프링 부트 프로젝트에 전송해서 DB에 저장하는 코드

class FavoriteDto {
  final int favorite_userNumber;
  final String favorite_storeId;
  final String favorite_storeImg;
  final String favorite_storeName;
  final String rating;

  FavoriteDto({
    required this.favorite_userNumber,
    required this.favorite_storeId,
    required this.favorite_storeImg,
    required this.favorite_storeName,
    required this.rating,
  });

  factory FavoriteDto.fromJson(Map<String, dynamic> json) {
    if (json['favoriteUserNumber'] == null ||
        json['favoriteStoreId'] == null ||
        json['favorite_storeImg'] == null ||
        json['rating'] == null ||
        json['favoriteStoreName'] == null) {
      throw FormatException("즐겨찾기 데이터 없음");
    }

    return FavoriteDto(
      favorite_storeId: json['favoriteStoreId'],
      favorite_userNumber: json['favoriteUserNumber'],
      favorite_storeImg: json['favorite_storeImg'],
      favorite_storeName: json['favoriteStoreName'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() => {
        'favoriteUserNumber': favorite_userNumber,
        'favoriteStoreId': favorite_storeId,
        'favorite_storeImg': favorite_storeImg,
        'favoriteStoreName': favorite_storeName,
        'rating': rating,
      };

  @override
  String toString() {
    return 'FavoriteDto(favoriteUserNumber: $favorite_userNumber, favoriteStoreId: $favorite_storeId, favorite_storeImg: $favorite_storeImg, favorite_storeName: $favorite_storeName rating: $rating)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteDto &&
          runtimeType == other.runtimeType &&
          favorite_userNumber == other.favorite_userNumber &&
          favorite_storeId == other.favorite_storeId &&
          favorite_storeImg == other.favorite_storeImg &&
          favorite_storeName == other.favorite_storeName &&
          rating == other.rating;

  @override
  int get hashCode =>
      favorite_userNumber.hashCode ^
      favorite_storeId.hashCode ^
      favorite_storeImg.hashCode ^
      favorite_storeName.hashCode ^
      rating.hashCode;
}
