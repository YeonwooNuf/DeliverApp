import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery/AddressChange.dart';
import 'package:delivery/pages/AddressRegisterPage.dart';

class AddressInfo extends StatefulWidget {
  final String searchedAddress;

  AddressInfo({Key? key, required this.searchedAddress}) : super(key: key);

  @override
  AddressInfoState createState() => AddressInfoState();
}

class AddressInfoState extends State<AddressInfo> {
  String detailAddress = '';
  String directions = '';
  String alias = '';

  Color _homeColor = Colors.transparent;
  Color _workColor = Colors.transparent;
  Color _locationColor = Colors.transparent;

  TextEditingController _detailAddressController = TextEditingController();
  TextEditingController _directionsController = TextEditingController();
  TextEditingController _aliasController = TextEditingController();

  bool _showAliasTextField = false; // 기타 버튼을 눌렀을 때 TextField를 보여줄지 여부

  @override
  void initState() {
    super.initState();
    _detailAddressController.addListener(() {
      setState(() {
        detailAddress = _detailAddressController.text;
      });
    });
    _directionsController.addListener(() {
      setState(() {
        directions = _directionsController.text;
      });
    });
    _aliasController.addListener(() {
      setState(() {
        alias = _aliasController.text;
      });
    });
  }

  @override
  void dispose() {
    _aliasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              '검색된 주소: ${widget.searchedAddress}',
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
                  detailAddress = value;
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
                  directions = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            if (_locationColor == Colors.black12)
              TextField(
                controller: _aliasController,
                decoration: InputDecoration(
                  hintText: '주소의 별칭을 입력해주세요',
                ),
                onChanged: (value) {
                  setState(() {
                    alias = value; // 입력받은 별칭을 저장합니다.
                  });
                },
              ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _homeColor = Colors.black12;
                        _workColor = Colors.transparent;
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
                SizedBox(width: 16.0),
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
                SizedBox(width: 16.0),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _homeColor = Colors.transparent;
                        _workColor = Colors.transparent;
                        _locationColor = Colors.black12;
                        _showAliasTextField =
                            true; // 기타 버튼을 눌렀을 때 TextField 보이기
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
                        String combinedAddress =
                            widget.searchedAddress + ' , ' + detailAddress;
                        print('상세주소 : $detailAddress');
                        print('길 안내 : $directions');
                        if (_homeColor == Colors.black12) {
                          print('선택된 버튼: 집');
                          Provider.of<ItemListNotifier>(context, listen: false)
                              .removeHomeAddress();
                          Provider.of<ItemListNotifier>(context, listen: false)
                              .setHomeAddress(combinedAddress);
                        } else if (_workColor == Colors.black12) {
                          print('선택된 버튼: 회사');
                          Provider.of<ItemListNotifier>(context, listen: false)
                              .removeWorkAddress();
                          Provider.of<ItemListNotifier>(context, listen: false)
                              .setWorkAddress(combinedAddress);
                        } else {
                          print('선택된 버튼: 기타');
                          final alias =
                              _aliasController.text; // TextField에서 입력한 별칭 가져오기
                          Provider.of<ItemListNotifier>(context, listen: false)
                              .addAddress(combinedAddress);
                        }

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
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddressRegisterPage(),
                                      ),
                                    );
                                  },
                                  child: Text("확인"),
                                ),
                              ],
                            );
                          },
                        );
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