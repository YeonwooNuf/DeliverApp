import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  // 각각의 변수를 final로 선언하여 변경 불가능하게 만듭니다.
  final String restaurantName;
  final String orderDetails;

  // 생성자에서 모든 변수를 필수적으로 받도록 설정합니다.
  ReviewPage({
    Key? key,
    required this.restaurantName,
    required this.orderDetails,
  }) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late List<bool> stars; // 별점을 저장할 리스트
  bool _isLiked = false; // 추천 상태
  bool _isDisliked = false; // 비추천 상태
  bool _deliveryLiked = false; // 추천 상태
  bool _deliveryDisliked = false; // 비추천 상태
  List<String> selectedFeedbacks = [];
  List<String> deliveryFeedbacks = [];

  @override
  void initState() {
    super.initState();
    stars = List<bool>.filled(5, false); // 별점을 5개로 초기화하고 모두 false(비선택)로 설정
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 뒤로 가기 버튼
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context); // 화면을 이전 페이지로 이동
          },
        ),
        title: Text(
          '만족도 평가 및 리뷰', // 앱바 제목
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // 제목을 중앙에 위치
        backgroundColor: Colors.white, // 앱바 배경색을 흰색으로 설정
        elevation: 0, // 앱바 그림자 제거
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenWidth * 0.1), // 패딩 설정
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 자식들을 시작 지점에서 정렬
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start, // Row 내부 아이템을 왼쪽 정렬
                children: [
                  Icon(
                    Icons.store, // 가게 아이콘
                    size: screenWidth * 0.1, // 아이콘 크기
                    color: Colors.blue, // 아이콘 색상
                  ),
                  SizedBox(width: screenWidth * 0.02), // 아이콘과 텍스트 사이 간격
                  Text(
                    '음식 평가', // 텍스트 내용
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.02), // 간격
              Text(
                widget.restaurantName, // 생성자를 통해 전달받은 가게 이름
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenWidth * 0.02), // 간격
              // 별점을 나타내는 부분
              Row(
                mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      stars[index] ? Icons.star : Icons.star_border, // 별점 상태에 따라 아이콘 결정
                      color: Colors.orange, // 별 색상
                      size: screenWidth * 0.06, // 별 크기
                    ),
                    onPressed: () {
                      setState(() {
                        // 선택된 별 이하의 모든 별을 채워지게 하고 나머지는 빈 상태로 설정
                        for (int i = 0; i <= index; i++) {
                          stars[i] = true; // 선택한 별과 그 이전 별들을 채움
                        }
                        for (int i = index + 1; i < 5; i++) {
                          stars[i] = false; // 선택한 별 이후의 별들은 빈 상태로 설정
                        }
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: screenWidth * 0.04), // 높이 간격
              // 주문 상세 정보와 좋아요/싫어요 버튼을 포함하는 부분
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.orderDetails, // 생성자를 통해 전달받은 주문 상세 정보
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_up, color: _isLiked ? Colors.blue : Colors.grey),
                    onPressed: () {
                      setState(() {
                        _isLiked = !_isLiked; // 좋아요 상태 토글
                        _isDisliked = false; // 싫어요 상태는 false로 설정
                      });
                    },
                  ),
                  SizedBox(width: screenWidth * 0.04), // 너비 간격
                  IconButton(
                    icon: Icon(Icons.thumb_down, color: _isDisliked ? Colors.blue : Colors.grey),
                    onPressed: () {
                      setState(() {
                        _isDisliked = !_isDisliked; // 싫어요 상태 토글
                        _isLiked = false; // 좋아요 상태는 false로 설정
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.04),
              // FeedbackTile 배달 파트너 위로 이동
              if (_isDisliked)
                ExpansionTile(
                  title: Text(
                    selectedFeedbacks.isEmpty
                        ? "피드백을 선택해주세요"
                        : selectedFeedbacks.join(', '), // 선택한 피드백이 있으면 그것을 표시
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  children: <Widget>[
                    _buildFeedbackTile('양이 적음'),
                    _buildFeedbackTile('너무 짬'),
                    _buildFeedbackTile('너무 싱거움'),
                    _buildFeedbackTile('식었음'),
                    _buildFeedbackTile('너무 비쌈'),
                  ],
                ),
              SizedBox(height: screenWidth * 0.04),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.motorcycle, // 배달 아이콘
                    size: screenWidth * 0.1, // 아이콘 크기
                    color: Colors.blue, // 아이콘 색상
                  ),
                  SizedBox(width: screenWidth * 0.02), // 아이콘과 텍스트 사이 간격
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "배달 파트너", // 생성자를 통해 전달받은 주문 상세 정보
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_up, color: _deliveryLiked ? Colors.blue : Colors.grey),
                    onPressed: () {
                      setState(() {
                        _deliveryLiked = !_deliveryLiked; // 좋아요 상태 토글
                        _deliveryDisliked = false; // 싫어요 상태는 false로 설정
                      });
                    },
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  IconButton(
                    icon: Icon(Icons.thumb_down, color: _deliveryDisliked ? Colors.blue : Colors.grey),
                    onPressed: () {
                      setState(() {
                        _deliveryDisliked = !_deliveryDisliked; // 싫어요 상태 토글
                        _deliveryLiked = false; // 좋아요 상태는 false로 설정
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.02), // 간격
              if (_deliveryDisliked)
                ExpansionTile(
                  title: Text(
                    deliveryFeedbacks.isEmpty
                        ? "피드백을 선택해주세요"
                        : deliveryFeedbacks.join(', '), // 선택한 피드백이 있으면 그것을 표시
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  children: <Widget>[
                    _buildDeliveryTile('늦게 도착'),
                    _buildDeliveryTile('흘렀음/훼손됨'),
                    _buildDeliveryTile('요청사항 불이행'),
                    _buildDeliveryTile('불친절'),
                    _buildDeliveryTile('음식 온도'),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: screenWidth * 0.15,
        decoration: BoxDecoration(
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              spreadRadius: screenWidth * 0.01,
              blurRadius: screenWidth * 0.02,
              offset: Offset(0, screenWidth * 0.007),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // 버튼을 클릭했을 때 실행할 내용을 여기에 작성하세요.
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // 버튼의 배경색을 파란색으로 변경
            padding: EdgeInsets.symmetric(vertical: 0), // 버튼의 수직 패딩 추가
          ),
          child: Text(
            '등록하기',
            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold), // 버튼의 글씨색을 흰색으로 변경
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackTile(String feedback) {
    return ListTile(
      title: Text(feedback, style: TextStyle(color: Colors.black),),
      trailing: selectedFeedbacks.contains(feedback)
          ? Icon(Icons.check, color: Colors.blue) // 선택된 항목에 체크 표시
          : null,
      onTap: () {
        setState(() {
          if (selectedFeedbacks.contains(feedback)) {
            selectedFeedbacks.remove(feedback); // 이미 리스트에 있으면 제거
          } else {
            selectedFeedbacks.add(feedback); // 리스트에 없으면 추가
          }
        });
      },
    );
  }
  Widget _buildDeliveryTile(String feedbackdel) {
    return ListTile(
      title: Text(feedbackdel, style: TextStyle(color: Colors.black),),
      trailing: deliveryFeedbacks.contains(feedbackdel)
          ? Icon(Icons.check, color: Colors.blue) // 선택된 항목에 체크 표시
          : null,
      onTap: () {
        setState(() {
          if (deliveryFeedbacks.contains(feedbackdel)) {
            deliveryFeedbacks.remove(feedbackdel); // 이미 리스트에 있으면 제거
          } else {
            deliveryFeedbacks.add(feedbackdel); // 리스트에 없으면 추가
          }
        });
      },
    );
  }
}
