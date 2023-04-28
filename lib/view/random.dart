import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number/model/random_model.dart';

class RandomNumber extends StatefulWidget {
  const RandomNumber({super.key});

  @override
  State<RandomNumber> createState() => _RandomNumberState();
}

class _RandomNumberState extends State<RandomNumber> {
  int correct = 0;
  int counter = 0;
  int randomNumber1 = 0;
  int randomNumber2 = 0;
  int incorrect = 0;
  int finalcorrect = 0;
  int finalincorrect = 0;

  Randomm r = Randomm();
  void state(String a) {
    if (counter == 10) {
      counter = 0;
      print(counter);
      print(correct);
      print(incorrect);
      finalcorrect = correct;
      finalincorrect = incorrect;
      correct = 0;
      incorrect = 0;
    } else if (r.clicker(a, randomNumber1, randomNumber2) == "incorrect") {
      incorrect++;
      counter++;
    } else {
      correct++;
      counter++;
    }
  }

  void re() {
    incorrect = 0;
    correct = 0;
    counter = 0;
    finalcorrect = 0;
    finalincorrect = 0;
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    randomNumber1 = random.nextInt(100);
    randomNumber2 = random.nextInt(100);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random number generator"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(50),
                    ),
                    onPressed: () {
                      setState(() {
                        state("one");
                      });
                    },
                    child: Text("$randomNumber1"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(50)),
                    onPressed: () {
                      setState(() {
                        state("two");
                      });
                    },
                    child: Text(
                      "$randomNumber2",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text("Correct:$finalcorrect "),
              const SizedBox(height: 20),
              Text("Incorrect:$finalincorrect "),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5)),
                onPressed: () {
                  setState(() {
                    re();
                  });
                },
                child: const Text(
                  "Restart",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
