class SimplifiedDependencies {
  static Map dependencies = {};

  SimplifiedDependencies(List dependencyList) {
    for (var e in dependencyList) {
      dependencies[e.runtimeType] = e;
    }
  }
  add(dynamic dependency) {}
  remove(dynamic dependency) {}
  list() {}
  mock() {}
}
