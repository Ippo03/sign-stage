class Play {
  Play({
    required this.title,
    required this.description,
    required this.author,
    required this.hall,
    required this.duration,
    required this.minAge,
    required this.additionalInfo,
    required this.cast,
    required this.regularPrice,
    required this.discountedPrice,
    required this.imageUrl,
  });

  final String title;
  final String description;
  final String author;
  final String hall;
  final String duration;
  final String minAge;
  final String additionalInfo;
  final String cast; 
  final double regularPrice;
  final double discountedPrice;
  final String imageUrl;
}
