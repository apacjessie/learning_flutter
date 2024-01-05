import 'package:flutter/material.dart';

Dismissible tile(id, task, isComplete, toggleTaskCompletion, deleteTask) {
  return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) => deleteTask(id),
      child: Column(
        children: [
          CheckboxListTile(
            value: isComplete,
            onChanged: (_) => toggleTaskCompletion(id),
            activeColor: Colors.black,
            checkColor: Colors.white,
            tileColor: isComplete
                ? const Color(0xFF2ecc71)
                : Colors.grey.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            title: Text(
              task,
              style: TextStyle(color: isComplete ? Colors.white : Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ));
}
