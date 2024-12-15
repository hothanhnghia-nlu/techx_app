import 'package:flutter/material.dart';
import 'package:techx_app/pages/admin/reviews/review_model.dart';
import 'package:techx_app/services/reviews_service.dart';

class ReviewManagementPage extends StatefulWidget {
  const ReviewManagementPage({super.key});
  @override
  _ReviewManagementPageState createState() => _ReviewManagementPageState();
}

class _ReviewManagementPageState extends State<ReviewManagementPage> {
  List<Review> reviews = [];
  List<Review> filteredReviews = [];
  late ReviewService reviewService;

  @override
  void initState() {
    super.initState();
    reviewService = ReviewService();
    fetchReviews(); // Lấy danh sách đánh giá từ API
  }

  Future<void> fetchReviews() async {
     try {
      final fetchedReviews = await reviewService.getAllReviews();
      print('fetchedReviews: $fetchedReviews');
      setState(() {
        reviews = fetchedReviews;
        filteredReviews = reviews;
      });
    } catch (e) {
      print("Error fetching reviews: $e");
    }
  }

  void searchReviews(String query) {
    setState(() {
      filteredReviews = reviews.where((review) {
        return review.userName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void confirmDeleteReview(int id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Xác nhận"),
        content: Text("Bạn có chắc chắn muốn xóa bình luận này?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
            child: Text("Hủy"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
              deleteReview(id); // Thực hiện xóa bình luận
            },
            child: Text("Xóa", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}

  void deleteReview(int id) async {
  try {
    bool success = await reviewService.deleteReview(id);
    if (success) {
      setState(() {
        reviews.removeWhere((review) => review.id == id);
        filteredReviews = reviews;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đã xóa bình luận!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Xóa bình luận thất bại!")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đã xảy ra lỗi: $e")),
    );
  }
}

  void replyToReview(Review review) {
    // Hiển thị dialog trả lời
    showDialog(
      context: context,
      builder: (context) {
        String replyText = "";
        return AlertDialog(
          title: Text("Trả lời đánh giá"),
          content: TextField(
            decoration: InputDecoration(hintText: "Nhập trả lời"),
            onChanged: (value) => replyText = value,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                print("Trả lời: $replyText cho đánh giá ID: ${review.id}");
                // Thực hiện logic gửi trả lời lên API
              },
              child: Text("Gửi"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý đánh giá",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
          ),
        
      ),
      body: Column(
        children: [
          // Ô tìm kiếm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Tìm kiếm theo tên người dùng",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => searchReviews(value),
            ),
          ),
          // Danh sách đánh giá
          Expanded(
            child: ListView.builder(
              itemCount: filteredReviews.length,
              itemBuilder: (context, index) {
                final review = filteredReviews[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text("Sản phẩm ID: ${review.productId}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Người dùng: ${review.userName}"),
                        Text("Đánh giá: ${review.rating} ⭐"),
                        Text("Bình luận: ${review.comment}"),
                        Text(
                          "Ngày tạo: ${review.createdAt.toLocal()}",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.reply, color: Colors.blue),
                          onPressed: () => replyToReview(review),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => confirmDeleteReview(review.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}
