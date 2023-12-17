final List<Map<String, dynamic>> edgesData = [
  {
    'source': 'UNPER',
    'destination': 'Jalan Batara',
    'lat': -7.3546681,
    'long': 108.2245863
  },
  {
    'source': 'Jalan Batara',
    'destination': 'Jalan Letjen Mashudi',
    'lat': -7.3535989,
    'long': 108.2352727
  },
  {
    'source': 'Jalan Letjen Mashudi',
    'destination': 'Perumahan Pelangi',
    'lat': -7.3594113,
    'long': 108.2381173
  },
  {
    'source': 'Jalan Siliwangi',
    'destination': 'Cilolohan',
    'lat': -7.347188,
    'long': 108.2332179
  },
  {
    'source': 'Cilolohan',
    'destination': 'Jalan Letjen Mashudi',
    'lat': -7.3492384,
    'long': 108.2359775
  },
];

void main() {
  Map<String, Map<String, double>> adjacencyList = {
    "UNPER": {"Jalan Batara": 0.2, "Jalan Letjen Mashudi": 1.5},
    "Jalan Batara": {"Jalan Letjen Mashudi": 1.3, "Cilolohan": 2.5},
    "Jalan Letjen Mashudi": {"Jalan Siliwangi": 1.2, "Cilolohan": 1.8},
    "Cilolohan": {"Perumahan Pelangi Residence": 0.5},
    "Jalan Siliwangi": {"Perumahan Pelangi Residence": 1.0},
  };

  // Update data for UNPER
  adjacencyList["UNPER"] = {
    "Jalan Batara": 0.35,
    "Sukanagara": 1.4,
    "Jalan Letjen Mashudi": 1.0,
    "Tujuan": 0.6,
  };

  // Update data for Jalan Batara
  adjacencyList["Jalan Batara"] = {
    "Sukanagara": 1.4,
    "Jalan Letjen Mashudi": 1.0,
    "Tujuan": 0.6,
  };

  // Update data for Jalan Letjen Mashudi
  adjacencyList["Jalan Letjen Mashudi"] = {
    "Siliwangi": 1.2,
    "Cilolohan": 0.27,
    "Tujuan": 1.2,
  };

  // Print the updated adjacencyList
  adjacencyList.forEach((key, value) {
    print('$key: $value');
  });
}
