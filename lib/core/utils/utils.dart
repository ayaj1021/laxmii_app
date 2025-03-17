// Future<void> _selectStartDate() async {
//     final now = DateTime.now();
//     final DateTimeRange? picked = await showDateRangePicker(
//       helpText: 'Select date range',
//       context: context,
//       initialDateRange: _selectedStartDate,
//       firstDate: DateTime(2000),
//       barrierColor: Colors.white,
//       lastDate: DateTime(now.year, now.month, now.day),
//       saveText: 'Done',
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: AppColors.primaryColor,

//               surface: AppColors.primary101010, // Background color
//               onSurface: Colors.white, // Text color
//               secondary: AppColors.primaryColor.withOpacity(0.5),
//             ),
//             dialogBackgroundColor: AppColors.primary101010,
//             scaffoldBackgroundColor: AppColors.primary101010,
//             appBarTheme: const AppBarTheme(
//               backgroundColor: Colors.blue,
//               foregroundColor: Colors.white,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.white, // Button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null && picked != _selectedStartDate) {
//       setState(() {
//         _selectedStartDate = picked;
//       });
//     }
//   }

import 'package:intl/intl.dart';

class AppUtils {
  // static String formatDate(date) {
  //   return DateFormat('d MMM, yy').format(date);
  // }

  static formatAppDate(String date) {
    DateTime parsedDate = DateTime.parse(date);

    String formattedDate = DateFormat('d MMM, yy').format(parsedDate);
    DateFormat("MMM d yyyy").format(parsedDate);

    return formattedDate;
  }
}
