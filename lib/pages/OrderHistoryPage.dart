import 'package:delivery/service/sv_orderHistory.dart';
import 'package:flutter/material.dart';
import 'package:delivery/pages/ReviewPage.dart';

class OrderHistoryPage extends StatelessWidget {
  final String userNumber;

  OrderHistoryPage({Key? key, required this.userNumber}) : super(key: key);

  


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('과거주문내역'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchOrders(userNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> orders = snapshot.data ?? [];
            return buildOrderList(orders, screenWidth, screenHeight);
          }
        },
      ),
    );
  }

Widget buildOrderList(List<Map<String, dynamic>> orders, double screenWidth, double screenHeight) {
  return ListView.builder(
    itemCount: orders.length,
    itemBuilder: (context, index) {
      final order = orders[index];
      final storeId = order['storeId'];

      return Container(
        margin: EdgeInsets.all(screenWidth * 0.02),
        padding: EdgeInsets.all(screenWidth * 0.02),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order['storeName'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    order['orderTime'] ?? '',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    order['productNames'] ?? '',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '${order['totalPrice']}원',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewPage(
                            storeName: order['storeName'] ?? '',
                            productNames: order['productNames'] ?? '',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      '리뷰 쓰기',
                      style: TextStyle(
                        fontFamily: 'MangoDdobak',
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                      fixedSize: Size(screenWidth, screenWidth * 0.07),
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12, vertical: screenWidth * 0.035),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder<String?>(
                future: fetchImageUrl(storeId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    String? imageUrl = snapshot.data;
                    return imageUrl != null
                        ? Container(
                            width: screenWidth * 0.6, // 정사각형으로 만들기 위해 너비와 높이를 같게 설정
                            height: screenWidth * 0.4,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.contain, // 이미지가 컨테이너를 꽉 채우도록 설정
                              ),
                              borderRadius: BorderRadius.circular(12), // 필요한 경우, 모서리를 둥글게 설정
                            ),
                          )
                        : Placeholder(
                            fallbackWidth: screenWidth * 0.1,
                            fallbackHeight: screenWidth * 0.1,
                          );
                  }
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
}