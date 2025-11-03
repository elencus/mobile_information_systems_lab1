import 'package:flutter/material.dart';
import 'package:mobile_information_systems_lab1/screens/details_page.dart';
import 'package:mobile_information_systems_lab1/screens/home_page.dart';
import 'models/exam_model.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam Schedule - 223141',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Exam Schedule - 223141'),
        "/details": (context){
          final exam = ModalRoute.of(context)!.settings.arguments as Exam;
          return DetailsPage(exam: exam);
        },
      },
    );
  }
}
