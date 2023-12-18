final Map<String, Map<String, double>> adjacencyList = {
  "Unper": {
    "Jalan Batara": 0.35,
    "Sukanagara": 1.4,
    "Jalan Letnan Mashudi": 1.65,
    "Perumahan Pelangi Residence": 1
  },
  "Jalan Batara": {
    "Unper": 0.35,
    "Sukanagara": 1.1,
    "Jalan Letnan Mashudi": 1,
    "Perumahan Pelangi Residence": 0.6
  },
  "Sukanagara": {
    "Unper": 1.4,
    "Jalan Batara": 1.1,
    "Jalan Letnan Mashudi": 0.27,
    "Perumahan Pelangi Residence": 1.2
  },
  "Jalan Letnan Mashudi": {
    "Unper": 1.65,
    "Jalan Batara": 1,
    "Sukanagara": 0.27,
    "Perumahan Pelangi Residence": 0
  },
  "Perumahan Pelangi Residence": {
    "Unper": 1,
    "Jalan Batara": 0.6,
    "Sukanagara": 1.2,
    "Jalan Letnan Mashudi": 0
  }
};

Map<String, Map<String, double>> adjacencyList2 = {
  "A": {"B": 1, "C": 3, "D": 7},
  "B": {"A": 1, "C": 1, "E": 5},
  "C": {"A": 3, "B": 1, "D": 2, "E": 1},
  "D": {"A": 7, "C": 2, "E": 2},
  "E": {"B": 5, "C": 1, "D": 2},
};
