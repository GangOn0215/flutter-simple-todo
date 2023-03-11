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
