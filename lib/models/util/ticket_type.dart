class TicketType {
  final String name;
  final int price;
  final int availableTickets;
  final int soldTickets;

  TicketType({
    required this.name,
    required this.price,
    required this.availableTickets,
    required this.soldTickets,
  });

  factory TicketType.fromJson(Map<String, dynamic> json) {
    return TicketType(
      name: json['name'],
      price: json['price'],
      availableTickets: json['availableTickets'],
      soldTickets: json['soldTickets'],
    );
  }
}
