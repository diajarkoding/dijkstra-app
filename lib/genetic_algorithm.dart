import 'dart:math';

class RouteX {
  final List<String> points;
  final double distance;
  final double travelTime;

  RouteX(this.points, this.distance, this.travelTime);
}

class GeneticAlgorithm {
  final List<String> points = [
    "Monas",
    "Jl. Medan Merdeka Barat",
    "Jl. M.H. Thamrin",
    "Jl. Jenderal Sudirman",
    "Jl. Gatot Subroto",
    "Jl. Gerbang Pemuda",
    "Jl. Gelora Bung Karno",
    "Jl. Stadion Senayan",
  ];

  final List<double> distances = [
    0.0,
    2.2,
    3.1,
    4.4,
    5.7,
    6.8,
    8.0,
    9.1,
  ];

  final List<double> travelTimes = [
    0.0,
    3.0,
    4.2,
    5.4,
    6.6,
    7.8,
    9.0,
    10.1,
  ];

  RouteX randomRoute() {
    return RouteX(
      points.sublist(
        0,
        Random().nextInt(points.length),
      ),
      distances.sublist(0, points.length - 1).reduce(_sum),
      travelTimes.sublist(0, points.length - 1).reduce(_sum),
    );
  }

  double _sum(double a, double b) => a + b;

  double fitness(RouteX route) {
    return 1 / (route.distance + route.travelTime);
  }

  RouteX select(List<RouteX> routes) {
    return routes[Random().nextInt(routes.length)];
  }

  RouteX crossover(RouteX route1, RouteX route2) {
    int crossoverPoint = Random().nextInt(route1.points.length - 1);
    return RouteX(
      route1.points.sublist(0, crossoverPoint)
        ..addAll(route2.points.sublist(crossoverPoint)),
      route1.distance + route2.distance,
      route1.travelTime + route2.travelTime,
    );
  }

  RouteX mutate(RouteX route) {
    int mutationPoint = Random().nextInt(route.points.length);
    String newPoint;
    do {
      newPoint = points[Random().nextInt(points.length)];
    } while (route.points.contains(newPoint));

    return RouteX(
      route.points.sublist(0, mutationPoint)
        ..insert(mutationPoint, newPoint)
        ..addAll(route.points.sublist(mutationPoint)),
      route.distance,
      route.travelTime,
    );
  }

  List<RouteX> evolve(List<RouteX> routes) {
    List<RouteX> newRoutes = [];
    for (int i = 0; i < routes.length; i++) {
      RouteX parent1 = select(routes);
      RouteX parent2 = select(routes);
      RouteX child = crossover(parent1, parent2);
      child = mutate(child);
      newRoutes.add(child);
    }
    return newRoutes;
  }

  List<RouteX> findBestRoutes(int iterations) {
    List<RouteX> routes = [randomRoute()];
    for (int i = 0; i < iterations; i++) {
      routes = evolve(routes);
    }
    routes.sort((a, b) => fitness(b).compareTo(fitness(a)));
    return routes;
  }

  void main() {
    List<RouteX> routes = findBestRoutes(100);
    print("Rute Terbaik: ${routes[0].points}");
    print("Jarak Rute Terbaik: ${routes[0].distance} km");
    print("Waktu Tempuh Rute Terbaik: ${routes[0].travelTime} menit");
  }
}
