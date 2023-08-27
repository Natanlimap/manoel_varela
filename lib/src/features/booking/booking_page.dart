import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manoel_varela/constant/colors.dart';
import 'package:manoel_varela/constant/texts.dart';
import 'package:manoel_varela/entities/books_entity.dart';
import 'package:manoel_varela/src/features/booking/booking_controller.dart';
import 'package:manoel_varela/utils/date_extensions.dart';

class BookingPage extends StatefulWidget {
  final BookType bookType;
  const BookingPage({super.key, required this.bookType});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  BookingController bookingController = Get.find();

  List<DateTime?> _singleDatePickerValueWithDefaultValue = [];
  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    String valueText = '';
    if (values.isNotEmpty) {
      valueText =
          '${(values[0]!.day).toString().padLeft(2, "0")}/${(values[0]!.month).toString().padLeft(2, "0")}/${values[0]!.year}';
    }

    return valueText;
  }

  Widget _buildDefaultSingleDatePickerWithValue(List<BookEntity> books) {
    final config = CalendarDatePicker2Config(
        selectedDayHighlightColor: primaryColor,
        weekdayLabels: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
        weekdayLabelTextStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        firstDayOfWeek: 1,
        controlsHeight: 50,
        controlsTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        dayTextStyle: const TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
        disabledDayTextStyle: const TextStyle(
          color: Colors.grey,
        ),
        selectableDayPredicate: (day) {
          final isNegative = day
              .difference(DateTime.now().subtract(const Duration(days: 1)))
              .isNegative;
          return !isNegative &&
              !books.any((element) =>
                  element.dateTime == day && element.type == widget.bookType);
        });
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CalendarDatePicker2(
            config: config,
            value: _singleDatePickerValueWithDefaultValue,
            onValueChanged: (dates) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Confirmar agendamento",
                        textAlign: TextAlign.center,
                        style: titleh2,
                      ),
                      content: Text(
                        "Você deseja agendar a ${widget.bookType.name} para o dia ${_getValueText(CalendarDatePicker2Type.single, dates)}?",
                        textAlign: TextAlign.center,
                      ),
                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                            setState(() {});
                          },
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(primaryColor)),
                          onPressed: () {
                            final date = dates.first;
                            if (date == null) return;
                            bookingController.doBook(widget.bookType, date);
                            bookingController.getAllBooks();

                            Get.back();
                            setState(() {});
                          },
                          child: const Text("Confirmar"),
                        ),
                      ],
                    );
                  });
            }),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 120,
        title: Text(
          widget.bookType.name,
          style: titleh1,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.chevron_left,
            color: primaryColor,
            size: 32,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                ValueListenableBuilder(
                    valueListenable: bookingController.allBooks,
                    builder: (context, value, _) {
                      //only maps the books that are the same type as the current page
                      final books = value
                          .where((element) => element.type == widget.bookType)
                          .toList();

                      return Column(
                        children: [
                          _buildDefaultSingleDatePickerWithValue(value),
                          Text("Data reservadas", style: actionLabel),
                          const SizedBox(height: 8),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: books.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ListTile(
                                    title: Text(
                                        books[index].dateTime.dayMonthYear,
                                        style: textBody),
                                    subtitle: Text("${books[index].name}",
                                        style: textBody),
                                  ),
                                );
                              }),
                        ],
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
