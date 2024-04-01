import 'package:intl/intl.dart';

extension TimeConverter on String {
  String toLocalTime(String timeZone) {
    try {
      DateTime dateTime = DateTime.parse(this);
      switch (timeZone) {
        case 'WIB':
          dateTime = dateTime.add(const Duration(hours: 7));
          break;
        case 'WITA':
          dateTime = dateTime.add(const Duration(hours: 8));
          break;
        case 'WIT':
          dateTime = dateTime.add(const Duration(hours: 9));
          break;
        default:
          return '';
      }
      String formattedTime = DateFormat('HH:mm').format(dateTime);
      return '$formattedTime $timeZone';
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }
}
