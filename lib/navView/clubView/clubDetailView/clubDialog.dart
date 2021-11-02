import 'package:flutter/material.dart';

import 'package:my_flutter_source/functionCollection.dart';

showClubDialog({required BuildContext context, required title, required positiveAction, required negativeAction, dynamic confirmAction}) async {
  return (await showDialog(
    context: context,
    builder: (context) => ClubDialog(title: title, positiveAction: positiveAction, negativeAction: negativeAction, confirmAction: confirmAction)
  )) ?? false;
}

class ClubDialog extends StatefulWidget {
  final String title;
  final dynamic positiveAction;
  final dynamic negativeAction;
  final dynamic confirmAction;
  ClubDialog({required this.title, required this.positiveAction, required this.negativeAction, required this.confirmAction});

  @override
  State<ClubDialog> createState() => _ClubDialog(title: title, positiveAction: positiveAction, negativeAction: negativeAction, confirmAction: confirmAction);
}

class _ClubDialog extends State<ClubDialog> {
  String title;
  dynamic positiveAction;
  dynamic negativeAction;
  dynamic confirmAction;
  _ClubDialog({required this.title, required this.positiveAction, required this.negativeAction, required this.confirmAction});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: dialogBox()
    );
  }

  dialogBox() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          dialogTitle(),
          dialogSelection(),
        ]
      )
    );
  }

  dialogTitle() {
    return Container(
      height: 112,
      child: Center(
        child: Text(title, style: textStyle(weight: 400, size: 16.0))
      )
    );
  }
  dialogSelection() {
    return Container(
      height: 52,
      child: Row(
        children: confirmAction == null ? [
          selectionBox('아니요', negativeAction),
          selectionBox('네', positiveAction),
        ] : [
          selectionBox('확인', confirmAction),
        ],
      )
    );
  }
  selectionBox(String title, dynamic action) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          action();
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffebebeb), width: 1),
            color: Color(0xfffbfbfb),
          ),
            child: Center(
              child: Text(title, style: textStyle(color: Color(0xff0958c5), weight: 600, size: 14.0)
            )
          )
        )
      )
    );
  }
}