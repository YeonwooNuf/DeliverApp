import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:delivery/pages/ReviewPage.dart';

class OrderHistoryPage extends StatelessWidget {
  // 텍스트에 들어갈 값들을 변수로 정의합니다.
  final String restaurantName = '동대문엽기떡볶이';
  final String orderTime = '2024-04-11 18:28';
  final String orderStatus = '배달 완료';
  final String orderItem = '실속세트';
  final String orderDetails = '떡볶이, [엽기] 착한맛';
  final String orderTotal = '합계 17,500원';
  final String restaurantName1 = '청년다방';
  final String orderTime1 = '2024-04-17 18:19';
  final String orderStatus1 = '배달완료';
  final String orderItem1 = '차돌세트';
  final String orderDetails1 = '차돌박이 떡볶이, 버터감자';
  final String orderTotal1 = '합계 20,500원';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '과거주문내역',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // 테두리 색상 설정
                borderRadius: BorderRadius.circular(10), // 테두리 모서리 둥글게 설정
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurantName,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              orderTime,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              orderStatus,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 20), // 이전 요소와의 간격 추가
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 하는 부분
                        child: Image.asset(
                          'assets/images/1.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain, // 이미지 적합성 설정
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0), // 각 열 사이의 간격 추가
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderItem,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4), // 요소들 사이의 간격 추가
                      Text(
                        orderDetails,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4), // 요소들 사이의 간격 추가
                      Text(
                        orderTotal,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Center( // 버튼을 가운데 정렬하기 위해 Center 위젯 사용
                    child: Container(
                      width: double.infinity, // Container의 가로 길이를 최대로 설정하여 Column의 가로 길이에 맞춤
                      margin: EdgeInsets.symmetric(horizontal: 16), // 좌우 여백 추가로 디자인 조정 가능
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewPage(
                                  restaurantName: restaurantName,
                                  orderDetails: orderDetails,
                                  restaurantName1: restaurantName1,
                                  orderDetails1: orderDetails1,
                                  ),
                            ),
                          );
                        },
                        child: Text(
                          '리뷰 쓰기',
                          style: TextStyle(
                            color: Colors.white, // 글씨 색상을 흰색으로 변경
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // 배경을 파란색으로 변경
                          shape: RoundedRectangleBorder( // 버튼의 모양을 둥글게 조정
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), // 버튼 내부 패딩 조정
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // 테두리 색상 설정
                borderRadius: BorderRadius.circular(10), // 테두리 모서리 둥글게 설정
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurantName1,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              orderTime1,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              orderStatus1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 20), // 이전 요소와의 간격 추가
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 하는 부분
                        child: Image.asset(
                          'assets/images/2.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain, // 이미지 적합성 설정
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0), // 각 열 사이의 간격 추가
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderItem1,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4), // 요소들 사이의 간격 추가
                      Text(
                        orderDetails1,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4), // 요소들 사이의 간격 추가
                      Text(
                        orderTotal1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Center( // 버튼을 가운데 정렬하기 위해 Center 위젯 사용
                    child: Container(
                      width: double.infinity, // Container의 가로 길이를 최대로 설정하여 Column의 가로 길이에 맞춤
                      margin: EdgeInsets.symmetric(horizontal: 16), // 좌우 여백 추가로 디자인 조정 가능
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewPage(
                                  restaurantName: restaurantName,
                                  orderDetails: orderDetails,
                                  restaurantName1: restaurantName1,
                                  orderDetails1: orderDetails1,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          '리뷰 쓰기',
                          style: TextStyle(
                            color: Colors.white, // 글씨 색상을 흰색으로 변경
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // 배경을 파란색으로 변경
                          shape: RoundedRectangleBorder( // 버튼의 모양을 둥글게 조정
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), // 버튼 내부 패딩 조정
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
