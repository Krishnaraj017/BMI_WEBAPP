import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required String title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _result = '';
  late AnimationController _animationController;
  late Animation<double> _buttonAnimation;
  late Animation<double> _containerAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _buttonAnimation = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _containerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _textAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        _result = 'Please enter valid values.';
      });
      return;
    }

    final bmi = weight / (height * height);
    final status = bmi < 18.5
        ? 'Underweight'
        : bmi < 25
            ? 'Normal'
            : bmi < 30
                ? 'Overweight'
                : 'Obese';

    setState(() {
      _result = 'BMI: ${bmi.toStringAsFixed(2)}, Status: $status';
    });
  }

  void _resetFields() {
    _heightController.text = '';
    _weightController.text = '';
    setState(() {
      _result = '';
    });
    _animationController.reverse(); // Add this line to reverse the animation
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors
            .green, // Set the accent color to green for the ElevatedButton
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 20),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 218, 215, 215),
        appBar: AppBar(
          title: const Text('BMI Calculator'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 2, 94, 169),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ScaleTransition(
                    scale: _textAnimation,
                    // child: const Text(
                    //   'BMI Calculator',
                    //   style: TextStyle(
                    //       fontSize: 28,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.amber),
                    //   textAlign: TextAlign.center,
                    // ),
                  ),
                  const SizedBox(height: 24),
                  FadeTransition(
                    opacity: _containerAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.lightGreen,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _heightController,
                            decoration: InputDecoration(
                              labelText: 'Height (meters)',
                              prefixIcon: Icon(Icons.height),
                              border: OutlineInputBorder(
                                // Add Material Design border
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              fillColor: Colors.lime,
                              // Set the background color of the field
                              filled:
                                  true, // Set to true to fill the field with the specified color
                            ),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _weightController,
                            decoration: InputDecoration(
                              labelText: 'Weight (kilograms)',
                              prefixIcon: Icon(Icons.line_weight),
                              border: OutlineInputBorder(
                                // Add Material Design border
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              fillColor: Colors
                                  .lime, // Set the background color of the field
                              filled:
                                  true, // Set to true to fill the field with the specified color
                            ),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ScaleTransition(
                    scale: _buttonAnimation,
                    child: ElevatedButton(
                      onPressed: () {
                        _calculateBMI();
                        _animationController.forward();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .green, // Set the background color of the button
                      ),
                      child: const Text(
                        'Calculate BMI',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeTransition(
                    opacity: _textAnimation,
                    child: Text(
                      _result,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: ScaleTransition(
          scale: _buttonAnimation,
          child: FloatingActionButton(
            onPressed: () {
              _resetFields();
              _animationController.reverse();
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}
