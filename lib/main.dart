import 'package:flutter/material.dart';

void main() {
  runApp(const GradesApp());
}

class GradesApp extends StatelessWidget {
  const GradesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ציונים',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 114, 64, 201)),
        useMaterial3: true,
      ),
      // עברית - כיוון מימין לשמאל
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      home: const GradesPage(),
    );
  }
}

class Student {
  Student({required this.name, required this.score});

  final String name;
  int score;

  bool get passed => score >= 70;
}

class GradesPage extends StatefulWidget {
  const GradesPage({super.key});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  final List<Student> students = [
    Student(name: 'נועה', score: 97),
    Student(name: 'דנה', score: 71),
    Student(name: 'יוסף', score: 54),
    Student(name: 'עומר', score: 48),
  ];

  double get average {
    if (students.isEmpty) return 0;
    final sum = students.fold<int>(0, (total, s) => total + s.score);
    return sum / students.length;
  }

  void _changeScore(Student student, int delta) {
    setState(() {
      student.score = (student.score + delta).clamp(0, 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    final avgText = average == average.roundToDouble()
        ? average.toStringAsFixed(0)
        : average.toStringAsFixed(1);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('ממוצע: $avgText'),
      ),
      drawer: const Drawer(
        child: Center(child: Text('תפריט')),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return ListTile(
            leading: Icon(
              student.passed ? Icons.check_circle : Icons.cancel,
              color: student.passed ? Colors.green : Colors.red,
            ),
            title: Text(student.name),
            subtitle: Text('ציון: ${student.score}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => _changeScore(student, -1),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _changeScore(student, 1),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
