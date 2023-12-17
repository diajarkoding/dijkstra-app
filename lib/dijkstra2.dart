class Graph2 {
  Map<String, Map<String, double>> adjacencyList;

  Graph2({required this.adjacencyList});

  List<Map<String, Object>> dijkstra(String startNode, String endNode,
      {double maxDistance = double.infinity}) {
    List<Map<String, Object>> results = [];

    // Hanya satu kali iterasi
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
          double tentativeDistance =
              distances[currentNode]! + adjacencyList[currentNode]![neighbor]!;
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

    return results;
  }

  List<String> getPath(
      String startNode, String endNode, Map<String, String> previousNodes) {
    List<String> path = [];
    String currentNode = endNode;

    while (currentNode != startNode) {
      path.insert(0, currentNode);
      currentNode = previousNodes[currentNode]!;
    }

    path.insert(0, startNode);

    return path;
  }
}
