import 'package:flutter/material.dart';
import 'package:delivery/pages/ReviewPage.dart';

class OrderHistoryPage extends StatelessWidget {
  // 주문 내역 리스트
  final List<Map<String, String>> orders = [
    {
      'restaurantName': '동대문엽기떡볶이',
      'orderTime': '2024-04-11 18:28',
      'orderStatus': '배달 완료',
      'orderItem': '실속세트',
      'orderDetails': '떡볶이, [엽기] 착한맛',
      'orderTotal': '합계 17,500원',
    },
    {
      'restaurantName': '청년다방',
      'orderTime': '2024-04-11 18:28',
      'orderStatus': '배달 완료',
      'orderItem': '실속세트',
      'orderDetails': '차돌박이 떡볶이, 버터감자',
      'orderTotal': '합계 17,500원',
    },
    {
      'restaurantName': '백소정',
      'orderTime': '2024-04-11 18:28',
      'orderStatus': '배달 완료',
      'orderItem': '세트',
      'orderDetails': '돈가스모밀세트',
      'orderTotal': '합계 10,500원',
    },
    // 추가 주문 내역을 여기에 추가할 수 있습니다.
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
        padding: EdgeInsets.all(screenWidth * 0.04),
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
            SizedBox(height: screenWidth * 0.05),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return buildOrderHistoryItem(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrderHistoryItem(BuildContext context, int index) {
    final order = orders[index];
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.05),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
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
                      order['restaurantName']!,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                    Text(
                      order['orderTime']!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                    Text(
                      order['orderStatus']!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.05),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                child: Image.asset(
                  'assets/images/${index + 1}.png', // 이미지 경로
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.2,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          SizedBox(height: 0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order['orderItem']!,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                order['orderDetails']!,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                order['orderTotal']!,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.01),
          Center(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewPage(
                        restaurantName: order['restaurantName']!,
                        orderDetails: order['orderDetails']!,
                      ),
                    ),
                  );
                },
                child: Text(
                  '리뷰 쓰기',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12, vertical: screenWidth * 0.035),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
