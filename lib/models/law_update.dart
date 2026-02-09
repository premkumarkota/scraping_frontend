class LawUpdate {
  final int id;
  final int sourceId;
  final String title;
  final String description;
  final String content;
  final String link;
  final DateTime scrapedAt;

  LawUpdate({
    required this.id,
    required this.sourceId,
    required this.title,
    required this.description,
    required this.content,
    required this.link,
    required this.scrapedAt,
  });

  factory LawUpdate.fromJson(Map<String, dynamic> json) {
    return LawUpdate(
      id: json['id'] ?? 0,
      sourceId: json['source_id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      link: json['link'] ?? '',
      scrapedAt: json['scraped_at'] != null
          ? DateTime.parse(json['scraped_at'])
          : DateTime.now(),
    );
  }
}
