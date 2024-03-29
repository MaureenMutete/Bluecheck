import 'package:flutter/material.dart';
import 'package:bluecheck/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showGenericDialog<void>(
    context: context,
    title: 'Ooops',
    content: text,
    optionsBuilder: () => {
      'OK': null
    },
  );
}
