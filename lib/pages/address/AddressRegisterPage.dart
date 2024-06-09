import 'package:delivery/pages/HomePage.dart';
import 'package:delivery/pages/address/AddressMapPage.dart';
import 'package:delivery/pages/address/AddressSearch.dart';
import 'package:delivery/service/sv_homeAddress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressRegisterPage extends StatefulWidget {
  final String userNumber;

  const AddressRegisterPage({Key? key, required this.userNumber}) : super(key: key);

  @override
  _AddressRegisterPageState createState() => _AddressRegisterPageState();
}

class _AddressRegisterPageState extends State<AddressRegisterPage> {
  int _selectedIndex = -1; // 선택된 주소의 인덱스

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
              MaterialPageRoute(builder: (context) => HomePage(userNumber: widget.userNumber)),
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
                  MaterialPageRoute(builder: (context) => AddressSearch(userNumber: widget.userNumber)),
                ).then((value) {
                  if (value != null) {
                    // 주소가 선택되면 처리할 내용 추가
                  }
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: '도로명, 건물 또는 지번으로 검색',
                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddressMapPage(userNumber: widget.userNumber)),
                  );
                },
                icon: Icon(Icons.my_location),
                label: Text('현재 위치로 주소 찾기', style: TextStyle(fontWeight: FontWeight.w500)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 245, 245, 100),
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Divider(height: 1, color: Colors.grey),
            Expanded(
              child: _buildAddressList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        _buildCategoryList(context, '집'),
        _buildCategoryList(context, '회사'),
        _buildCategoryList(context, '기타'),
      ],
    );
  }

  Widget _buildCategoryList(BuildContext context, String category) {
    return FutureBuilder(
      future: getAddressListByCategory(widget.userNumber, category),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Map<String, dynamic>> addresses = snapshot.data ?? [];
          print('Addresses for category $category: $addresses'); // 로그 추가
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '    $category',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
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
                          title: Text(addresses[index]['address'], style: TextStyle(fontWeight: FontWeight.w500)),
                          trailing: _selectedIndex == index ? Icon(Icons.check_circle, color: Colors.blue) : null,
                          onTap: () {
                            setState(() {
                              if (_selectedIndex == index) {
                                _selectedIndex = -1; // 이미 선택된 주소를 다시 탭하면 선택 취소
                              } else {
                                _selectedIndex = index;
                              }
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
