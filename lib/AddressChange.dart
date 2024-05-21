import 'package:flutter/material.dart';

class ItemListNotifier extends ChangeNotifier {
  List<String> _addresses = [
    '인하대,인하공전,정석항공고 인천광역시 미추홀구 인하로 100 수준원점',
    '인천광역시 미추홀구 인하로105번길 43 302호',
    '인하공전 병신대학',
  ];
  List<String> get addresses => _addresses;

  String _homeAddress = '우리 집은 목동';
  String get homeAddress => _homeAddress;

  String _workAddress = '우리 학교는 인하공전';
  String get workAddress => _workAddress;
 
  String _selectedAddress = '';
  String get selectedAddress => _selectedAddress;
  
  int _selectedIndex = -2;

  int get selectedIndex => _selectedIndex;

  void setSelctedAddress(String selectedAddress) {
    _selectedAddress = selectedAddress;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // 변경 사항을 듣고 있는 위젯들에게 알림
  }

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
  
  void removeAddress(int index) {
    _addresses.removeAt(index);
    notifyListeners();
  }

  void setHomeAddress(String newAddress) {
    _homeAddress = newAddress;
    notifyListeners();
  }

  void setWorkAddress(String newAddress) {
    _workAddress = newAddress;
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

  void addAddress(String newAddress) {
    addresses.add(newAddress);
    notifyListeners();
  }
  
}
  