extension StringParser on String {
  double? toDouble() => double.tryParse(this);

  int? toInt() => int.tryParse(this);
}
