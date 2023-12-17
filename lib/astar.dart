class Graph3 {
  Map<String, Map<String, double>> adjacencyList;

  Graph3({required this.adjacencyList});

  List<Map<String, Object>> aStar(
      String startNode, String endNode, int numRoutes) {
    List<Map<String, Object>> results = [];
    Set<String> foundRoutes = {};

    for (int option = 0; option < numRoutes; option++) {
      Map<String, double> gValues = {};
      Map<String, double> hValues = {};
      Map<String, double> fValues = {};
      Map<String, String> previousNodes = {};
      List<String> openSet = [startNode];
      Set<String> closedSet = {};

      // Inisialisasi nilai awal
      gValues[startNode] = 0;
      hValues[startNode] = heuristicFunction(startNode, endNode, option);
      fValues[startNode] = gValues[startNode]! + hValues[startNode]!;

      while (openSet.isNotEmpty) {
        openSet.sort((a, b) => fValues[a]!.compareTo(fValues[b]!));
        String currentNode = openSet.removeAt(0);

        if (currentNode == endNode) {
          String routeKey =
              getPath(startNode, endNode, previousNodes).join(",");
          if (!foundRoutes.contains(routeKey)) {
            foundRoutes.add(routeKey);
            results.add({
              'shortestPath': getPath(startNode, endNode, previousNodes),
              'distance': gValues[endNode]!,
            });
          }
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
            hValues[neighbor] = heuristicFunction(neighbor, endNode, option);
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

  double heuristicFunction(String currentNode, String endNode, int option) {
    // Fungsi estimasi berdasarkan jumlah node yang belum dikunjungi
    // Semakin banyak node yang belum dikunjungi, semakin besar estimasi.
    Set<String> unvisitedNodes = adjacencyList.keys.toSet();
    unvisitedNodes.remove(currentNode);

    if (option == 1) {
      return unvisitedNodes.length.toDouble();
    } else if (option == 2) {
      // Jika ingin variasi lebih besar, bisa tambahkan faktor penyesuaian.
      return unvisitedNodes.length.toDouble() * 1.5;
    } else {
      // Opsi lainnya, ganti sesuai kebutuhan.
      return 0.0;
    }
  }

  List<String> getPath(
      String startNode, String endNode, Map<String, String> previousNodes) {
    List<String> path = [];
    String currentNode = endNode;

    while (currentNode.isNotEmpty && previousNodes[currentNode] != null) {
      path.insert(0, currentNode);
      if (previousNodes[currentNode] == startNode) {
        path.insert(0, previousNodes[currentNode]!);
        break;
      }
      if (previousNodes[currentNode]!.isNotEmpty) {
        currentNode = previousNodes[currentNode]!;
      } else {
        break;
      }
    }

    return path;
  }
}
