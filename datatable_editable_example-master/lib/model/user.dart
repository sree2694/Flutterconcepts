class User {
  final String invoiceNumber;
  final String frequency;
  final int hours;

  const User({
    required this.invoiceNumber,
    required this.frequency,
    required this.hours,
  });

  User copy({
    String? invoiceNumber,
    String? frequency,
    int? hours,
  }) =>
      User(
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        frequency: frequency ?? this.frequency,
        hours: hours ?? this.hours,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          invoiceNumber == other.invoiceNumber &&
          frequency == other.frequency &&
          hours == other.hours;

  @override
  int get hashCode => invoiceNumber.hashCode ^ frequency.hashCode ^ hours.hashCode;
}
