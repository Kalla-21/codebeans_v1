import 'package:flutter/material.dart';

/// Builds a RichText widget that styles text enclosed in backticks (`).
RichText buildStyledText(String text, {TextStyle? defaultStyle, TextStyle? codeStyle}) {
  // Define default styles if none are provided
  final effectiveDefaultStyle = defaultStyle ?? const TextStyle();
  final effectiveCodeStyle = codeStyle ?? TextStyle(
    fontFamily: 'RobotoMono', // A monospace font for code
    backgroundColor: Colors.grey.shade200,
    color: Colors.blue,
    fontSize: 14,
  );

  List<TextSpan> textSpans = [];

  // Use a regular expression to find all matches
  final RegExp regExp = RegExp(r'`(.*?)`');

  // Keep track of the last processed index
  int lastMatchEnd = 0;

  for (final Match match in regExp.allMatches(text)) {
    // Add the text before the match
    if (match.start > lastMatchEnd) {
      textSpans.add(TextSpan(
        text: text.substring(lastMatchEnd, match.start),
        style: effectiveDefaultStyle,
      ));
    }

    // Add the matched text (the code) with the code style
    textSpans.add(TextSpan(
      text: ' ${match.group(1)} ', // group(1) is the text inside the backticks
      style: effectiveCodeStyle,
    ));

    // Update the last processed index
    lastMatchEnd = match.end;
  }

  // Add any remaining text after the last match
  if (lastMatchEnd < text.length) {
    textSpans.add(TextSpan(
      text: text.substring(lastMatchEnd),
      style: effectiveDefaultStyle,
    ));
  }

  return RichText(
    text: TextSpan(
      children: textSpans,
    ),
  );
}
