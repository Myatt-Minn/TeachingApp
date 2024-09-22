class VideoModel {
  final String name;
  final String url;
  final int duration;

  VideoModel({
    required this.name,
    required this.url,
    required this.duration,
  });

  factory VideoModel.fromDocument(Map<String, dynamic> doc) {
    return VideoModel(
      name: doc['name'],
      url: doc['url'],
      duration: doc['duration'],
    );
  }
}
