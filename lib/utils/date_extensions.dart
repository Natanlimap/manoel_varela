//create a extension for DateTime class that do dd/mm/yyyy
extension DateTimeExtension on DateTime {
  String get dayMonthYear {
    return "${this.day.toString().padLeft(2, '0')}/${this.month.toString().padLeft(2, '0')}/${this.year.toString().padLeft(4, '0')}";
  }
}
