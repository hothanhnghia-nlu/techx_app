import 'package:flutter/material.dart';

class DialogUtils {
  // Hàm tĩnh để hiển thị AlertDialog
  static Future<dynamic> showAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    String buttonLabel = 'Đóng',
    Color titleColor = Colors.red, // Màu tiêu đề (đỏ cho lỗi, xanh cho thành công)
    Color buttonColor = Colors.grey, // Màu nền nút
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: titleColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center, // Căn giữa nội dung
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center, // Căn giữa nút
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, buttonLabel),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }

  // Hàm tĩnh để hiển thị thông báo lỗi
  static Future<dynamic> showErrorDialog({
    required BuildContext context,
    required String message,
  }) {
    return showAlertDialog(
      context: context,
      title: 'Lỗi',
      message: message,
      titleColor: Colors.red, // Màu đỏ cho lỗi
      buttonColor: Colors.red, // Nút màu đỏ
    );
  }

  // Hàm tĩnh để hiển thị thông báo thành công
  static Future<dynamic> showSuccessDialog({
    required BuildContext context,
    required String message,
  }) {
    return showAlertDialog(
      context: context,
      title: 'Thành công',
      message: message,
      titleColor: Colors.green, // Màu xanh cho thành công
      buttonColor: Colors.green, // Nút màu xanh
    );
  }
}
