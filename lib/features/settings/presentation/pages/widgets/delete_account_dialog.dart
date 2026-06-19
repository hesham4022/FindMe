import 'package:flutter/material.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';

class DeleteAcountDialog {
  static void show(BuildContext context, {required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('deleteAccount'.ts),
          content: Text('deleteAccountConfirmation'.ts),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('cancel'.ts),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: Text(
                'delete'.ts,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
