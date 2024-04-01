class NewsModel {
  int? id;
  String? title;
  String? content;
  String? image;
  String? video;
  CategoryNews? category;
  UserNews? user;
  String? createdAt;
  String? updatedAt;
  bool? isPublish;

  NewsModel(
      {this.id,
      this.title,
      this.content,
      this.image,
      this.video,
      this.category,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.isPublish = false});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    video = json['video'];
    category = json['category'] != null
        ? CategoryNews.fromJson(json['category'])
        : null;
    user = json['user'] != null ? UserNews.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPublish = json['is_publish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class CategoryNews {
  int? id;
  String? name;

  CategoryNews({this.id, this.name});

  CategoryNews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class UserNews {
  int? id;
  String? name;
  String? avatar;

  UserNews({this.id, this.name, this.avatar});

  UserNews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}
