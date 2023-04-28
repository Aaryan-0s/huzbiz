class Randomm {
  int counter = 0;
  int correct = 0;
  int incorrect = 0;
  String clicker(String a, int randomNumber1, int randomNumber2) {
    if (a == "one") {
      if (randomNumber1 > randomNumber2) {
        return "correct";
      } else {
        return "incorrect";
      }
    } else {
      if (randomNumber2 > randomNumber1) {
        return "correct";
      } else {
        return "incorrect";
      }
    }
  }
}
