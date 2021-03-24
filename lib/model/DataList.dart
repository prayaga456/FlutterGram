class DataList {
  String id;
  String channelname;
  String title;
  String highThumbnail;
  String lowThumbnail;
  String mediumThumbnail;
  List<Null> tags;

  DataList(
      {this.id,
        this.channelname,
        this.title,
        this.highThumbnail,
        this.lowThumbnail,
        this.mediumThumbnail,
        this.tags});

  DataList.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    channelname = json['channelname'];
    title = json['title'];
    highThumbnail = json['high thumbnail'];
    lowThumbnail = json['low thumbnail'];
    mediumThumbnail = json['medium thumbnail'];
    if (json['tags'] != null) {
      tags = <Null>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['channelname'] = this.channelname;
    data['title'] = this.title;
    data['high thumbnail'] = this.highThumbnail;
    data['low thumbnail'] = this.lowThumbnail;
    data['medium thumbnail'] = this.mediumThumbnail;
    return data;
  }
}
