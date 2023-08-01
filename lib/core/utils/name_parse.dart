extension NameParsing on String {
  String shortName() {
    List<String> names = trim().split(" ");
    return names
        .map((name) => name.isNotEmpty ? name[0] : '')
        .join()
        .toUpperCase();
  }
}
