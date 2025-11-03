import 'package:flutter/material.dart';
import 'package:mobile_information_systems_lab1/models/exam_model.dart';
import 'package:mobile_information_systems_lab1/widgets/exam_card.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Exam> allExams = [
    Exam(
      subjectName: "Web Programming",
      dateTime: DateTime.now().add(const Duration(days: 5, hours: 2)),
      rooms: ["Lab 13", "Lab 200AB"],
    ),
    Exam(
      subjectName: "Mobile Information Systems",
      dateTime: DateTime.now().add(const Duration(days: 2, hours: 4)),
      rooms: ["Lab 215"],
    ),
    Exam(
      subjectName: "Management Information Systems",
      dateTime: DateTime.now().subtract(const Duration(days: 4, hours: 5)),
      rooms: ["Amphitheatre 1", "Amphitheatre 3"],
    ),
    Exam(
      subjectName: "Software Defined Networks",
      dateTime: DateTime.now().add(const Duration(days: 3, hours: 3)),
      rooms: ["Lab 12"],
    ),
    Exam(
      subjectName: "Introduction to Data Science",
      dateTime: DateTime.now().subtract(const Duration(days: 4, hours: 2)),
      rooms: ["Lab 3", "Lab 2"],
    ),
    Exam(
      subjectName: "Ethical Hacking",
      dateTime: DateTime.now().subtract(const Duration(days: 3, hours: 4)),
      rooms: ["Lab 200AB"],
    ),
    Exam(
      subjectName: "Data Structures and Algorithms",
      dateTime: DateTime.now().add(const Duration(days: 6, hours: 4)),
      rooms: ["Lab 215", "Lab 216"],
    ),
    Exam(
      subjectName: "Cyber Security",
      dateTime: DateTime.now().add(const Duration(days: 5, hours: 3)),
      rooms: ["Lab 200AB", "Lab 215"],
    ),
    Exam(
      subjectName: "Cryptography",
      dateTime: DateTime.now().subtract(const Duration(days: 6, hours: 3)),
      rooms: ["Room 312"],
    ),
    Exam(
      subjectName: "Calculus",
      dateTime: DateTime.now().add(const Duration(days: 1, hours: 0)),
      rooms: ["Amphitheatre 2", "Amphitheatre 4"],
    ),
  ];

  late List<Exam> sortedExams;

  @override
  void initState() {
    super.initState();
    sortedExams = List.from(allExams);
    sortedExams.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  @override
  Widget build(BuildContext context) {
    final int totalExams = sortedExams.length;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 60,
              bottom: 20,
              left: 24,
              right: 24,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Exam Schedule - 223141",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Track your upcoming exams",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: totalExams,
              itemBuilder: (context, index) {
                return ExamCard(exam: sortedExams[index]);
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Center(
              child: Chip(
                backgroundColor: Colors.white,
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.school_outlined,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      totalExams.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Total Exams",
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
