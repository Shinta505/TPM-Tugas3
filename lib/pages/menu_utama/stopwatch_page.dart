import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchPage> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  final List<String> _laps = [];
  final List<Duration> _lapDiffs = [];
  bool _showResetButton = false;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStopwatch() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {});
    });
    setState(() {
      _showResetButton = false;
    });
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
    setState(() {
      _showResetButton = true;
    });
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    _laps.clear();
    _lapDiffs.clear();
    setState(() {
      _showResetButton = false;
    });
  }

  void _lapTime() {
    setState(() {
      Duration lapTime = _stopwatch.elapsed;
      Duration diff = _laps.isEmpty
          ? lapTime
          : lapTime -
              Duration(
                  milliseconds:
                      int.parse(_laps.first.replaceAll(RegExp(r'[^\d]'), '')));
      _laps.insert(0, _formattedTime(lapTime));
      _lapDiffs.insert(0, diff);
    });
  }

  String _formattedTime(Duration duration) {
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    int centiseconds = (duration.inMilliseconds ~/ 10) % 100;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')},${centiseconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Aplikasi Stopwatch",
          style: TextStyle(color: Color(0xffffffff)),
        ),
        backgroundColor: const Color(0xFF2C5E36),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          SizedBox(height: 100),
          Text(
            _formattedTime(_stopwatch.elapsed),
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          SizedBox(
            height: 250,
            child: Scrollbar(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _laps.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(
                      '${_laps.length - index}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      _laps[index],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '+${_formattedTime(_lapDiffs[index])}',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 20),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 50,
                  child: ElevatedButton(
                    onPressed:
                        _stopwatch.isRunning ? _stopStopwatch : _startStopwatch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFF6B6B),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(_stopwatch.isRunning ? "Hentikan" : "Mulai"),
                  ),
                ),
                SizedBox(width: 30),
                SizedBox(
                  width: 140,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _showResetButton ? _resetStopwatch : _lapTime,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffA7C7E7),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(_showResetButton ? "Reset" : "Putaran"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
