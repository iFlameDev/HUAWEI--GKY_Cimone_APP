// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class DatePicker extends StatefulWidget {
  DateTime selectedDate = DateTime.now();

  @override
  _DatePickerState createState() => _DatePickerState();

  String getDate() {
    return DateFormat('dd MMMM yyyy').format(selectedDate).toString();
  }
}

class _DatePickerState extends State<DatePicker> {
  _selectDate(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
        return buildMaterialDatePicker(context);
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _selectDate(context);
  }

  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != widget.selectedDate)
                  // ignore: curly_braces_in_flow_control_structures
                  setState(() {
                    widget.selectedDate = picked;
                  });
              },
              initialDateTime: widget.selectedDate,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      helpText: 'Select booking date',
      cancelText: 'Not now',
      confirmText: 'Book',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Booking date',
      fieldHintText: 'Month/Date/Year',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: Container(child: child),
        );
      },
    );
    if (picked != null && picked != widget.selectedDate)
      setState(() {
        widget.selectedDate = picked;
      });
  }
}

// BoxRegister(
    //   verticalContainer: 0,
    //   child: OutlinedButton(
    //     style: OutlinedButton.styleFrom(
    //         side: const BorderSide(color: Colors.transparent),
    //         padding: const EdgeInsets.symmetric(horizontal: -20, vertical: 17)),
    //     onPressed: () {
    //       // _selectDate(context);
    //     },
    //     child: Row(
    //       // ignore: prefer_const_literals_to_create_immutables
    //       children: [
    //         const getIcon(
    //             icon: FontAwesomeIcons.calendarDay,
    //             horizontalPadding: 20,
    //             color: Colors.black),
    //         // Text(
    //         //    birthdayText,
    //         //   style: kBodyTextBlack,
    //         // ),
    //         const SizedBox(width: 20),
    //       ],
    //     ),
    //   ),
    // );

// // ============================================== Date Picker DIRTY CODE==============================================================
//     // ignore: prefer_typing_uninitialized_variables
//     DateTime selectedDate = DateTime.now();
//     String birthdayText = "Birthday";

// // ============================================= CONSTRUCT DATEPICKER ============================

//     buildCupertinoDatePicker(BuildContext context) {
//       showModalBottomSheet(
//           context: context,
//           builder: (BuildContext builder) {
//             return Container(
//               height: MediaQuery.of(context).copyWith().size.height / 3,
//               color: Colors.white,
//               child: CupertinoDatePicker(
//                 mode: CupertinoDatePickerMode.date,
//                 onDateTimeChanged: (picked) {
//                   if (picked != null && picked != selectedDate)
//                     // ignore: curly_braces_in_flow_control_structures
//                     setState(() {
//                       selectedDate = picked;
//                       birthdayText = DateFormat('dd MMMM yyyy')
//                           .format(selectedDate)
//                           .toString();
//                     });
//                 },
//                 initialDateTime: selectedDate,
//                 minimumYear: 2000,
//                 maximumYear: 2025,
//               ),
//             );
//           });
//     }

//     buildMaterialDatePicker(BuildContext context) async {
//       final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2025),
//         initialEntryMode: DatePickerEntryMode.calendar,
//         initialDatePickerMode: DatePickerMode.day,
//         helpText: 'Select booking date',
//         cancelText: 'Not now',
//         confirmText: 'Book',
//         errorFormatText: 'Enter valid date',
//         errorInvalidText: 'Enter date in valid range',
//         fieldLabelText: 'Booking date',
//         fieldHintText: 'Month/Date/Year',
//         builder: (context, child) {
//           return Theme(
//             data: ThemeData.light(),
//             child: Container(child: child),
//           );
//         },
//       );
//       if (picked != null && picked != selectedDate)
//         // ignore: curly_braces_in_flow_control_structures
//         setState(() {
//           selectedDate = picked;
//           print(birthdayText);
//           birthdayText =
//               DateFormat('dd MMMM yyyy').format(selectedDate).toString();
//           print(birthdayText);
//         });
//     }

// //============================================= PLATFORM DETECTOR =======================================
//     _selectDate(BuildContext context) {
//       final ThemeData theme = Theme.of(context);
//       assert(theme.platform != null);
//       switch (theme.platform) {
//         case TargetPlatform.android:
//           return buildMaterialDatePicker(context);
//         case TargetPlatform.fuchsia:
//         case TargetPlatform.linux:
//         case TargetPlatform.windows:
//           return buildMaterialDatePicker(context);
//         case TargetPlatform.iOS:
//         case TargetPlatform.macOS:
//           return buildCupertinoDatePicker(context);
//       }
//     }
