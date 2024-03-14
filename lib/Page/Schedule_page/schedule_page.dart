import 'package:flutter/material.dart';
import 'package:basic/style/style.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // Track the checked state of each exercise
  Map<String, bool> exerciseCheckedState = {
    "Morning: 30 minutes of jogging": false,
    "Afternoon: 20 minutes of bodyweight exercises": false,
    "Evening: Yoga for relaxation": false,
  };

  // Calorie values for each exercise
  Map<String, int> exerciseCalories = {
    "Morning: 30 minutes of jogging": 200,
    "Afternoon: 20 minutes of bodyweight exercises": 150,
    "Evening: Yoga for relaxation": 100,
  };

  // Food recommendations for each day of the week
  Map<String, String> foodRecommendations = {
    "Monday":
        "Breakfast: Scrambled eggs with toast\nLunch: Caesar salad\nSnack: Apple slices\nDinner: Grilled salmon with quinoa",
    "Tuesday":
        "Breakfast: Greek yogurt with berries\nLunch: Turkey sandwich\nSnack: Mixed nuts\nDinner: Vegetarian stir-fry",
    "Wednesday":
        "Breakfast: Oatmeal with banana\nLunch: Caprese sandwich\nSnack: Carrot sticks\nDinner: Baked chicken with sweet potatoes",
    "Thursday":
        "Breakfast: Smoothie with spinach and berries\nLunch: Quinoa salad\nSnack: Orange slices\nDinner: Shrimp stir-fry",
    "Friday":
        "Breakfast: Avocado toast\nLunch: Tuna salad wrap\nSnack: Greek yogurt with granola\nDinner: Beef and vegetable kebabs",
    "Saturday":
        "Breakfast: Pancakes with maple syrup\nLunch: Chicken caesar wrap\nSnack: Trail mix\nDinner: Spaghetti with marinara sauce",
    "Sunday":
        "Breakfast: Bagel with cream cheese\nLunch: Spinach and feta omelette\nSnack: Pear slices\nDinner: Grilled steak with asparagus",
  };

  // Dummy data for daily exercises
  Map<String, List<String>> dailyExerciseData = {
    "Monday": [
      "Morning: 30 minutes of jogging",
      "Afternoon: 20 minutes of bodyweight exercises",
      "Evening: Yoga for relaxation",
    ],
    "Tuesday": [
      "Morning: 20 minutes of cycling",
      "Afternoon: 15 minutes of weight lifting",
      "Evening: Meditation",
    ],
    "Wednesday": [
      "Morning: 40 minutes of swimming",
      "Afternoon: 30 minutes of yoga",
      "Evening: Stretching exercises",
    ],
    "Thursday": [
      "Morning: 25 minutes of running",
      "Afternoon: 20 minutes of bodyweight exercises",
      "Evening: Pilates",
    ],
    "Friday": [
      "Morning: 30 minutes of cycling",
      "Afternoon: 15 minutes of weight lifting",
      "Evening: Yoga for relaxation",
    ],
    "Saturday": [
      "Morning: 40 minutes of swimming",
      "Afternoon: 30 minutes of yoga",
      "Evening: Stretching exercises",
    ],
    "Sunday": [
      "Morning: 25 minutes of running",
      "Afternoon: 20 minutes of bodyweight exercises",
      "Evening: Pilates",
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorbase,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: appbarcolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Food Recommendation Today",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(getFoodRecommendationForToday(),
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: appbarcolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Daily Exercises",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    buildDailyExercises(),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () =>
                          calculateBurnedCalories(exerciseCheckedState),
                      child: const Text("Calculate Burned Calories"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getFoodRecommendationForToday() {
    DateTime now = DateTime.now();
    String dayOfWeek = "";
    switch (now.weekday) {
      case DateTime.monday:
        dayOfWeek = "Monday";
        break;
      case DateTime.tuesday:
        dayOfWeek = "Tuesday";
        break;
      case DateTime.wednesday:
        dayOfWeek = "Wednesday";
        break;
      case DateTime.thursday:
        dayOfWeek = "Thursday";
        break;
      case DateTime.friday:
        dayOfWeek = "Friday";
        break;
      case DateTime.saturday:
        dayOfWeek = "Saturday";
        break;
      case DateTime.sunday:
        dayOfWeek = "Sunday";
        break;
    }
    return foodRecommendations[dayOfWeek] ?? "No recommendation available.";
  }

  Widget buildDailyExercises() {
    DateTime now = DateTime.now();
    String dayOfWeek = "";
    switch (now.weekday) {
      case DateTime.monday:
        dayOfWeek = "Monday";
        break;
      case DateTime.tuesday:
        dayOfWeek = "Tuesday";
        break;
      case DateTime.wednesday:
        dayOfWeek = "Wednesday";
        break;
      case DateTime.thursday:
        dayOfWeek = "Thursday";
        break;
      case DateTime.friday:
        dayOfWeek = "Friday";
        break;
      case DateTime.saturday:
        dayOfWeek = "Saturday";
        break;
      case DateTime.sunday:
        dayOfWeek = "Sunday";
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dailyExerciseData[dayOfWeek]!
          .map(
            (exercise) => CheckboxListTile(
              title:
                  Text(exercise, style: const TextStyle(color: Colors.white)),
              value: exerciseCheckedState[exercise] ?? false,
              onChanged: (bool? value) {
                setState(() {
                  exerciseCheckedState[exercise] = value!;
                });
              },
            ),
          )
          .toList(),
    );
  }

  void calculateBurnedCalories(Map<String, bool> dailyExercises) {
    int totalCalories = 0;

    for (var exercise in dailyExercises.entries) {
      if (exercise.value) {
        totalCalories += exerciseCalories[exercise.key] ?? 0;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Burned Calories"),
          content: Text("You burned $totalCalories calories."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
