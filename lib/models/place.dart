/// Represents a place suggestion from the Google Places API
class Place {
  final String description;
  final String placeId;

  const Place({required this.description, required this.placeId});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}
