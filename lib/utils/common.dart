import 'package:intl/intl.dart';

String getCurrentDate() {
  var dateUtc = DateTime.now().toUtc().add(const Duration(hours: 9));

  return DateFormat('yyyy-MM-dd HH:mm').format(dateUtc);
}
