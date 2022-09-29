import 'package:loja_cup_cake/models/cartModel.dart';
import 'package:loja_cup_cake/models/itemCartModel.dart';

class PedidoModel {
  int? id;
  int? clienteId;
  double? vlrFrete;
  double? vlrDesconto;
  int? percDesconto;
  double? vlrLiquido;
  double? vlrBruto;
  int? status;
  String? dtInsercao;
  String? cupomDiscont;
  String? dtAlteracao;
  List<ItensPdv>? itensPdv;

  PedidoModel(
      {this.id,
        this.clienteId,
        this.vlrFrete,
        this.vlrDesconto,
        this.percDesconto,
        this.vlrLiquido,
        this.vlrBruto,
        this.cupomDiscont,
        this.status,
        this.dtInsercao,
        this.dtAlteracao,
        this.itensPdv});

  PedidoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clienteId = json['cliente_id'];
    vlrFrete = json['vlr_frete'];
    vlrDesconto = json['vlr_desconto'];
    percDesconto = json['perc_desconto'];
    vlrLiquido = json['vlr_liquido'];
    vlrBruto = json['vlr_bruto'];
    status = json['status'];
    dtInsercao = json['dt_insercao']??"";
    dtAlteracao = json['dt_alteracao']??"";
    if (json['itens_pdv'] != null) {
      itensPdv = <ItensPdv>[];
      json['itens_pdv'].forEach((v) {
        itensPdv!.add(new ItensPdv.fromJson(v));
      });
    }
  }

  PedidoModel.fromCartModel(CartModel cartModel) {
    clienteId = cartModel.products[0].usuarioId;
    vlrFrete = cartModel.getShipPrice();
    vlrDesconto = cartModel.getDiscount();
    cupomDiscont = cartModel.couponCode;
    percDesconto = cartModel.discountPercentage;
    vlrLiquido = cartModel.getProductsPrice() + vlrFrete! - vlrDesconto!;
    vlrBruto = cartModel.getProductsPrice()  + vlrFrete!;
    status = 1;
    if (cartModel.products != null) {
      itensPdv = <ItensPdv>[];
      cartModel.products.forEach((v) {
        itensPdv!.add(ItensPdv.fromItemCart(v, percDesconto!));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cliente_id'] = this.clienteId;
    data['vlr_frete'] = this.vlrFrete;
    data['cupomDiscont'] = this.cupomDiscont;
    data['vlr_desconto'] = this.vlrDesconto;
    data['perc_desconto'] = this.percDesconto;
    data['vlr_liquido'] = this.vlrLiquido;
    data['vlr_bruto'] = this.vlrBruto;
    data['status'] = this.status;
    data['dt_insercao'] = this.dtInsercao;
    data['dt_alteracao'] = this.dtAlteracao;
    if (this.itensPdv != null) {
      data['itens_pdv'] = this.itensPdv!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItensPdv {
  int? id;
  int? pdvId;
  int? qtde;
  double? vlrUnit;
  double? vlrTotal;
  double? vlrDesconto;
  double? vlrLiquido;
  String? dtInsercao;
  int? itemId;

  ItensPdv(
      {this.id,
        this.pdvId,
        this.qtde,
        this.vlrUnit,
        this.vlrTotal,
        this.vlrDesconto,
        this.vlrLiquido,
        this.dtInsercao,
        this.itemId});

  ItensPdv.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pdvId = json['pdv_id'];
    qtde = json['qtde'];
    vlrUnit = json['vlr_unit'];
    vlrTotal = json['vlr_total'];
    vlrDesconto = json['vlr_desconto'];
    vlrLiquido = json['vlr_liquido'];
    dtInsercao = json['dt_insercao'];
    itemId = json['item_id'];
  }

  ItensPdv.fromItemCart(ItemCartModel itemCartModel, int percentDescont) {
    qtde = itemCartModel.qtde;
    vlrUnit = double.parse(itemCartModel.item!.perco!);
    vlrTotal = double.parse(itemCartModel.item!.perco!) * qtde!;
    vlrDesconto = vlrTotal! * (percentDescont / 100);
    vlrLiquido = vlrTotal! - vlrDesconto!;
    itemId = itemCartModel.item!.id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pdv_id'] = this.pdvId;
    data['qtde'] = this.qtde;
    data['vlr_unit'] = this.vlrUnit;
    data['vlr_total'] = this.vlrTotal;
    data['vlr_desconto'] = this.vlrDesconto;
    data['vlr_liquido'] = this.vlrLiquido;
    data['dt_insercao'] = this.dtInsercao;
    data['item_id'] = this.itemId;
    return data;
  }
}