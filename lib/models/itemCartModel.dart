import 'package:loja_cup_cake/controllers/cartController.dart';
import 'package:loja_cup_cake/models/itemModel.dart';


class ItemCartModel{
  int? itemId;
  int? usuarioId;
  int? qtde;
  int? id;
  Item? item;

  ItemCartModel(
      {this.itemId,
        this.usuarioId,
        this.qtde,
        this.id,
        this.item});

  ItemCartModel.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    usuarioId = json['usuario_id'];
    qtde = json['qtde'];
    id = json['id'];
    if (json['item'] != null) {
      item = new Item.fromJson(json['item']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['usuario_id'] = this.usuarioId;
    data['qtde'] = this.qtde;
    data['id'] = this.id;
    if (this.item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
  void decProduct(){
    this.qtde = (this.qtde ?? 1) - 1;
    CartController cartController = CartController();
    cartController.Atualizar(this);
  }

  void incProduct(){
    this.qtde = (this.qtde ?? 1) + 1;
    CartController cartController = CartController();
    cartController.Atualizar(this);
  }
}
