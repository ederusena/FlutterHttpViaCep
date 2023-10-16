import 'package:flutter/material.dart';
import 'package:trilhapp/model/card_details.dart';
import 'package:trilhapp/pages/card_details.dart';
import 'package:trilhapp/repository/card_detail_repository.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  CardDetails? cardDetail;
  CardDetailRepository cardDetailRepository = CardDetailRepository();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    // Fetch data asynchronously
    final loadedCardDetail = await cardDetailRepository.get();

    setState(() {
      // Update the cardDetail after data is loaded
      cardDetail = loadedCardDetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: double.infinity,
        child: cardDetail == null
            ? const LinearProgressIndicator()
            : InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CardDetailPage(
                                cardDetail: cardDetail!,
                              )));
                },
                child: Hero(
                  tag: cardDetail!.id,
                  child: Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  cardDetail!.url,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              Text(
                                cardDetail!.title,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(cardDetail!.text),
                          Container(
                              width: double.infinity,
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {},
                                  child: const Text("Ler Mais",
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.underline))))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      )
    ]);
  }
}
