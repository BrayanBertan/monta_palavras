/*
    A lógica do programa consiste em  percorrer  duas listas a de letras 
  passadas pelo usuario  e a lista de palavras criadas a partir
  do banco de palavras  e ir retirando de cada palavra os caracteres
  que forem iguais aos passados pelo usuario, assim quando a palavra 
  tiver 0 letras sobrando significa que ela foi formada com sucesso.

    Para executar o programa siga os passos abaixo:
  instale dart em https://dart.dev/tools/sdk/archive (Dart SDK version: 2.10.5 (stable))
  entre na pasta do projeto e rode:
  'dart pub get' para garantir que esteja tudo certos com as dependencias
  'dart main.dart' para executar o programa
*/

import 'dart:io';

import 'package:diacritic/diacritic.dart';
import 'funcoes.dart';
import 'models/palavra.dart';

void main() {
  int opcao;
  do {
    print("Digite as letras para iniciar o jogo");
    String letras = removeDiacritics(stdin
        .readLineSync()
        .toUpperCase()); //remove acentos das letras passadas pelo usuario e transforma todas em maisculas

    print("Escolha uma posição da palavra para duplicar o valor da letra");
    int posicaoBonus = int.parse(stdin.readLineSync());

    List<Palavra> palavras = Funcoes.startListaPalavras(posicaoBonus);

    Funcoes.checkWords(palavras, letras);
    Palavra resposta = Funcoes.getWords(palavras);

    if (palavras.length > 0) {
      Funcoes.printResult(resposta, letras);
    } else {
      print('Nenhuma palavra foi achada!');
    }

    print("Digite:\n1 para recomeçar o jogo \n2 para encerrar o jogo");
    opcao = int.parse(stdin.readLineSync());
  } while (opcao == 1);
}
