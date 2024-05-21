import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery/AddressChange.dart';
import 'package:delivery/pages/AddressRegisterPage.dart';
import 'package:delivery/pages/MyPage.dart';

class AddressInfo extends StatefulWidget {
  final String searchedAddress;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '배달 앱',
      home: AddressRegisterPage(),
    );
  }

  AddressInfo({Key? key, required this.searchedAddress}) : super(key: key);

  @override
  _AddressInfoState createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {
  String _detailAddress = '';
  String _directions = '';

  Color _homeColor = Colors.transparent;
  Color _workColor = Colors.transparent;
  Color _locationColor = Colors.transparent;

  @override
  StatefulWidget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소 상세 정보'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '검색된 주소: ${widget.searchedAddress ?? '주소를 선택해주세요'}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                hintText: '상세주소 (아파트/동/호)',
              ),
              onChanged: (value) {
                setState(() {
                  _detailAddress = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                hintText: '길 안내 (예: 1층에 메가커피가 있는 건물, 공동현관 비밀번호 #1234)',
              ),
              onChanged: (value) {
                setState(() {
                  _directions = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // 각 버튼 사이의 공간을 동일하게 분배
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _homeColor = Colors.black12;
                        _workColor = Colors.transparent;
                        _locationColor = Colors.transparent;
                      });
                      Provider.of<ItemListNotifier>(context, listen: false)
                          .setHomeAddress(widget.searchedAddress);
                    },
                    splashColor: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(8),
                        color: _homeColor,
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.home, size: 24),
                          SizedBox(height: 4),
                          Text('집'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0), // 각 버튼 사이의 공간
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _homeColor = Colors.transparent;
                        _workColor = Colors.black12;
                        _locationColor = Colors.transparent;
                      });
                    },
                    splashColor: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(8),
                        color: _workColor,
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.work, size: 24),
                          SizedBox(height: 4),
                          Text('회사'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0), // 각 버튼 사이의 공간
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _homeColor = Colors.transparent;
                        _workColor = Colors.transparent;
                        _locationColor = Colors.black12;
                      });
                    },
                    splashColor: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(8),
                        color: _locationColor,
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.location_on, size: 24),
                          SizedBox(height: 4),
                          Text('기타'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // 저장 버튼이 눌렸을 때의 동작
                      if (_homeColor == Colors.transparent &&
                          _workColor == Colors.transparent &&
                          _locationColor == Colors.transparent) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("알림"),
                              content: Text("주소 유형을 선택하세요."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("확인"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        print('상세주소 : $_detailAddress');
                        print('길 안내 : $_directions');
                        if (_homeColor == Colors.black12) {
                          print('선택된 버튼: 집');
                          Provider.of<ItemListNotifier>(context, listen: false)
                              .removeHomeAddress();
                          Provider.of<ItemListNotifier>(context, listen: false)
                              .setHomeAddress(widget.searchedAddress);
                        } else if (_workColor == Colors.black12) {
                          print('선택된 버튼: 회사');
                          Provider.of<ItemListNotifier>(context, listen: false)
                              .removeWorkAddress();
                          Provider.of<ItemListNotifier>(context, listen: false)
                              .setWorkAddress(widget.searchedAddress);
                        } else {
                          print('선택된 버튼: 기타');
                          Provider.of<ItemListNotifier>(context, listen: false)
                              .addAddress(widget.searchedAddress);
                        }

                        // 확인 버튼을 누르면 AddressRegister 페이지로 이동
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("알림"),
                              content: Text("저장되었습니다."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DefaultTabController(
                                          length: 4 , // 필요한 탭 개수
                                          child: AddressRegisterPage(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text("확인"),
                                ),
                              ],
                            );
                          },
                        ).then((_) {
                          // 이동한 후에도 기존 페이지가 올바르게 표시되도록 setState를 호출합니다.
                          setState(() {});
                        });
                      }
                    },
                    child: Text('저장'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white60,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
