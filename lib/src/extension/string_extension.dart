//extension on String

//get Initials On String
extension getInitials on String {
  String getTwoInitials() {
    final stringChars = this.split("");
    final first = stringChars.firstOrNull?.toUpperCase();
    if (first == null) {
      return this;
    }

    final words = this.trim().split(" ");
    final last =
        (words.last.length > 1 ? words.last.substring(0, 1) : stringChars.last)
            .toUpperCase();
    return "$first$last";
  }

  String insertLineBreaks(int maxLineLength) {
    final buffer = StringBuffer();
    for (int i = 0; i < this.length; i += maxLineLength) {
      final end =
      (i + maxLineLength < this.length) ? i + maxLineLength : this.length;
      buffer.writeln(this.substring(i, end));
    }
    return buffer.toString().trim();
  }

}
