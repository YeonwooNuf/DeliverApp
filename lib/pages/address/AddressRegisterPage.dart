import 'package:delivery/pages/PaymentPage.dart';
import 'package:delivery/pages/address/AddressChange.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:delivery/pages/HomePage.dart';
import 'package:delivery/pages/address/AddressMapPage.dart';
import 'package:delivery/pages/address/AddressSearch.dart';
import 'package:delivery/service/sv_homeAddress.dart';

class AddressRegisterPage extends StatefulWidget {
  final String userNumber;

  const AddressRegisterPage({Key? key, required this.userNumber})
      : super(key: key);

  @override
  _AddressRegisterPageState createState() => _AddressRegisterPageState();
}

class _AddressRegisterPageState extends State<AddressRegisterPage> {
  late List<List<bool>> _addressSelectStatus;

  @override
  void initState() {
    super.initState();
    _addressSelectStatus = [
      [], // 집 카테고리의 주소 선택 상태
      [], // 회사 카테고리의 주소 선택 상태
      [], // 기타 카테고리의 주소 선택 상태
    ];
    _loadAddressSelectStatus();
  }

  void _loadAddressSelectStatus() async {
    // 각 카테고리별로 주소 선택 상태를 가져옴
    for (int i = 0; i < 3; i++) {
      List<Map<String, dynamic>> addresses =
          await getAddressListByCategory(widget.userNumber, _getCategory(i));
      setState(() {
        _addressSelectStatus[i] = List<bool>.generate(
          addresses.length,
          (index) => addresses[index]['addressSelect'] ?? false,
        );
      });
    }
  }

  // 인덱스에 따라 카테고리 문자열 반환
  String _getCategory(int index) {
    switch (index) {
      case 0:
        return '집';
      case 1:
        return '회사';
      case 2:
        return '기타';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '주소 등록',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage(userNumber: widget.userNumber)),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddressSearch(userNumber: widget.userNumber)),
                ).then((value) {
                  if (value != null) {
                    // 주소가 선택되면 처리할 내용 추가
                  }
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: '도로명, 건물 또는 지번으로 검색',
                hintStyle:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddressMapPage(userNumber: widget.userNumber)),
                  );
                },
                icon: Icon(Icons.my_location),
                label: Text('현재 위치로 주소 찾기',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 245, 245, 100),
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Divider(height: 1, color: Colors.grey),
            Expanded(
              child: Column(
                children: List.generate(
                  3,
                  (index) => _buildCategoryList(context, index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context, int categoryIndex) {
    return FutureBuilder(
      future: getAddressListByCategory(
          widget.userNumber, _getCategory(categoryIndex)),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Map<String, dynamic>> addresses = snapshot.data ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white30,
                    child: Text(
                      '    ${_getCategory(categoryIndex)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              addresses.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '해당 카테고리에 주소가 없습니다.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text(
                            addresses[index]['address'],
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          trailing: _addressSelectStatus[categoryIndex][index]
                              ? Icon(Icons.check_circle, color: Colors.blue)
                              : null,
                          onTap: () {
                            setState(() {
                              // 모든 카테고리의 선택 상태를 false로 설정하고 데이터베이스에 업데이트
                              for (int i = 0;
                                  i < _addressSelectStatus.length;
                                  i++) {
                                for (int j = 0;
                                    j < _addressSelectStatus[i].length;
                                    j++) {
                                  _addressSelectStatus[i][j] = false;
                                  updateAddressSelectStatus(
                                    addresses[j]['homeAddressNumber'],
                                    int.parse(widget.userNumber),
                                    addresses[j]['address'],
                                    _getCategory(i),
                                    false,
                                  );
                                }
                              }
                              // 선택한 주소의 선택 상태를 true로 설정하고 데이터베이스에 업데이트
                              _addressSelectStatus[categoryIndex][index] = true;
                              updateAddressSelectStatus(
                                addresses[index]['homeAddressNumber'],
                                int.parse(widget.userNumber),
                                addresses[index]['address'],
                                _getCategory(categoryIndex),
                                true,
                              );
                              Provider.of<ItemListNotifier>(context, listen: false)
        .setSelectedAddress(addresses[index]['addressCategory']);
                              
                            });
                          },
                        );
                      },
                    ),
            ],
          );
        }
      },
    );
  }
}
