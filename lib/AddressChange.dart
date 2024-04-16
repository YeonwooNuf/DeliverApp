import 'package:flutter/material.dart';

class ItemListNotifier extends ChangeNotifier {
  List<String> _addresses = [
    '인하대,인하공전,정석항공고 인천광역시 미추홀구 인하로 100 수준원점',
    '인천광역시 미추홀구 인하로105번길 43 302호',
  ];

  List<String> get addresses => _addresses;

  // void addAddress(String address) {
  //   _addresses.add(address);
  //   notifyListeners();
  // }

  void removeAddress(int index) {
    _addresses.removeAt(index);
    notifyListeners();
  }
}
