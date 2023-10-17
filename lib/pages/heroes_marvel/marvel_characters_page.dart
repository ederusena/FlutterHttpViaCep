import 'package:flutter/material.dart';
import 'package:trilhapp/model/characters_marvel_model.dart';
import 'package:trilhapp/repository/marvel/marvel_repository.dart';

class MarvelCharactersPage extends StatefulWidget {
  const MarvelCharactersPage({super.key});

  @override
  State<MarvelCharactersPage> createState() => _MarvelCharactersPageState();
}

class _MarvelCharactersPageState extends State<MarvelCharactersPage> {
  late MarvelRepository marvelRepository;
  final ScrollController _scrollController = ScrollController();

  CharacterMarvelModel characters = CharacterMarvelModel();

  int offset = 0;
  var isLoading = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      var posicaoParaPaginar = _scrollController.position.maxScrollExtent * 0.7;

      if (_scrollController.position.pixels >= posicaoParaPaginar) {
        carregarDados();
      }
    });

    marvelRepository = MarvelRepository();
    super.initState();

    carregarDados();
  }

  carregarDados() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    if (characters.data == null || characters.data!.results == null) {
      characters = await marvelRepository.getCharacters(offset);
    } else {
      offset += characters.data!.count!;
      var tempList = await marvelRepository.getCharacters(offset);
      characters.data!.results!.addAll(tempList.data!.results!);
    }
    setState(() {
      isLoading = false;
    });
  }

  int retornaQuantidadeTotal() {
    try {
      return characters.data!.total!;
    } catch (e) {
      return 0;
    }
  }

  int retornaQuantidadeAtual() {
    try {
      return offset + characters.data!.count!;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                  "Herois Marvel: ${retornaQuantidadeAtual()}/${retornaQuantidadeTotal()}"),
            ),
            bottomSheet: Container(
              height: 50,
              color: const Color.fromARGB(255, 213, 213, 213),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !isLoading
                      ? ElevatedButton(
                          onPressed: () {
                            carregarDados();
                          },
                          child: const Row(children: [
                            Text("Proxima Pagina"),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward_ios)
                          ]))
                      : const CircularProgressIndicator(),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: (characters.data == null ||
                            characters.data!.results == null)
                        ? 0
                        : characters.data!.results!.length,
                    itemBuilder: (_, index) {
                      var character = characters.data!.results![index];
                      return Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              "${character.thumbnail!.path!}.${character.thumbnail!.extension!}",
                              width: 150,
                              height: 150,
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      character.name!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(character.description!),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}
