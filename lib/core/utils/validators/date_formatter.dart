import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  // Day of the month with suffix (1st, 2nd, 3rd, etc.)
  String daySuffix(int day) {
    if (day >= 10 && day <= 20) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1: return '${day}st';
      case 2: return '${day}nd';
      case 3: return '${day}rd';
      default: return '${day}th';
    }
  }

  // Format the date
  String formattedDate = DateFormat('EEEE d MMMM, yyyy').format(date);
  // Add the suffix to the day of the month
  int day = date.day;
  formattedDate = formattedDate.replaceFirst('$day', daySuffix(day));
  
  return formattedDate;
}

