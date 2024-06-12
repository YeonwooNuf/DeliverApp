class HomeAddressDto {
  final String homeAddressNumber;
  final int addressUserNumber;
  final String address;
  final String addressCategory;
  final bool addressSelect; 

  HomeAddressDto({
    required this.homeAddressNumber,
    required this.addressUserNumber,
    required this.address,
    required this.addressCategory,
    required this.addressSelect
  });

  factory HomeAddressDto.fromJson(Map<String, dynamic> json) {
    if (
      json['homeAddressNumber'] == null ||
      json['addressUserNumber'] == null ||
        json['address'] == null ||
        json['addressCategory'] == null ||
        json['addressSelect'] == null 
        ) {
      throw FormatException("집주소 데이터 없음");
    }

    return HomeAddressDto(
      homeAddressNumber: json['homeAddressNumber'],
      addressUserNumber: json['addressUserNumber'],
      address: json['address'],
      addressCategory: json['addressCategory'],
      addressSelect: json['addressSelect'],
      
    );
  }

  Map<String, dynamic> toJson() => {
        'homeAddressNumber': homeAddressNumber,
        'addressUserNumber': addressUserNumber,
        'address': address,
        'addressCategory': addressCategory,
        'addressSelect': addressSelect,
      };

  @override
  String toString() {
    return 'HomeAddressDto( homeAddressNumber: $homeAddressNumber,addressUserNumber: $addressUserNumber, address: $address, addressCategory: $addressCategory, addressSelect: $addressSelect )';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeAddressDto &&
          runtimeType == other.runtimeType &&
          homeAddressNumber == other.homeAddressNumber &&
          addressUserNumber == other.addressUserNumber &&
          address == other.address &&
          addressCategory == other.addressCategory &&
          addressSelect == other.addressSelect;

  @override
  int get hashCode =>
      homeAddressNumber.hashCode ^ addressUserNumber.hashCode ^ address.hashCode ^ addressCategory.hashCode ^ addressSelect.hashCode ;
}
