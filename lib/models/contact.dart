class Contact {
  final int id;
  final String nome;
  final int numero;

  Contact(this.id, this.nome, this.numero);

  @override
  String toString() {
    return 'Contact{nome: $nome, numero: $numero}';
  }

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['name'],
        numero = json['accountNumber'];

  Map<String, dynamic> toJson() =>
      {
        'name': nome,
        'accountNumber' : numero
      };
}
