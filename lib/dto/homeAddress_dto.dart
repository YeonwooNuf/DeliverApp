class HomeAddressDto {
  final int addressUserNumber;
  final String address;
  final String addressCategory;

  HomeAddressDto({
    required this.addressUserNumber,
    required this.address,
    required this.addressCategory,
  });

  factory HomeAddressDto.fromJson(Map<String, dynamic> json) {
    if (json['addressUserNumber'] == null ||
        json['address'] == null ||
        json['addressCategory'] == null) {
      throw FormatException("집주소 데이터 없음");
    }

    return HomeAddressDto(
      addressUserNumber: json['addressUserNumber'],
      address: json['address'],
      addressCategory: json['addressCategory'],
    );
  }

  Map<String, dynamic> toJson() => {
        'addressUserNumber': addressUserNumber,
        'address': address,
        'addressCategory': addressCategory,
      };

  @override
  String toString() {
    return 'HomeAddressDto( addressUserNumber: $addressUserNumber, address: $address, addressCategory: $addressCategory )';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeAddressDto &&
          runtimeType == other.runtimeType &&
          addressUserNumber == other.addressUserNumber &&
          address == other.address &&
          addressCategory == other.addressCategory;

  @override
  int get hashCode =>
      addressUserNumber.hashCode ^ address.hashCode ^ addressCategory.hashCode;
}
