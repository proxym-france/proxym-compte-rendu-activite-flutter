extension NameParsing on String {
  Map<String, String> splitName() {
    var fullName = this;
    var result = {};

    if (fullName.isNotEmpty) {
      var nameTokens = fullName.split(' ');

      if (nameTokens.length > 3) {
        result['name'] = nameTokens.sublist(0, 2).join(' ');
      } else {
        result['name'] = nameTokens.sublist(0, 1).join(' ');
      }

      if (nameTokens.length > 2) {
        result['lastName'] = nameTokens
            .sublist(nameTokens.length - 2, nameTokens.length - 1)
            .join(' ');
        result['secondLastName'] = nameTokens.last;
      } else {
        result['lastName'] ='';
        result['secondLastName'] = "";
      }
    }

    return result.cast<String, String>();
  }
}
