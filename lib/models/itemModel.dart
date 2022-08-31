class Item {
  int? id;
  String? descricao;
  String? perco;
  String? tipo;
  int? categoriaId;
  List<Imagens>? imagens;

  Item(
      {this.id,
      this.descricao,
      this.perco,
      this.tipo,
      this.categoriaId,
      this.imagens});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    perco = json['perco'].toString();
    tipo = json['tipo'];
    categoriaId = json['categoria_id'];
    if (json['imagens'] != null) {
      imagens = <Imagens>[];
      json['imagens'].forEach((v) {
        imagens!.add(new Imagens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['perco'] = this.perco;
    data['tipo'] = this.tipo;
    data['categoria_id'] = this.categoriaId;
    if (this.imagens != null) {
      data['imagens'] = this.imagens!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Imagens {
  int? id;
  String? path;
  int? itemId;

  Imagens({this.id, this.path, this.itemId});

  Imagens.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    itemId = json['item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    data['item_id'] = this.itemId;
    return data;
  }
}
