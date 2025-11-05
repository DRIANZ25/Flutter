import 'package:flutter/material.dart';


class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}


class _CounterState extends State<Counter> {
  int _counter = 0;


  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 500),
      ),
    );
  }


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _showSnackBar('Incremented!');
  }


  void _decrementCounter() {
    setState(() {
      _counter--;
    });
    _showSnackBar('Decremented!');
  }


  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
    _showSnackBar('Reset!');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Counter',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 10),
                Text(
                  '$_counter',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: Colors.blueAccent),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      onPressed: _incrementCounter,
                      tooltip: 'Increment',
                      child: Icon(Icons.add),
                    ),
                    FloatingActionButton(
                      onPressed: _decrementCounter,
                      tooltip: 'Decrement',
                      child: Icon(Icons.remove),
                    ),
                    FloatingActionButton(
                      onPressed: _resetCounter,
                      tooltip: 'Reset',
                      child: Icon(Icons.refresh),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

