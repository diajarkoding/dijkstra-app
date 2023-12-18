import 'package:dijkstra_app/astar.dart';
import 'package:dijkstra_app/data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var data = [];
  String option = '';

  void aStar() {
    // Data graf

    // Objek graf
    Graph3 graph3 = Graph3(adjacencyList: adjacencyList);

    // Cari rute dari A ke E dengan minimal 2 atau 3 opsi
    List<Map<String, Object>> results =
        graph3.aStar("Unper", "Perumahan Pelangi Residence", 2);

    // Tampilkan hasil
    for (int i = 0; i < results.length; i++) {
      print("**Rute ${results[i]['distance']} km (Opsi ${i + 1})**");
      print(results[i]['shortestPath']);

      setState(() {
        option =
            'Rute : ${results[i]['shortestPath']} dengan jarak : ${results[i]['distance']} km\n';

        data.add(option);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dijkstra'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: data
              .asMap()
              .entries
              .map((entry) => Column(
                    children: [
                      Text('Opsi rute ke ${entry.key + 1}'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          entry.value,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ))
              .toList(),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: aStar,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes
      ),
    );
  }
}
