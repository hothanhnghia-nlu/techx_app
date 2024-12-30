class Review {
  final int id;
  final String userName;
  final String productName;
  final double rating;
  final String comment;
  final int status;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.userName,
    required this.productName,
    required this.rating,
    required this.comment,
    required this.status,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      userName: json['user']['fullName'],
      productName: json['product']['name'],
      rating: json['rating'],
      comment: json['comment'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
