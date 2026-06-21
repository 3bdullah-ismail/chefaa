import 'package:intl/intl.dart';

class ScheduleDateHelper {
  static const List<String> weekOrder = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  static int _dartWeekdayToCustomIndex(int dartWeekday) {
    switch (dartWeekday) {
      case DateTime.saturday:
        return 0;
      case DateTime.sunday:
        return 1;
      case DateTime.monday:
        return 2;
      case DateTime.tuesday:
        return 3;
      case DateTime.wednesday:
        return 4;
      case DateTime.thursday:
        return 5;
      case DateTime.friday:
        return 6;
      default:
        throw Exception('Invalid weekday: $dartWeekday');
    }
  }

  static DateTime getDateForDay(String dayName, {DateTime? referenceDate}) {
    final now = referenceDate ?? DateTime.now();

    final todayIndex = _dartWeekdayToCustomIndex(now.weekday);
    final targetIndex = weekOrder.indexOf(dayName);

    if (targetIndex == -1) {
      throw Exception('Invalid day name: $dayName');
    }

    final todayDateOnly = DateTime(now.year, now.month, now.day);
    final startOfWeek = todayDateOnly.subtract(Duration(days: todayIndex));

    var targetDate = startOfWeek.add(Duration(days: targetIndex));

    if (targetDate.isBefore(todayDateOnly)) {
      targetDate = targetDate.add(const Duration(days: 7));
    }

    return targetDate;
  }

  static String formatScheduleDate(DateTime date) {
    return DateFormat('d MMM').format(date);
  }

  static String formatScheduleDateWithDay(DateTime date) {
    return DateFormat('EEE, d MMM').format(date);
  }

  static String formatMinutesToTime(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    final period = h >= 12 ? 'PM' : 'AM';
    final hour12 = h % 12 == 0 ? 12 : h % 12;
    return '$hour12:${m.toString().padLeft(2, '0')} $period';
  }

  static List<Map<String, dynamic>> buildActiveDaysWithDates(
      List<dynamic> days, {
        DateTime? referenceDate,
      }) {
    final activeDays = days
        .where((d) => d['isActive'] == true)
        .map<Map<String, dynamic>>((d) {
      final date = getDateForDay(d['day'], referenceDate: referenceDate);
      return {
        'day': d['day'],
        'open': d['open'],
        'close': d['close'],
        'breaks': d['breaks'],
        'slotDuration': d['slotDuration'],
        'dailyCapacity': d['dailyCapacity'],
        'patientsPerSlot': d['patientsPerSlot'],
        'isDayLocked': d['isDayLocked'],
        'isBookingLocked': d['isBookingLocked'],
        'date': date,
        'displayDate': formatScheduleDate(date),
        'displayDateWithDay': formatScheduleDateWithDay(date),
        'openTime': formatMinutesToTime(d['open']),
        'closeTime': formatMinutesToTime(d['close']),
      };
    }).toList();

    activeDays.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));

    return activeDays;
  }
}