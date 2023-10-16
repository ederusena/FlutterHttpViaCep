import 'package:trilhapp/model/card_details.dart';

class CardDetailRepository {
  Future<CardDetails> get() async {
    await Future.delayed(const Duration(seconds: 3));
    return CardDetails(
        1,
        'Eder Sena',
        'https://avatars.githubusercontent.com/u/26800480?v=4',
        'Caros amigos, a execução dos pontos do programa estimula a padronização do remanejamento dos quadros funcionais. Por outro lado, a complexidade dos estudos efetuados oferece uma interessante oportunidade para verificação do fluxo de informações. É importante questionar o quanto o entendimento das metas propostas representa uma abertura para a melhoria de alternativas às soluções ortodoxas.'
    );
  }
}