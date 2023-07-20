import 'package:flutter/material.dart';

import 'bmipage.dart';



class GetStarted extends StatelessWidget {
  const GetStarted({Key? key, required String title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
        hintColor: Colors.orange,
        textTheme: const TextTheme(
          headline6: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 20),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("BMI Calculator"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/bmi.jpg',
                height: 450,
                width: 350,
              ),
              const SizedBox(height: 24),
              Material(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.green, // Replace with your desired button color
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HomePage(title: 'BMI CALCULATOR'),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(50.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 15.0,
                    ),
                    child: const Text(
                      "GET STARTED",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
