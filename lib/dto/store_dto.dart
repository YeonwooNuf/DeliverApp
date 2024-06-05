// import 'dart:ffi';

// class StoreDto {
//   final Long storeId;
//   final String storeName;
//   final String storeAddress;
//   final String category;
//   final String storeImg;


//   StoreDto({
//     required this.storeId,
//     required this.storeName,
//     required this.storeAddress,
//     required this.category,
//     required this.storeImg,
//   });

//   factory StoreDto.fromJson(Map<String, dynamic> json) {
//     if (json['storeId'] == null ||
//         json['storeName'] == null ||
//         json['storeAddress'] == null ||
//         json['category'] == null ||
//         json['storeImg'] == null) {
//       throw FormatException("Invalid JSON data: missing required fields");
//     }

//     return StoreDto(
//       storeId: json['storeId'],
//       storeName: json['storeName'],
//       storeAddress: json['storeAddress'],
//       category: json['category'],
//       storeImg: json['storeImg'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'storeId': storeId,
//         'storeName': storeName,
//         'storeAddress': storeAddress,
//         'category': category,
//         'storeImg': storeImg,
//       };

//   @override
//   String toString() {
//     return 'StoreDto(storeId: $storeId, storeName: $storeName, storeAddress: $storeAddress, category: $category, storeImg: $storeImg)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is StoreDto &&
//           runtimeType == other.runtimeType &&
//           storeId == other.storeId &&
//           storeName == other.storeName &&
//           storeAddress == other.storeAddress &&
//           category == other.category &&
//           storeImg == other.storeImg;

//   @override
//   int get hashCode =>
//       storeId.hashCode ^
//       storeName.hashCode ^
//       storeAddress.hashCode ^
//       category.hashCode ^
//       storeImg.hashCode;
// }