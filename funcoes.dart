import 'package:diacritic/diacritic.dart';
import 'dados/letra_value.dart';
import 'dados/banco_palavras.dart';
import 'models/palavra.dart';

abstract class Funcoes {
  //Pega a lista de Strings do banco de palavras e retorna uma lista de objetos
  // do tipo Palavra
  static List<Palavra> startListaPalavras(int posicaoBonus) {
    List<Palavra> listPalavras = [];
    BancoPalavras.listaBancoPalavras.forEach((palavra) => listPalavras
        .add(Palavra.fromBanco(removeDiacritics(palavra), posicaoBonus)));
    return listPalavras;
  }

  //percorre cada letra passada pelo usuario e envia para a função _searchList
  static void checkWords(List<Palavra> list, String letras) {
    letras.split('').forEach((letra) => _searchList(list, letra));
  }

  //Para cada letra passada pela função checkWords percorre todas as palavras do
  // banco de palavras e caso a palavra da iteração atual contenha a letra ela remove essa letra da palavra
  static void _searchList(List<Palavra> list, String letra) {
    list.forEach((palavra) {
      palavra.palavraTeste = palavra.palavraTeste.replaceFirst(letra, '');
    });
  }

//Primeiro ele retorna todas as palavras com tamanho igual a 0(as palavras que
//foram formadas com sucesso).Apos isso ele ordena a lista na ordem
//pontuação->tamanho->ordem alfabetica e retorna a palavra que ficar na primeira
// posição da ordenação.
  static Palavra getWords(List<Palavra> list) {
    list.retainWhere((palavra) => palavra.palavraTeste.length == 0);
    _sortList(list);
    if (list.length > 0)
      return list[0];
    else
      null;
  }

//Ordena por pontuação
  static void _sortList(List<Palavra> list) {
    list.sort((palavra1, palavra2) {
      if (palavra1.pontuacaoTotal > palavra2.pontuacaoTotal)
        return -1;
      else if (palavra1.pontuacaoTotal < palavra2.pontuacaoTotal)
        return 1;
      else
        return _sortListTamanho(list);
    });
  }

//caso tenha duas palavras com a mesma pontuação ordena por tamanho e por fim
//se houver novamente um empate ordena por ordem alfabetica
  static int _sortListTamanho(List<Palavra> list) {
    list.sort((palavra1, palavra2) {
      if (palavra1.palavraOriginal.length < palavra2.palavraOriginal.length)
        return -1;
      else if (palavra1.palavraOriginal.length >
          palavra2.palavraOriginal.length)
        return 1;
      else
        return palavra1.palavraOriginal.compareTo(palavra2.palavraOriginal);
    });
  }

//Retorna a pontuação total de uma palavra
  static int getPontuacaoTotal(String palavra) {
    int total = 0;
    palavra.split('').forEach((letra) => total += getLetterValue(letra));
    return total;
  }

//Retorna as letras não usados para formar a palavra com maior
//pontuação e também os caracteres especais
  static String getUseLessLetters(String palavraCerta, String letras) {
    List<String> letrasNaoUsadas = [];
    String palavra = palavraCerta;
    letras.split('').forEach((letra) {
      if (!palavra.contains(letra) ||
          RegExp(r"[@_!#$%^&*()<>?/\|}{~:]").hasMatch(letra)) {
        letrasNaoUsadas.add(letra);
      }
      palavra = palavra.replaceFirst(letra, '');
    });

    return letrasNaoUsadas.toString();
  }

//Retorna o valor de uma letra em especifico
  static int getLetterValue(String letra) {
    return LetraValue.valores[LetraValue.valores.keys
        .firstWhere((value) => value.contains(letra.toUpperCase()))];
  }

//Printa no console o resultado final
  static void printResult(Palavra resposta, String letras) {
    print('==============Resultado==================');
    print(
        'Resposta: ${resposta.palavraOriginal} (${resposta.pontuacaoTotal} pontos)');
    print(
        'Letras não utilizadas: ${getUseLessLetters(resposta.palavraOriginal, letras)}');
    print('=========================================');
  }

//Retorna o bonus da posição escolhida pelo usuario, caso haja
  static int getBonus(String palavra, int posicaoBonus) {
    int bonus = 0;
    if (posicaoBonus < palavra.length)
      bonus = getLetterValue(palavra[posicaoBonus]);

    return bonus;
  }
}
