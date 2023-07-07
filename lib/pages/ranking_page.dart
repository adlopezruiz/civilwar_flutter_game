import 'package:civil_war/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 28.0),
              child: IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.rankingStar)),
            ),
          ],
          backgroundColor: const Color(0xFFDF1D5A),
          title: const Text('Ranking'),
          centerTitle: true,
        ),
        body: Builder(builder: (context) {
          return Column(
            children: [
              const FirstTile(),
              FutureBuilder(
                  future: Future.delayed(
                    const Duration(seconds: 2),
                    () => FireBaseService().getRanking(),
                  ),
                  builder: (_, snapshot) {
                    if (!snapshot.hasData) {
                      return const LinearProgressIndicator();
                    } else {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, int index) => Card(
                              child: ListTile(
                                leading: (index == 0)
                                    ? const FaIcon(FontAwesomeIcons.crown)
                                    : Text('${index + 1}º',
                                        style: const TextStyle(
                                          fontSize: 24,
                                        ),
                                        textAlign: TextAlign.center),
                                trailing: Text(
                                    '${snapshot.data![index]['points']}',
                                    style: const TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center),
                                title: Text(
                                  '${snapshot.data![index]['playerName']} con ${snapshot.data![index]['tries']} intentos',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ],
          );
        }));
  }
}

class FirstTile extends StatelessWidget {
  const FirstTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: FaIcon(FontAwesomeIcons.rankingStar),
        trailing: Text(
          'Puntos',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        title: Text(
          'Jugador',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
