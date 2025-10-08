import 'package:intl/intl.dart';

String formatDate(String? dateString, {String format = 'dd/MM/yyyy'}) {
  if (dateString == null || dateString.isEmpty) return '';
  final date = DateTime.tryParse(dateString);
  if (date == null) return '';
  return DateFormat(format).format(date);
}
