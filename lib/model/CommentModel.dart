class CommentModel {
  String username;
  String comments;

  CommentModel({this.username, this.comments});

  CommentModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['comments'] = this.comments;
    return data;
  }
}