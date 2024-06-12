class ReviewData {
  final String userNumber;
  final String storeName;
  final String productNames;
  final List<String> selectedFeedbacks;
  final List<String> deliveryFeedbacks;
  final double rating;

  ReviewData({
    required this.userNumber,
    required this.storeName,
    required this.productNames,
    required this.selectedFeedbacks,
    required this.deliveryFeedbacks,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    // selectedFeedbacks와 deliveryFeedbacks가 공백이면 "좋아요"로 대체
    String selectedFeedbacksStr = selectedFeedbacks.isEmpty ? '메뉴 맛있어요' : selectedFeedbacks.join(', ');
    String deliveryFeedbacksStr = deliveryFeedbacks.isEmpty ? '배달파트너 좋아요' : deliveryFeedbacks.join(', ');

    // 두 값이 모두 "좋아요"라면 하나의 "좋아요"만 포함
    String reviewContent;
    if (selectedFeedbacksStr == '메뉴 맛있어요' && deliveryFeedbacksStr == '배달파트너 좋아요') {
      reviewContent = '완전 완전 만족해요';
    } else {
      reviewContent = selectedFeedbacksStr + ' ' + deliveryFeedbacksStr;
    }

    return {
      'userNumber': userNumber,
      'storeName': storeName,
      'productNames': productNames,
      'reviewContent': reviewContent,
      'rating': rating.toString(),
    };
  }
}