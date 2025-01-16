import 'package:intl/intl.dart';

String formatDateTime(String isoString) {
  try {
    DateTime dateTime = DateTime.parse(isoString);
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
    
    return formattedDate;
  } catch (e) {
    return '';
  }
}
