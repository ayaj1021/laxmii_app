import 'package:flutter/material.dart';

// Future<void> selectDate(
//     {required BuildContext context, required DateTime? selectedDate, required Function on}) async {
//   final DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: selectedDate ?? DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2100),
//     builder: (context, child) {
//       return Theme(
//         data: ThemeData.dark(),
//         child: child!,
//       );
//     },
//   );

// return picked;
// }

Future<DateTime?> selectDate({
  required BuildContext context,
  required DateTime? selectedDate,
  DateTime? lastDate,
}) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: lastDate ?? DateTime(2100),
    // builder: (context, child) {
    //   return Theme(
    //     data: ThemeData.dark(),
    //     child: child!,
    //   );
    // },
  );

  return pickedDate;
}
