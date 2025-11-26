
import 'package:flutter/material.dart';

import '../models/exam_model.dart';

class ExamAppBar extends StatelessWidget implements PreferredSizeWidget{

  const ExamAppBar({super.key, required this.isExpired, required this.exam});

  final bool isExpired;
  final ExamModel exam;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min, // important: don't expand the Row
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              exam.name,
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis, // shrink long titles
            ),
          ),
          if (isExpired) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'EXPIRED',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );

  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}