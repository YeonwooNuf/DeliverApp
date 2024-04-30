import 'package:flutter/material.dart';

class ItemListNotifier extends ChangeNotifier {
  List<String> _addresses = [
    '인하대,인하공전,정석항공고 인천광역시 미추홀구 인하로 100 수준원점',
    '인천광역시 미추홀구 인하로105번길 43 302호',
  ];
  List<String> get addresses => _addresses;
  
  String _homeAddress = '우리 집은 목동';
  String get homeAddress => _homeAddress;

  String _workAddress = '우리 학교는 인하공전';
  String get workAddress => _workAddress;
  
  void removeAddress(int index) {
    _addresses.removeAt(index);
    notifyListeners();
  }

  void removeHomeAddress() {
    _homeAddress = '';
    notifyListeners();
  }

  void removeWorkAddress() {
    _workAddress = '';
    notifyListeners();
  }

  // void removeHomeAddress(int index) {
  //   _addresses.removeAt(index);
  //   notifyListeners();
  // }

  // void removeWorkAddress(int index) {
  //   _addresses.removeAt(index);
  //   notifyListeners();
  // }
}
