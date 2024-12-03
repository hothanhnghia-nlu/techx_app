import 'package:intl/intl.dart';

      // Định dạng đơn vị tiền tệ
    String formatCurrency(double orginalCurrency) {
      var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫',decimalDigits: 0,);
      return formatter.format(orginalCurrency);
    }
