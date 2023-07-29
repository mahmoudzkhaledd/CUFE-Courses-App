import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';


import '../../GeneralWidgets/CustomTextBox.dart';

class ChooseCourseWidget extends StatelessWidget {
  const ChooseCourseWidget({
    super.key,
    required this.onSubmit,
    required this.chosenCourse,
    required this.onDeleteCourse, 
    required this.fetchData,
  });

  final Function(String) onSubmit;
  final VoidCallback onDeleteCourse;
  final String chosenCourse;
  final FutureOr<Iterable<Object>> Function(TextEditingValue) fetchData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black38),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Choose The Course",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (chosenCourse.isNotEmpty)
            Column(
              children: [
                const SizedBox(height: 10),
                Chip(
                  onDeleted: onDeleteCourse,
                  label: Text(
                    chosenCourse,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 10),
          Autocomplete(
            optionsBuilder: fetchData,
            fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) =>
            CustomTextBox(
              hintText: "Search Course",
              focusNode: focusNode,
              onComplete: () {
                onFieldSubmitted();
                focusNode.unfocus();
                onSubmit(textEditingController.text);
                textEditingController.clear();
              },
              controller: textEditingController,
              icon: Icons.subject,
            ),
          ),
        ],
      ),
    );
  }
}
