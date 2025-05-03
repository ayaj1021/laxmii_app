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

import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  // static String formatDate(date) {
  //   return DateFormat('d MMM, yy').format(date);
  // }

  // static formatAppDate(String date) {
  //   DateTime parsedDate = DateTime.parse(date);

  //   String formattedDate = DateFormat('d MMM, yy').format(parsedDate);
  //   DateFormat("MMM d yyyy").format(parsedDate);

  //   return formattedDate;
  // }

  // static String formatAppDate(String date) {
  //   // Parse the input date string with the correct format
  //   DateTime parsedDate = DateFormat('MMM d, yyyy').parse(date);

  //   // Format the parsed date into your desired format
  //   String formattedDate = DateFormat('d MMM, yy').format(parsedDate);

  //   return formattedDate;
  // }

  static String formatAppDate(String date) {
    // Parse ISO date string
    DateTime parsedDate = DateTime.parse(date);

    // Format the parsed date into your desired format
    String formattedDate = DateFormat('d MMM, yy').format(parsedDate);

    return formattedDate;
  }

  static Future<void> launchURL(String url) async {
    if (await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView)) {
      await launchUrl(
          Uri.parse(
            url,
          ),
          mode: LaunchMode.inAppBrowserView);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<File?> pickImage(
      {ImageSource source = ImageSource.gallery}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 800,
        imageQuality: 85, // Compress image quality (0-100)
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        log('No image selected.');
        return null;
      }
    } catch (e) {
      log('Error picking image: $e');
      return null;
    }
  }

  static Future<void> launchWhatsApp({String? message}) async {
    String phone = '+447984247913';

    // Remove any non-digit characters from the phone number
    phone = phone.replaceAll(RegExp(r'\D'), '');

    // Add your message

    // Try multiple URL formats to increase compatibility
    List<Uri> possibleUris = [
      // Standard web URL format (often works best)
      Uri.parse(
          "https://wa.me/$phone?text=${Uri.encodeComponent(message ?? 'I need help')}"),

      // Direct WhatsApp scheme with phone
      Uri.parse(
          "whatsapp://send?phone=$phone&text=${Uri.encodeComponent(message ?? 'I need help')}"),

      // Alternative format sometimes used
      Uri.parse(
          "https://api.whatsapp.com/send?phone=$phone&text=${Uri.encodeComponent(message ?? 'I need help')}")
    ];

    bool launched = false;

    // Try each URI until one works
    for (var uri in possibleUris) {
      try {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          launched = true;
          break;
        }
      } catch (e) {
        continue;
      }
    }

    if (!launched) {
      // As a fallback, try just opening WhatsApp
      try {
        final Uri fallbackUri = Uri.parse("whatsapp://");
        if (await canLaunchUrl(fallbackUri)) {
          await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
          launched = true;
        }
      } catch (e) {
        log(e.toString());
      }
    }

    // If still not launched, try opening the Play Store/App Store
    // if (!launched) {
    //   try {
    //     // This will open WhatsApp in the app store if not installed
    //     final Uri storeUri = Uri.parse(
    //         Theme.of(context).platform == TargetPlatform.iOS
    //             ? "https://apps.apple.com/app/whatsapp-messenger/id310633997"
    //             : "https://play.google.com/store/apps/details?id=com.whatsapp");

    //     if (await canLaunchUrl(storeUri)) {
    //       setState(() {
    //         _errorMessage = 'Opening WhatsApp download page...';
    //       });
    //       await launchUrl(storeUri, mode: LaunchMode.externalApplication);
    //     } else {
    //       setState(() {
    //         _errorMessage = errorMsg;
    //       });
    //     }
    //   } catch (e) {
    //     setState(() {
    //       _errorMessage = 'Error: ${e.toString()}';
    //     });
    //   }
    // }
  }

  // Future<void> _openWhatsApp() async {
  //   // Try multiple approaches to open WhatsApp
  //   List<Uri> possibleUris = [
  //     Uri.parse("whatsapp://"),
  //     Uri.parse("https://web.whatsapp.com"), // Web fallback
  //     Uri.parse("whatsapp://send") // Alternative format
  //   ];

  //   bool launched = false;
  //   String errorMsg = 'Could not launch WhatsApp';

  //   for (var uri in possibleUris) {
  //     try {
  //       if (await canLaunchUrl(uri)) {
  //         await launchUrl(uri, mode: LaunchMode.externalApplication);
  //         launched = true;
  //         break;
  //       }
  //     } catch (e) {
  //       errorMsg = 'Error: ${e.toString()}';
  //       continue;
  //     }
  //   }

  //   if (!launched) {
  //     setState(() {
  //       _errorMessage = errorMsg;
  //     });
  //   }
  // }
}
