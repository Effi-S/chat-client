import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  ErrorDialog({
    Key key,
    @required this.message,
    @required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text('Retry'),
          onPressed: onRetry,
        ),
      ],
    );
  }
}