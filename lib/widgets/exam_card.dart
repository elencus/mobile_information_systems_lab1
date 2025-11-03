import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_information_systems_lab1/models/exam_model.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final bool isPast = exam.dateTime.isBefore(DateTime.now());
    // final Duration timeRemaining = exam.dateTime.difference(DateTime.now());
    final String dateFormatted = DateFormat('dd MMM yyyy').format(exam.dateTime);
    final String timeFormatted = DateFormat('HH:mm').format(exam.dateTime);
    final String rooms = exam.rooms.join(', ');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: Card(
        elevation: 2,
        color: isPast ? Colors.grey[100] : _getCardColor(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.pushNamed(context, '/details', arguments: exam);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateBadge(context, dateFormatted, timeFormatted, isPast),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exam.subjectName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isPast ? Colors.grey[600] : Theme.of(context).colorScheme.onSurface,
                          decoration: isPast ? TextDecoration.lineThrough : TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.location_on_outlined,
                        rooms,
                        isPast ? Colors.grey[500]! : Colors.grey[700]!,
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: isPast ? Colors.grey[400] : Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateBadge(BuildContext context, String date, String time, bool isPast) {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: isPast ? Colors.grey[300] : Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            date.split(' ')[0], // den
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isPast ? Colors.grey[600] : Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          Text(
            date.split(' ')[1], // mesec
            style: TextStyle(
              fontSize: 12,
              color: isPast ? Colors.grey[600] : Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 2),
          Container(
            height: 1,
            color: isPast ? Colors.grey[400] : Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
          const SizedBox(height: 2),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isPast ? Colors.grey[600] : Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: color),
          ),
        ),
      ],
    );
  }

  Color _getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : Theme.of(context).colorScheme.surface;
  }
}