import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selecteddate = DateTime.now();

  final DatePickerController controller = DatePickerController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: DatePicker(
                DateTime.now().subtract(const Duration(days: 30)),
                controller: controller,
                initialSelectedDate: selecteddate,
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  selecteddate = date;
                },
              ),
            ),
            Text(
                'You have selected\n${DateFormat.yMMMd().format(selecteddate)}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    //what code to write here to achieve it
                    setState(() {
                      selecteddate =
                          DateTime.now().subtract(const Duration(days: 1));

                      controller.animateToDate(selecteddate);
                    });
                  },
                  child: const Text('Yesterday'),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        selecteddate = DateTime.now();
                        controller.animateToDate(selecteddate);
                      });
                    },
                    child: const Text('Today')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        selecteddate =
                            DateTime.now().add(const Duration(days: 1));
                        controller.animateToDate(selecteddate);
                      });
                    },
                    child: const Text('Tomorrow'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
