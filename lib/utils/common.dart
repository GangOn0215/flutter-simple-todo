import 'package:intl/intl.dart';

DateTime getUtcKrDateTime() {
  return DateTime.now().toUtc().add(const Duration(hours: 9));
}

String getCurrentDateTime() {
  return DateFormat('yyyy-MM-dd HH:mm').format(getUtcKrDateTime());
}

String getCurrentDate() {
  return DateFormat('yyyy-MM-dd').format(getUtcKrDateTime());
}

// date - 2023-03-11
String setDateTomorrow(String date) {
  DateTime tomorrow = DateTime.parse(date).add(const Duration(days: 1));

  return DateFormat('yyyy-MM-dd').format(tomorrow);
}

String setDateYesterday(String date) {
  DateTime yesterday = DateTime.parse(date).add(const Duration(days: -1));

  return DateFormat('yyyy-MM-dd').format(yesterday);
}
