import 'package:dijkstra_app/astar.dart';
import 'package:dijkstra_app/data.dart';
import 'package:dijkstra_app/dijkstra.dart';
import 'package:dijkstra_app/dijkstra2.dart';
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

  void dijkstra() {
    // Membuat objek graf
    Graph graph = Graph();

    // Menambahkan edge berdasarkan studi kasus
    for (var element in edgesData) {
      graph.addEdge(element['source'], element['destination']);
    }

    try {
      // Menjalankan algoritma Dijkstra
      List<Map<String, Object>> results =
          graph.dijkstra('UNPER', 'Perumahan Pelangi');

      String option = '';

      // Menampilkan hasil
      for (int i = 0; i < results.length; i++) {
        print('Opsi Rute ${i + 1}: ${results[i]['shortestPath']}');
        print('Jarak Terpendek: ${results[i]['distance']} km\n');
        setState(() {
          option =
              'Rute : ${results[i]['shortestPath']} dengan jarak : ${results[i]['distance']} km\n';

          data.add(option);
        });
      }

      print(data);
    } on Exception catch (e) {
      print(e);
    }
  }

  void aStar() {
    // Membuat objek graf
    Graph graph = Graph();

    // Menambahkan edge berdasarkan studi kasus
    for (var element in edgesData) {
      graph.addEdge(element['source'], element['destination']);
    }

    try {
      // Menjalankan algoritma A*
      List<Map<String, Object>> results =
          graph.aStar('UNPER', 'Perumahan Pelangi');

      String option = '';

      // Menampilkan hasil
      for (int i = 0; i < results.length; i++) {
        print('Opsi Rute ${i + 1}: ${results[i]['shortestPath']}');
        print('Jarak Terpendek: ${results[i]['distance']} km\n');
        setState(() {
          option =
              'Rute : ${results[i]['shortestPath']} dengan jarak : ${results[i]['distance']} km\n';

          data.add(option);
        });
      }

      print(data);
    } on Exception catch (e) {
      print(e);
    }
  }

  void main() {
    // Data graf
    Map<String, Map<String, double>> adjacencyList = {
      "A": {"B": 1, "C": 3, "D": 7},
      "B": {"A": 1, "C": 1, "E": 5},
      "C": {"A": 3, "B": 1, "D": 2, "E": 1},
      "D": {"A": 7, "C": 2, "E": 2},
      "E": {"B": 5, "C": 1, "D": 2},
    };

    // Objek graf
    Graph2 graph2 = Graph2(adjacencyList: adjacencyList);

    // Cari rute dari Node A ke Node E
    List<Map<String, Object>> results = graph2.dijkstra("A", "E");

    // Tampilkan hasil
    for (Map<String, Object> result in results) {
      print("**Rute ${result['distance']} km**");
      print(result['shortestPath']);
    }
  }

  void main2() {
    // Data graf
    Map<String, Map<String, double>> adjacencyList = {
      "UNPER": {
        "Jalan Batara": 0.2,
        "Jalan Letjen Mashudi": 1.5,
        "Sukaraja": 1.4,
        "Jalan Siliwangi": 0.45
      },
      "Jalan Batara": {"Jalan Letjen Mashudi": 1.3, "Cilolohan": 2.5},
      "Jalan Letjen Mashudi": {"Jalan Siliwangi": 1.2, "Cilolohan": 1.8},
      "Cilolohan": {"Perumahan Pelangi Residence": 0.5},
      "Jalan Siliwangi": {"Perumahan Pelangi Residence": 1.0}
    };

    // Objek graf
    Graph3 graph3 = Graph3(adjacencyList: adjacencyList);

    // Cari rute dari A ke E dengan minimal 2 atau 3 opsi
    List<Map<String, Object>> results =
        graph3.aStar("UNPER", "Perumahan Pelangi Residence", 3);

    // Tampilkan hasil
    for (int i = 0; i < results.length; i++) {
      print("**Rute ${results[i]['distance']} km (Opsi ${i + 1})**");
      print(results[i]['shortestPath']);
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
          onPressed: main2,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes
      ),
    );
  }
}
