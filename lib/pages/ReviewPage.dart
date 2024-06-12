import 'dart:convert';
import 'package:delivery/dto/review_dto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReviewPage extends StatefulWidget {
  final String storeName;
  final String productNames;
  final String userNumber;

  ReviewPage({
    Key? key,
    required this.storeName,
    required this.productNames,
    required this.userNumber,
  }) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int reviewsCount = 0;
  late List<bool> stars;
  bool _isLiked = false;
  bool _isDisliked = false;
  bool _deliveryLiked = false;
  bool _deliveryDisliked = false;
  List<String> selectedFeedbacks = [];
  List<String> deliveryFeedbacks = [];

  @override
  void initState() {
    super.initState();
    stars = List<bool>.filled(5, false);
    _fetchReviewsCount();
  }

  Future<void> _fetchReviewsCount() async {
    final prefs = await SharedPreferences.getInstance();
    int? reviewsCount = prefs.getInt('reviewsCount') ?? 0;
    // 받아온 리뷰 개수를 UI에 반영하기 위해 상태를 업데이트
    setState(() {
      reviewsCount = reviewsCount;
    });
  }

  void _sendReviewToServer() async {
    double rating = stars.where((star) => star).length.toDouble();
    var reviewData = ReviewData(
      userNumber: widget.userNumber,
      storeName: widget.storeName,
      productNames: widget.productNames,
      selectedFeedbacks: selectedFeedbacks,
      deliveryFeedbacks: deliveryFeedbacks,
      rating: rating,
    );

    var url = Uri.parse('http://localhost:8080/reviews'); // 서버 URL을 적절히 수정하세요.
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(reviewData.toJson()),
    );

    if (response.statusCode == 200) {
      print('Review has been saved');

      // 리뷰 수를 SharedPreferences에 저장
      final prefs = await SharedPreferences.getInstance();
      int? reviewsCount = prefs.getInt('reviewsCount') ?? 0;
      await prefs.setInt('reviewsCount', reviewsCount + 1);

      // 리뷰 개수 업데이트
      _fetchReviewsCount();
    } else {
      print('Failed to save review: ${response.statusCode}');
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('등록되었습니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                Navigator.of(context).pop(); // 이전 화면으로 돌아가기
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '만족도 평가 및 리뷰',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1, vertical: screenWidth * 0.1),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.store,
                    size: screenWidth * 0.1,
                    color: Colors.blue,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    '음식 평가',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.02),
              Text(
                widget.storeName,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenWidth * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      stars[index] ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                      size: screenWidth * 0.06,
                    ),
                    onPressed: () {
                      setState(() {
                        for (int i = 0; i <= index; i++) {
                          stars[i] = true;
                        }
                        for (int i = index + 1; i < 5; i++) {
                          stars[i] = false;
                        }
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: screenWidth * 0.04),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productNames,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_up,
                        color: _isLiked ? Colors.blue : Colors.grey),
                    onPressed: () {
                      setState(() {
                        _isLiked = !_isLiked;
                        _isDisliked = false;
                      });
                    },
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  IconButton(
                    icon: Icon(Icons.thumb_down,
                        color: _isDisliked ? Colors.blue : Colors.grey),
                    onPressed: () {
                      setState(() {
                        _isDisliked = !_isDisliked;
                        _isLiked = false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.04),
              if (_isDisliked)
                ExpansionTile(
                  title: Text(
                    selectedFeedbacks.isEmpty
                        ? "피드백을 선택해주세요"
                        : selectedFeedbacks.join(', '),
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
                    Icons.motorcycle,
                    size: screenWidth * 0.1,
                    color: Colors.blue,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "배달 파트너",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_up,
                        color: _deliveryLiked ? Colors.blue : Colors.grey),
                    onPressed: () {
                      setState(() {
                        _deliveryLiked = !_deliveryLiked;
                        _deliveryDisliked = false;
                      });
                    },
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  IconButton(
                    icon: Icon(Icons.thumb_down,
                        color: _deliveryDisliked ? Colors.blue : Colors.grey),
                    onPressed: () {
                      setState(() {
                        _deliveryDisliked = !_deliveryDisliked;
                        _deliveryLiked = false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.02),
              if (_deliveryDisliked)
                ExpansionTile(
                  title: Text(
                    deliveryFeedbacks.isEmpty
                        ? "피드백을 선택해주세요"
                        : deliveryFeedbacks.join(', '),
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
            _sendReviewToServer();
            _showSuccessDialog(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 0),
          ),
          child: Text(
            '등록하기',
            style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackTile(String feedback) {
    return ListTile(
      title: Text(
        feedback,
        style: TextStyle(color: Colors.black),
      ),
      trailing: selectedFeedbacks.contains(feedback)
          ? Icon(Icons.check, color: Colors.blue)
          : null,
      onTap: () {
        setState(() {
          if (selectedFeedbacks.contains(feedback)) {
            selectedFeedbacks.remove(feedback);
          } else {
            selectedFeedbacks.add(feedback);
          }
        });
      },
    );
  }

  Widget _buildDeliveryTile(String feedbackdel) {
    return ListTile(
      title: Text(
        feedbackdel,
        style: TextStyle(color: Colors.black),
      ),
      trailing: deliveryFeedbacks.contains(feedbackdel)
          ? Icon(Icons.check, color: Colors.blue)
          : null,
      onTap: () {
        setState(() {
          if (deliveryFeedbacks.contains(feedbackdel)) {
            deliveryFeedbacks.remove(feedbackdel);
          } else {
            deliveryFeedbacks.add(feedbackdel);
          }
        });
      },
    );
  }
}
