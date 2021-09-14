class UsuarioModel {
  int id;
  String email;
  String posicaoAtual;

  UsuarioModel({
    required this.id,
    required this.posicaoAtual,
    required this.email,
  });

  factory UsuarioModel.fromMap(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        posicaoAtual: json["posicao_atual"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'posicao_atual': posicaoAtual,
      'email': email,
    };
  }
}
