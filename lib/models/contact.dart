class Contact{

  final int id;
  final String nome;
  final int numero;

  Contact(this.id, this.nome, this.numero);

  @override
  String toString() {
    return 'Contact{nome: $nome, numero: $numero}';
  }
}