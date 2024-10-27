

class AlterationImageVideoEntity {
  bool isVideo;
  String url;
  AlterationImageVideoEntity({
    required this.isVideo,
    required this.url,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'isVideo': isVideo,
      'url': url,
    };
  }
}
