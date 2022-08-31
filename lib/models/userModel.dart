
class UsuarioModel {
  int? ativo;
  String? email;
  String? nome;
  int? id;
  String? dtCriacao;
  String? dtAlteracao;
  String? senha;
  String? token;

  UsuarioModel(
      {this.ativo,
        this.email,
        this.nome,
        this.id,
        this.dtCriacao,
        this.dtAlteracao,
        this.senha,
        this.token});

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    ativo = json['ativo']??0;
    email = json['email']??"0";
    nome = json['nome']??"0";
    id = json['id']??0;
    dtCriacao = json['dt_criacao']??"";
    dtAlteracao = json['dt_alteracao']??"";
    senha = json['senha']??"0";
    token = json['token']??"0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ativo'] = this.ativo;
    data['email'] = this.email;
    data['nome'] = this.nome;
    data['id'] = this.id;
    data['dt_criacao'] = this.dtCriacao;
    data['dt_alteracao'] = this.dtAlteracao;
    data['senha'] = this.senha;
    data['token'] = this.token;
    return data;
  }

  bool isLoggedIn(){
    return this.id != null && this.id != 0;
  }
}