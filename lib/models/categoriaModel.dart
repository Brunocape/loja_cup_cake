class Categoria {
  int? id;
  String? descricao;
  String? icon;
  int? peso;

  Categoria({this.id, this.descricao, this.icon, this.peso});

  Categoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    icon = json['icon'];
    peso = json['peso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['icon'] = this.icon;
    data['peso'] = this.peso;
    return data;
  }
}