class ImagemHome {
  int? id;
  String? url;
  int? ordenacao;
  int? posX;
  int? posY;

  ImagemHome({this.id, this.url, this.ordenacao, this.posX, this.posY});

  ImagemHome.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    ordenacao = json['ordenacao'];
    posX = json['pos_x'];
    posY = json['pos_y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['ordenacao'] = this.ordenacao;
    data['pos_x'] = this.posX;
    data['pos_y'] = this.posY;
    return data;
  }
}