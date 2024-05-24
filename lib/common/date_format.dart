
import 'package:intl/intl.dart';

String formatDate(String date) {
  final DateTime dateTime = DateTime.parse(date);
  final DateFormat formatter = DateFormat('EEE MMM d, yyyy');
  return formatter.format(dateTime);
}