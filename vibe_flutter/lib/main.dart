import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 204, 180, 74)),
      ),
      home: const MyHomePage(),
    );
  }
}

class TimerUI extends StatelessWidget {
    final String time;

   const TimerUI({super.key, required this.time});
    
    @override
    Widget build(BuildContext context) {
      return Text(time, style: TextStyle(fontSize: 50));
    }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      debugPrint('$_counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('VibeFlutter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const TimerUI(time: "00:00:00"),
            const SizedBox(height: 16),
            const Text("elapsed"),
            const SizedBox(height: 32),
              Padding(padding: .symmetric(horizontal: 32), child: 
                Row(
                  mainAxisAlignment: .center,
                  children: [
                  Expanded(child: ElevatedButton(onPressed: (){}, child: const Text("Start"))),
                  const SizedBox(width: 16),  // gap between buttons
                  Expanded(child: ElevatedButton(onPressed: (){}, child: const Text("Reset")))
                ])
              ),
          ],
        ),
      )
    );
  }
}
