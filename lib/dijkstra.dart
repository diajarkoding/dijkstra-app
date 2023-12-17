import 'dart:math' as math;

import 'package:dijkstra_app/data.dart';

class Graph {
  // Representasi graf sebagai daftar ketetanggaan
  Map<String, Map<String, double>> adjacencyList;

  Graph() : adjacencyList = {};

  // Menambahkan edge ke graf
  void addEdge(String startNode, String endNode) {
    if (!adjacencyList.containsKey(startNode)) {
      adjacencyList[startNode] = {};
    }
    if (!adjacencyList.containsKey(endNode)) {
      adjacencyList[endNode] = {};
    }
    adjacencyList[startNode]![endNode] = heuristicFunction(startNode, endNode);
    adjacencyList[endNode]![startNode] =
        heuristicFunction(startNode, endNode); // Tambahkan edge sebaliknya
  }

  // Algoritma Dijkstra untuk mencari jalur terpendek
  List<Map<String, Object>> dijkstra(String startNode, String endNode,
      {double maxDistance = double.infinity}) {
    List<Map<String, Object>> results = [];

// Iterasi untuk mencari jalur terpendek
    for (int option = 0; option < 2; option++) {
      Map<String, double> distances = {};
      Map<String, String> previousNodes = {};
      List<String> priorityQueue = [startNode];
      Set<String> visitedNodes = {};

      // Inisialisasi distances dan priorityQueue
      for (String node in adjacencyList.keys) {
        distances[node] = double.infinity;
        previousNodes[node] = '';
      }

      distances[startNode] = 0;

      while (priorityQueue.isNotEmpty) {
        priorityQueue.sort((a, b) => distances[a]!.compareTo(distances[b]!));
        String currentNode = priorityQueue.removeAt(0);

        if (currentNode == endNode) {
          // Jika sudah mencapai titik akhir, tambahkan hasil ke results
          if (distances[currentNode]! <= maxDistance) {
            results.add({
              'shortestPath': getPath(startNode, endNode, previousNodes),
              'distance': distances[currentNode]!,
            });
          }
          continue;
        }

        if (distances[currentNode] == double.infinity ||
            distances[currentNode]! > maxDistance) {
          // Jika jarak ke currentNode adalah infinity atau melebihi batas, lanjutkan
          break;
        }

        visitedNodes.add(currentNode); // Tandai node sebagai sudah dikunjungi

        for (String neighbor in adjacencyList[currentNode]!.keys) {
          if (!visitedNodes.contains(neighbor)) {
            // Periksa apakah tetangga belum dikunjungi
            double tentativeDistance = distances[currentNode]! +
                adjacencyList[currentNode]![neighbor]!;
            if (tentativeDistance <= maxDistance &&
                (distances[neighbor] == null ||
                    tentativeDistance < distances[neighbor]!)) {
              distances[neighbor] = tentativeDistance;
              previousNodes[neighbor] = currentNode;
              if (!priorityQueue.contains(neighbor)) {
                priorityQueue.add(neighbor);
              }
            }
          }
        }
      }
    }

    return results;
  }

  // Algoritma A* untuk mencari jalur terpendek
  List<Map<String, Object>> aStar(String startNode, String endNode) {
    List<Map<String, Object>> results = [];

    // Iterasi untuk mencari jalur terpendek
    for (int option = 0; option < 2; option++) {
      Map<String, double> gValues = {};
      Map<String, double> hValues = {};
      Map<String, double> fValues = {};
      Map<String, String> previousNodes = {};
      List<String> openSet = [startNode];
      Set<String> closedSet = {};

      // Inisialisasi nilai awal
      gValues[startNode] = 0;
      hValues[startNode] =
          heuristicFunction(startNode, endNode); // Fungsi estimasi jarak
      fValues[startNode] = gValues[startNode]! + hValues[startNode]!;

      while (openSet.isNotEmpty) {
        openSet.sort((a, b) => fValues[a]!.compareTo(fValues[b]!));
        String currentNode = openSet.removeAt(0);

        if (currentNode == endNode) {
          // Jika sudah mencapai titik akhir, tambahkan hasil ke results
          results.add({
            'shortestPath': getPath(startNode, endNode, previousNodes),
            'distance': gValues[endNode]!,
          });
          continue;
        }

        closedSet.add(currentNode);

        for (String neighbor in adjacencyList[currentNode]!.keys) {
          if (closedSet.contains(neighbor)) {
            continue;
          }

          double tentativeGValue =
              gValues[currentNode]! + adjacencyList[currentNode]![neighbor]!;
          if (!openSet.contains(neighbor) ||
              tentativeGValue < gValues[neighbor]!) {
            gValues[neighbor] = tentativeGValue;
            hValues[neighbor] = heuristicFunction(neighbor, endNode);
            fValues[neighbor] = gValues[neighbor]! + hValues[neighbor]!;
            previousNodes[neighbor] = currentNode;

            if (!openSet.contains(neighbor)) {
              openSet.add(neighbor);
            }
          }
        }
      }
    }

    return results;
  }

  double heuristicFunction(String currentNode, String endNode) {
    // Estimation function based on haversine distance
    double lat1 = getLatitude(currentNode);
    double long1 = getLongitude(currentNode);
    double lat2 = getLatitude(endNode);
    double long2 = getLongitude(endNode);

    double distance = haversineDistance(lat1, long1, lat2, long2) / 1000;
    return distance;
  }

  double haversineDistance(
      double lat1, double long1, double lat2, double long2) {
    // Haversine distance function to calculate the distance between two coordinates on a sphere.
    // In this example, using degrees, but note that haversine is usually
    // calculated in radians.
    double radius = 6371.0; // Earth's radius in kilometers

    double dLat = degreesToRadians(lat2 - lat1);
    double dLon = degreesToRadians(long2 - long1);

    double a = math.pow(math.sin(dLat / 2), 2) +
        math.cos(degreesToRadians(lat1)) *
            math.cos(degreesToRadians(lat2)) *
            math.pow(math.sin(dLon / 2), 2);

    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return radius * c;
  }

  double degreesToRadians(double degrees) {
    return degrees * (math.pi / 180.0);
  }

  double getLatitude(String node) {
    // Mendapatkan nilai latitude dari node
    var matchingEdge = edgesData.firstWhere(
      (edge) => edge['source'] == node,
      orElse: () =>
          {'lat': 0.0}, // Default value if no matching element is found
    );
    return matchingEdge['lat'];
  }

  double getLongitude(String node) {
    // Mendapatkan nilai longitude dari node
    var matchingEdge = edgesData.firstWhere(
      (edge) => edge['source'] == node,
      orElse: () =>
          {'long': 0.0}, // Default value if no matching element is found
    );
    return matchingEdge['long'];
  }
}

List<String> getPath(
    String startNode, String endNode, Map<String, String> previousNodes) {
  List<String> path = [];
  String currentNode = endNode;

  while (currentNode.isNotEmpty && previousNodes[currentNode] != null) {
    path.insert(0, currentNode);
    if (previousNodes[currentNode] == startNode) {
      // Jika mencapai simpul awal, tambahkan ke path dan hentikan loop
      path.insert(0, previousNodes[currentNode]!);
      break;
    }
    if (previousNodes[currentNode]!.isNotEmpty) {
      currentNode = previousNodes[currentNode]!;
    } else {
      break; // Hentikan loop jika simpul sebelumnya kosong
    }
  }

  return path;
}
