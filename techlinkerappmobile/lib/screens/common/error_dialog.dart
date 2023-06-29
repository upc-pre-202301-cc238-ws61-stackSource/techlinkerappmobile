import 'package:flutter/material.dart';

class ErrorDialog{
  Widget build(BuildContext context, String message){
    return AlertDialog(
      title: const Text('Error'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: const Text('OK')
        )
      ],
    );
  }
}