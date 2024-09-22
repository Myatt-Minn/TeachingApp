import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String count;
  final String actionText;
  final Function onPressed;
  const PanelWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.count,
      required this.actionText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 30, color: Colors.black),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            Text(
              count,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  onPressed();
                },
                child: Text(actionText,
                    style: const TextStyle(color: Color(0xFF8E2DE2))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
