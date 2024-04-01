extension JsonStringFixer on String {
  String get fixJsonString {
    var fixed = this;

    // Tambahkan tanda kutip pada kunci
    fixed = fixed.replaceAllMapped(RegExp(r'(\{|\,)\s*([^:,\{\}\[\]]+?)\s*:'),
        (Match m) => '${m[1]} "${m[2]}":');

    // Tambahkan tanda kutip pada nilai string
    fixed = fixed.replaceAllMapped(RegExp(r':\s*([^",\{\}\[\]\d]+?)\s*(,|\})'),
        (Match m) => ': "${m[1]}"${m[2]}');

    return fixed;
  }
}
