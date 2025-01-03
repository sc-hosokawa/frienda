class CommunityMember {
  final String id;
  final String? name;
  final String? imageUrl;
  final String? category;
  final String? favoriteId;
  final String? shortNoteId;
  final String? shortNote;
  final String? lastLoggedIn;
  final List<String> connections;
  final int weight;

  CommunityMember({
    required this.id,
    this.name,
    this.imageUrl,
    this.category,
    this.favoriteId,
    this.shortNoteId,
    this.shortNote,
    this.lastLoggedIn,
    required this.connections,
    required this.weight,
  });

  factory CommunityMember.fromJson(Map<String, dynamic> json) {
    return CommunityMember(
      id: json['id'] as String,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      category: json['category'] as String?,
      favoriteId: json['favoriteId'] as String?,
      shortNoteId: json['shortNoteId'] as String?,
      shortNote: json['shortNote'] as String?,
      lastLoggedIn: json['lastLoggedIn'] as String?,
      connections: (json['connections'] as List).cast<String>(),
      weight: json['weight'] as int,
    );
  }
}
