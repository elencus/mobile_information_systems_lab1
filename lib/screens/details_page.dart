import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_information_systems_lab1/models/exam_model.dart';

class DetailsPage extends StatelessWidget {
  final Exam exam;

  const DetailsPage({super.key, required this.exam});

  String getCountdownString(Duration difference) {
    if (difference.isNegative) {
      final int daysAgo = difference.inDays.abs();
      return "Exam completed $daysAgo ${daysAgo == 1 ? 'day' : 'days'} ago";
    }

    final int days = difference.inDays;
    final int hours = difference.inHours % 24;
    final int minutes = difference.inMinutes % 60;

    if (days > 0) {
      return "$days ${days == 1 ? 'day' : 'days'} and $hours ${hours == 1 ? 'hour' : 'hours'} left";
    } else if (hours > 0) {
      return "$hours ${hours == 1 ? 'hour' : 'hours'} and $minutes ${minutes == 1 ? 'minute' : 'minutes'} left";
    } else {
      return "$minutes ${minutes == 1 ? 'minute' : 'minutes'} left";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Duration timeRemaining = exam.dateTime.difference(DateTime.now());
    final String countdown = getCountdownString(timeRemaining);
    final bool isPast = timeRemaining.isNegative;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isPast
                        ? [Colors.grey, Colors.grey[700]!]
                        : [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primaryContainer,
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.school_rounded,
                        size: 48,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        exam.subjectName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isPast ? Colors.grey[100] : Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isPast ? Colors.grey[300]! : Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            isPast ? "EXAM COMPLETED" : "TIME REMAINING",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isPast ? Colors.grey[600] : Theme.of(context).colorScheme.primary,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            countdown,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: isPast ? Colors.grey[700] : Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "Exam Details",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailCard(
                      context,
                      icon: Icons.calendar_month_rounded,
                      title: "Date & Time",
                      content: DateFormat('EEEE, MMMM dd, yyyy').format(exam.dateTime),
                      subtitle: "${DateFormat('HH:mm').format(exam.dateTime)} hours",
                    ),
                    const SizedBox(height: 12),
                    _buildDetailCard(
                      context,
                      icon: Icons.location_on_rounded,
                      title: "Location",
                      content: exam.rooms.join(', '),
                      subtitle: "Exam rooms",
                    ),
                    const SizedBox(height: 12),
                    _buildDetailCard(
                      context,
                      icon: Icons.access_time_filled_rounded,
                      title: "Status",
                      content: isPast ? "Completed" : "Scheduled",
                      subtitle: isPast ? "This exam is over" : "Waiting to take place",
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String content,
        required String subtitle,
      }) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}