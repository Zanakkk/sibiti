// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:math';

class GradingPage extends StatefulWidget {
  const GradingPage({super.key});

  @override
  _GradingPageState createState() => _GradingPageState();
}

class _GradingPageState extends State<GradingPage> {
  List<Item> items = [];
  List<List<bool>> studentAnswers = [];

  @override
  void initState() {
    super.initState();
    // Generate dummy data for items
    for (int i = 1; i <= 15; i++) {
      items.add(
        Item(
          id: i,
          content: 'Pertanyaan $i',
          difficulty: Random().nextDouble() *
              0.5, // Random difficulty between 0 and 0.5
          discrimination:
              Random().nextDouble(), // Random discrimination between 0 and 1
        ),
      );
    }

    // Generate dummy data for student answers
    for (int i = 0; i < 100; i++) {
      List<bool> answers = [];
      for (int j = 0; j < 15; j++) {
        answers.add(Random().nextBool()); // Random true/false answers
      }
      studentAnswers.add(answers);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List<bool>> sortedStudentAnswers = List.from(studentAnswers);

// Urutkan list baru berdasarkan jumlah jawaban benar siswa
    sortedStudentAnswers.sort((a, b) =>
        countCorrectStudentAnswers(b).compareTo(countCorrectStudentAnswers(a)));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Halaman Grading'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Skor per masing-masing pertanyaan:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  double score =
                      calculateItemScore(items[index], studentAnswers);
                  int correctAnswers =
                      countCorrectAnswers(items[index], studentAnswers);
                  int incorrectAnswers = studentAnswers.length - correctAnswers;
                  return ListTile(
                    title: Text(
                        'Item ${items[index].id}: ${items[index].content}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Skor: ${score.toStringAsFixed(2)}'),
                        Text(
                            'Jumlah yang benar: $correctAnswers dari 100 siswa'),
                        Text(
                            'Jumlah yang salah: $incorrectAnswers dari 100 siswa'),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Skor per masing-masing siswa:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ), // Buat list baru yang merupakan salinan dari studentAnswers

// Tampilkan list baru dalam ListView.builder
            Expanded(
              child: ListView.builder(
                itemCount: sortedStudentAnswers.length,
                itemBuilder: (BuildContext context, int index) {
                  int correctAnswers =
                      countCorrectStudentAnswers(sortedStudentAnswers[index]);
                  int incorrectAnswers =
                      sortedStudentAnswers[index].length - correctAnswers;
                  return ListTile(
                    title: Text('Siswa ${index + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jawaban Benar: $correctAnswers'),
                        Text('Jawaban Salah: $incorrectAnswers'),
                      ],
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: studentAnswers.length,
                itemBuilder: (BuildContext context, int index) {
                  double score =
                      calculateStudentScore(items, studentAnswers[index]);
                  int correctAnswers =
                      countCorrectStudentAnswers(studentAnswers[index]);
                  int incorrectAnswers =
                      studentAnswers[index].length - correctAnswers;
                  return ListTile(
                    title: Text('Siswa ${index + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Skor: ${score.toStringAsFixed(2)}'),
                        Text('Jawaban Benar: $correctAnswers'),
                        Text('Jawaban Salah: $incorrectAnswers'),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(
              children: [
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Pertanyaan ',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                          'Item ${getHighestScoreItem(items, studentAnswers).id}: ${getHighestScoreItem(items, studentAnswers).content}'),
                      Text(
                          'Skor: ${getHighestScoreItemScore(items, studentAnswers).toStringAsFixed(2)}'),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                          'Item ${getLowestScoreItem(items, studentAnswers).id}: ${getLowestScoreItem(items, studentAnswers).content}'),
                      Text(
                          'Skor: ${getLowestScoreItemScore(items, studentAnswers).toStringAsFixed(2)}'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Siswa ',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                          'Siswa ${getHighestScoreStudentIndex(items, studentAnswers) + 1}'),
                      Text(
                          'Skor: ${getHighestScoreStudentScore(items, studentAnswers).toStringAsFixed(2)}'),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                          'Siswa ${getLowestScoreStudentIndex(items, studentAnswers) + 1}'),
                      Text(
                          'Skor: ${getLowestScoreStudentScore(items, studentAnswers).toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  double calculateItemScore(Item item, List<List<bool>> studentAnswers) {
    double totalScore = 0;
    double maxScore = 0;

    for (int i = 0; i < studentAnswers.length; i++) {
      double probability =
          calculateProbability(item, studentAnswers[i][item.id - 1]);
      double score = log(probability / (1 - probability)) * item.discrimination;
      totalScore += score;
      maxScore += log(1 / (1 - item.difficulty)) * item.discrimination;
    }

    return (totalScore / maxScore) * 1000; // Normalized score to range 0-1000
  }

  int countCorrectAnswers(Item item, List<List<bool>> studentAnswers) {
    int count = 0;
    for (int i = 0; i < studentAnswers.length; i++) {
      if (studentAnswers[i][item.id - 1]) {
        count++;
      }
    }
    return count;
  }

  int countCorrectStudentAnswers(List<bool> studentAnswers) {
    int count = 0;
    for (int i = 0; i < studentAnswers.length; i++) {
      if (studentAnswers[i]) {
        count++;
      }
    }
    return count;
  }

  double calculateProbability(Item item, bool response) {
    double b = item.difficulty;
    double a = item.discrimination;
    return exp(a * (response ? b : -b)) / (1 + exp(a * (response ? b : -b)));
  }

  Item getHighestScoreItem(List<Item> items, List<List<bool>> studentAnswers) {
    double highestScore = -1;
    Item highestScoreItem = items[0];

    for (Item item in items) {
      double score = calculateItemScore(item, studentAnswers);
      if (score > highestScore) {
        highestScore = score;
        highestScoreItem = item;
      }
    }

    return highestScoreItem;
  }

  double getHighestScoreItemScore(
      List<Item> items, List<List<bool>> studentAnswers) {
    double highestScore = -1;

    for (Item item in items) {
      double score = calculateItemScore(item, studentAnswers);
      if (score > highestScore) {
        highestScore = score;
      }
    }

    return highestScore;
  }

  Item getLowestScoreItem(List<Item> items, List<List<bool>> studentAnswers) {
    double lowestScore = double.infinity;
    Item lowestScoreItem = items[0];

    for (Item item in items) {
      double score = calculateItemScore(item, studentAnswers);
      if (score < lowestScore) {
        lowestScore = score;
        lowestScoreItem = item;
      }
    }

    return lowestScoreItem;
  }

  double getLowestScoreItemScore(
      List<Item> items, List<List<bool>> studentAnswers) {
    double lowestScore = double.infinity;

    for (Item item in items) {
      double score = calculateItemScore(item, studentAnswers);
      if (score < lowestScore) {
        lowestScore = score;
      }
    }

    return lowestScore;
  }

  int getHighestScoreStudentIndex(
      List<Item> items, List<List<bool>> studentAnswers) {
    double highestScore = -1;
    int highestScoreStudentIndex = -1;

    for (int i = 0; i < studentAnswers.length; i++) {
      double score = calculateStudentScore(items, studentAnswers[i]);
      if (score > highestScore) {
        highestScore = score;
        highestScoreStudentIndex = i;
      }
    }

    return highestScoreStudentIndex;
  }

  double getHighestScoreStudentScore(
      List<Item> items, List<List<bool>> studentAnswers) {
    double highestScore = -1;

    for (int i = 0; i < studentAnswers.length; i++) {
      double score = calculateStudentScore(items, studentAnswers[i]);
      if (score > highestScore) {
        highestScore = score;
      }
    }

    return highestScore;
  }

  int getLowestScoreStudentIndex(
      List<Item> items, List<List<bool>> studentAnswers) {
    double lowestScore = double.infinity;
    int lowestScoreStudentIndex = -1;

    for (int i = 0; i < studentAnswers.length; i++) {
      double score = calculateStudentScore(items, studentAnswers[i]);
      if (score < lowestScore) {
        lowestScore = score;
        lowestScoreStudentIndex = i;
      }
    }

    return lowestScoreStudentIndex;
  }

  double getLowestScoreStudentScore(
      List<Item> items, List<List<bool>> studentAnswers) {
    double lowestScore = double.infinity;

    for (int i = 0; i < studentAnswers.length; i++) {
      double score = calculateStudentScore(items, studentAnswers[i]);
      if (score < lowestScore) {
        lowestScore = score;
      }
    }

    return lowestScore;
  }

  double calculateStudentScore(List<Item> items, List<bool> studentAnswers) {
    double totalScore = 0;
    double maxScore = 0;

    for (int i = 0; i < items.length; i++) {
      double probability = calculateProbability(items[i], studentAnswers[i]);
      double score =
          log(probability / (1 - probability)) * items[i].discrimination;
      totalScore += score;
      maxScore += log(1 / (1 - items[i].difficulty)) * items[i].discrimination;
    }

    return (totalScore / maxScore) * 1000; // Normalized score to range 0-1000
  }
}

class Item {
  final int id;
  final String content;
  final double difficulty;
  final double discrimination;

  Item({
    required this.id,
    required this.content,
    required this.difficulty,
    required this.discrimination,
  });
}
