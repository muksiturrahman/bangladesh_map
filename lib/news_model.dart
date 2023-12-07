class NewsItem {
  String headline;
  String reporter;
  String details;
  String entryTime;
  String updateTime;
  String imageUrl;
  String imageCaption;
  String detailUrl;

  NewsItem({
    required this.headline,
    required this.reporter,
    required this.details,
    required this.entryTime,
    required this.updateTime,
    required this.imageUrl,
    required this.imageCaption,
    required this.detailUrl,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      headline: json['hl2'] ?? '',
      reporter: json['rpt'] ?? '',
      details: json['dtl'] ?? '',
      entryTime: json['entry_time'] ?? '',
      updateTime: json['update_time'] ?? '',
      imageUrl: json['img_url'] ?? '',
      imageCaption: json['img_caption'] ?? '',
      detailUrl: json['dtl_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hl2': headline,
      'rpt': reporter,
      'dtl': details,
      'entry_time': entryTime,
      'update_time': updateTime,
      'img_url': imageUrl,
      'img_caption': imageCaption,
      'dtl_url': detailUrl,
    };
  }
}
