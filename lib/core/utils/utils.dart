import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static String formatAppDate(String date) {
    // Parse the custom format
    DateTime parsedDate = DateFormat('MMMM d, yyyy').parse(date);

    // Format to desired format
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
  }
}

class AppDateFormatter {
  static String formatAppDate(String date) {
    DateTime parsedDate;

    // List of formats we want to try
    final formats = [
      "yyyy-MM-dd'T'HH:mm:ss", // ISO with time
      "yyyy-MM-dd", // ISO date only
      "MMM d, yyyy 'at' H", // Sep 4, 2025 at 0
      "MMM d, yyyy", // Sep 4, 2025
      "MMMM d, yyyy 'at' H", // September 4, 2025 at 0
      "MMMM d, yyyy", // September 4, 2025
    ];

    try {
      // First try ISO parsing (built-in)
      parsedDate = DateTime.parse(date);
    } catch (_) {
      parsedDate = _tryCustomFormats(date, formats);
    }

    return DateFormat('d MMM, yy').format(parsedDate);
  }

  static DateTime _tryCustomFormats(String date, List<String> formats) {
    for (final format in formats) {
      try {
        return DateFormat(format).parse(date);
      } catch (_) {
        // continue trying
      }
    }
    throw FormatException("Unrecognized date format: $date");
  }
}
