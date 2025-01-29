import 'package:intl/intl.dart';

// String formatDateTime(String? dateTimeString) {
//   if (dateTimeString == null || dateTimeString.isEmpty) {
//     return 'No date';
//   }

//   try {
//     final DateTime parsedDate = DateTime.parse(dateTimeString);
//     return DateFormat('MMM dd').format(parsedDate);
//   } catch (e) {
//     print('Error parsing date: $e');
//     return 'Invalid date';
//   }
// }

String formatDateTimeFromString(String? dateTimeString) {
  if (dateTimeString == null || dateTimeString.isEmpty) {
    return 'No date';
  }

  try {
    final DateTime parsedDate = DateTime.parse(dateTimeString);
    return DateFormat('MMM dd').format(parsedDate);
  } catch (e) {
    return 'Invalid date';
  }
}
