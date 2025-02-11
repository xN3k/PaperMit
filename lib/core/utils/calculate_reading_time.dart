int calculateReadingTime(String context) {
  final wordCount = context.split(RegExp(r'\s+')).length;

  final readingTime = wordCount / 225;

  return readingTime.ceil();
}
