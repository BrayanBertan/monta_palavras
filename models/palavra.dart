import '../funcoes.dart';

class Palavra {
  Palavra({this.palavraOriginal, this.palavraTeste, this.pontuacaoTotal});

  String palavraOriginal;
  String palavraTeste;
  int pontuacaoTotal;

  factory Palavra.fromBanco(String palavra, int posicaoBonus) {
    String palavraUpperCase = palavra.toUpperCase();
    return Palavra(
        palavraOriginal: palavraUpperCase,
        palavraTeste: palavraUpperCase,
        pontuacaoTotal: Funcoes.getPontuacaoTotal(palavraUpperCase) +
            Funcoes.getBonus(palavraUpperCase, posicaoBonus));
  }

  @override
  String toString() {
    return this.palavraTeste;
  }
}
