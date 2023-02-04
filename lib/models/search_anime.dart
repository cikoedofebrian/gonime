class SearchModel {
  int malId;
  String title;
  String imageUrl;
  double score;

  SearchModel({
    required this.imageUrl,
    required this.malId,
    required this.title,
    required this.score,
  });

  factory SearchModel.fromJson(Map<String, dynamic> data) {
    return SearchModel(
      imageUrl: data['images']['jpg']['image_url'] ?? '',
      malId: data['mal_id'] ?? '',
      title: data['title'] ?? '',
      score: data['score'] ?? 0.0,
    );
  }
}
