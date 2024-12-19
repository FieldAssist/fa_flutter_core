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
}
