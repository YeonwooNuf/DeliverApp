import 'package:delivery/pages/address/AddressChange.dart';
import 'package:flutter/material.dart';
import 'package:delivery/pages/FavoritePage.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {

  final String name;
  final String phone;

  DetailPage({required this.name, required this.phone});

  @override
  _DetailPageState createState() => _DetailPageState(name: name, phone: phone);
}


class Review {
  final String imagePath;
  final String text;

  Review({required this.imagePath, required this.text});
}

class _DetailPageState extends State<DetailPage> {
  String displayText = '';
  bool showImage = false;
  String name ;
  String  phone;

    _DetailPageState({required this.name, required this.phone});

  
  String formatPhoneNumber(String phoneNumber) {

     // 전화번호 형식 변환(사이사이 - 추가되게)
     return phoneNumber.substring(0, 3) + '-' + phoneNumber.substring(3, 7) + '-' + phoneNumber.substring(7);
   }
  

  @override
  Widget build(BuildContext context) {
    double squareSize = (MediaQuery.of(context).size.width - 60) / 4;
    
    return Theme(
      data: ThemeData(
        fontFamily: "MangoDdobak",
        textTheme: TextTheme(
          bodyText1: TextStyle(fontWeight: FontWeight.w700),
          bodyText2: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

          title: Text('             Inha Delivery'),

        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Text(
                '${widget.name}',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Text(
                '${widget.phone}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Text(
                      '1',
                      style: TextStyle(fontSize: 18),
                    ),
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(width: 90),
                  CircleAvatar(
                    radius: 20,
                    child: Text(
                      '1',
                      style: TextStyle(fontSize: 18),
                    ),
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(width: 90),
                  CircleAvatar(
                    radius: 20,
                    child: Text(
                      '0',
                      style: TextStyle(fontSize: 18),
                    ),
                    backgroundColor: Colors.grey[300],
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                '나의 리뷰       |         주문내역         |       즐겨찾기',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        updateReviewInfo('리뷰 정보 표시');
                      },
                      child: Text('리뷰'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        updateOrderInfo('주문내역 정보 표시');
                      },
                      child: Text('주문내역'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        updateLikeInfo('즐겨찾기 정보 표시');
                      },
                      child: Text('즐겨찾기'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              InkWell(
                onTap: () {
                  print("버튼이 눌렸습니다.");
                  // 여기에 버튼을 탭했을 때 원하는 기능을 추가하세요.
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (showImage)
                      Image.asset(
                        'assets/images/review.png',
                        width: squareSize, // 이미지 크기 조절
                        height: 50, // 이미지 높이
                        fit: BoxFit.contain,
                      ),
                    Expanded(
                      child: Text(
                        displayText,
                        textAlign: TextAlign.center, // 텍스트 가운데 정렬
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateReviewInfo(String info) {
    setState(() {
      displayText = info;
      showImage = true; // 이미지를 보여줄지 말지 결정
    });
  }

  void updateOrderInfo(String info) {
    setState(() {
      displayText = info;
      showImage = false;
    });
  }

  void updateLikeInfo(String info) {
    setState(() {
      displayText = info;
      showImage = false;
    });
  }
}
