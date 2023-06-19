import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:get/get.dart' as getx;

class InfoDialog {
  static Future<bool?> dialogConfirmation(
    BuildContext context,
    String title,
    String content, {
    String textNo = 'いいえ',
    String textYes = 'はい',
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(textNo),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(textYes),
            ),
          ],
        );
      },
    );
  }

  static void dialogError(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return SimpleDialog(
          children: [
            Center(
              child: Icon(
                Icons.error_outline_outlined,
                color: Colors.red[700],
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  static void dialogSuccess(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return SimpleDialog(
          children: [
            Center(
              child: Icon(
                Icons.check_circle_outline_outlined,
                color: Colors.green[700],
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  static void dialogNetral(BuildContext context, String message,
      {IconData? icon}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return SimpleDialog(
          children: [
            if (icon != null)
              Center(
                child: Icon(
                  icon,
                  color: Colors.blue[700],
                  size: 40,
                ),
              ),
            if (icon != null) const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  static void closeDialog(BuildContext context,
      {Duration? durationBeforeClose, Function? actionAfterClose}) {
    Future.delayed(
      durationBeforeClose ?? const Duration(milliseconds: 2500),
      () {
        Navigator.pop(context);
        if (actionAfterClose != null) actionAfterClose.call();
      },
    );
  }

  static simpleDialog(
    BuildContext context,
    String message, [
    String closeText = '閉じる',
  ]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          children: [
            Icon(
              Icons.info_outline,
              color: Theme.of(context).primaryColor,
              size: 40,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(closeText),
              ),
            ),
          ],
        );
      },
    );
  }

  static customDialog({
    required BuildContext context,
    required Widget content,
    Widget? icon,
    Widget? layer2,
    String closeText = '閉じる',
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.all(20),
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: icon,
                    ),
                    content,
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 40,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(closeText),
                      ),
                    ),
                  ],
                ),
                layer2 ?? const SizedBox(),
              ],
            ),
          ],
        );
      },
    );
  }

  static void toastError(String message, {bool isLong = false}) {
    toast.Fluttertoast.showToast(
      msg: message,
      toastLength: isLong ? toast.Toast.LENGTH_LONG : toast.Toast.LENGTH_SHORT,
      gravity: toast.ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red[100],
      textColor: Colors.red[900],
      fontSize: 16,
    );
  }

  static void toastSuccess(String message, {bool isLong = false}) {
    toast.Fluttertoast.showToast(
      msg: message,
      toastLength: isLong ? toast.Toast.LENGTH_LONG : toast.Toast.LENGTH_SHORT,
      gravity: toast.ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green[100],
      textColor: Colors.green[900],
      fontSize: 16,
    );
  }

  static void toastNetral(String message, {bool isLong = false}) {
    toast.Fluttertoast.showToast(
      msg: message,
      toastLength: isLong ? toast.Toast.LENGTH_LONG : toast.Toast.LENGTH_SHORT,
      gravity: toast.ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue[100],
      textColor: Colors.blue[900],
      fontSize: 16,
    );
  }

  static void closeToast() {
    toast.Fluttertoast.cancel();
  }

  static void snackBarError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.red[900]),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red[100],
      ),
    );
  }

  static void snackBarSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.green[900]),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green[100],
      ),
    );
  }

  static void snackBarNetral(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.blue[900]),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blue[100]!,
      ),
    );
  }

  static void snackBarCustom(
    BuildContext context,
    String message, {
    Color? color,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }

  static void closeSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  static void closeNotification() {
    getx.Get.closeAllSnackbars();
  }

  static void notificationError(
    String title,
    String message, {
    double radius = 12,
    bool showBorder = false,
  }) {
    getx.Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red[100],
      colorText: Colors.red[900],
      borderColor: showBorder ? Colors.red[900] : Colors.transparent,
      borderRadius: radius,
      borderWidth: showBorder ? 1 : 0,
      isDismissible: false,
    );
  }

  static void notificationSuccess(
    String title,
    String message, {
    double radius = 12,
    bool showBorder = false,
  }) {
    getx.Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green[100],
      colorText: Colors.green[900],
      borderColor: showBorder ? Colors.green[900] : Colors.transparent,
      borderRadius: radius,
      borderWidth: showBorder ? 1 : 0,
      isDismissible: false,
    );
  }

  static void notificationNetral(
    String title,
    String message, {
    double radius = 12,
    bool showBorder = false,
  }) {
    getx.Get.snackbar(
      title,
      message,
      backgroundColor: Colors.blue[100],
      colorText: Colors.blue[900],
      borderColor: showBorder ? Colors.blue[900] : Colors.transparent,
      borderRadius: radius,
      borderWidth: showBorder ? 1 : 0,
      isDismissible: false,
    );
  }
}
