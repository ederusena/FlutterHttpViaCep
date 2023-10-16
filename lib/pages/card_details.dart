import 'package:flutter/material.dart';
import 'package:trilhapp/model/card_details.dart';

class CardDetailPage extends StatelessWidget {
  final CardDetails cardDetail;
  const CardDetailPage({super.key, required this.cardDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: cardDetail.id,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          cardDetail.url,
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Text(
                        cardDetail.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(cardDetail.text),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
