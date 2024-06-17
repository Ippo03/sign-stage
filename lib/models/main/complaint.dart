class Complaint {
  const Complaint({
    required this.email,
    required this.phoneNumber,
    required this.headline,
    required this.description,
  });

  final String email;
  final String phoneNumber;
  final String headline;
  final String description;
}