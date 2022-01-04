extension StringExtensions on String {
  sanatize() {
    return this.replaceAll(RegExp(r'_'), " ");
  }
}
