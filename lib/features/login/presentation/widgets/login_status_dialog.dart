import 'package:flutter/material.dart';

class LoginStatusDialog extends StatelessWidget {
  final String title;
  final String? message;
  final bool processing;
  const LoginStatusDialog(
      {Key? key, required this.title, this.message, this.processing = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      children: [
        processing
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()),
                ),
              )
            : const SizedBox(),
        message != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(message!),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          textStyle: const TextStyle(color: Colors.white)),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Back"))
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
