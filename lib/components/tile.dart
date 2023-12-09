import 'package:flutter/material.dart';

CheckboxListTile tile(index, task, isComplete, toggleTaskCompletion) {
  return CheckboxListTile(
    value: isComplete,
    onChanged: (_) => toggleTaskCompletion(index),
    activeColor: Colors.blue,
    checkColor: Colors.white,
    tileColor:
        isComplete ? Colors.blue.withOpacity(0.8) : Colors.red.withOpacity(0.8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    secondary: isComplete
        ? const Icon(Icons.check, color: Colors.white)
        : const Icon(Icons.close),
    title: Text(
      task,
      style: TextStyle(color: isComplete ? Colors.white : Colors.black),
    ),
  );
}
