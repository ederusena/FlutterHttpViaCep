import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trilhapp/pages/battery_status/battery_page.dart';
import 'package:trilhapp/pages/configuracoes/configuracao_hive_page.dart';
import 'package:trilhapp/pages/dados_cadastrais/dados_cadastrais_hive_page.dart';
import 'package:trilhapp/pages/gps_geolocator/gps_page.dart';
import 'package:trilhapp/pages/login_page.dart';
import 'package:trilhapp/pages/heroes_marvel/marvel_characters_page.dart';
import 'package:trilhapp/pages/numeros_aleatorios/numeros_aleatorios_hive_page.dart';
import 'package:trilhapp/pages/post_pages.dart';
import 'package:trilhapp/pages/qr_code/qr_code_page.dart';
import 'package:trilhapp/pages/tarefa/tarefa_sqlite_page.dart';
import 'package:trilhapp/pages/tarefasBack4app/tarefas_back4app_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  context: context,
                  builder: (BuildContext bc) {
                    return Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.music_note),
                          title: const Text('Music'),
                          onTap: () => {Navigator.pop(context)},
                        ),
                        ListTile(
                          leading: const Icon(Icons.videocam),
                          title: const Text('Video'),
                          onTap: () => {Navigator.pop(context)},
                        ),
                      ],
                    );
                  });
            },
            child: const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/26800480?v=4"),
              ),
              accountName: Text("Eder Soares Sena"),
              accountEmail: Text("eder.sena@live.com"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: const Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 10),
                          Text("Dados cadastrais"),
                        ],
                      )),
                  onTap: () {
                    Navigator.pop(context, 'OK');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const DadosCadastraisHivePage()));
                  },
                ),
                const SizedBox(height: 10),
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: const Row(
                        children: [
                          Icon(Icons.privacy_tip),
                          SizedBox(width: 10),
                          Text("Termos de uso e privacidade"),
                        ],
                      )),
                  onTap: () => {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext bc) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                            child: const Column(children: [
                              Text(
                                "Termos de uso e privacidade",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "O cuidado em identificar pontos críticos no comprometimento entre as equipes auxilia a preparação e a composição do retorno esperado a longo prazo",
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 16),
                              ),
                            ]),
                          );
                        })
                  },
                ),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.qrcode),
                            SizedBox(width: 10),
                            Text("QR Code Reader"),
                          ],
                        )),
                    onTap: () => {
                          Navigator.pop(context, 'OK'),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext bc) =>
                                      const QrCodePage()))
                        }),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.mapLocation),
                            SizedBox(width: 10),
                            Text("GPS Locator"),
                          ],
                        )),
                    onTap: () => {
                          Navigator.pop(context, 'OK'),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext bc) =>
                                      const GpsLocatorPage()))
                        }),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.mobileScreenButton),
                            SizedBox(width: 10),
                            Text("Informação do Dispositivo"),
                          ],
                        )),
                    onTap: () async {
                      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

                      if (Platform.isAndroid) {
                        AndroidDeviceInfo androidInfo =
                            await deviceInfo.androidInfo;
                        print(
                            'Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
                      } else if (Platform.isIOS) {
                        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                        print(
                            'Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
                      } else if (Platform.isWindows) {
                        WebBrowserInfo webBrowserInfo =
                            await deviceInfo.webBrowserInfo;
                        print('Running on ${webBrowserInfo.userAgent}');
                      }
                    }),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.info),
                            SizedBox(width: 10),
                            Text("Informação do app"),
                          ],
                        )),
                    onTap: () async {
                      PackageInfo packageInfo =
                          await PackageInfo.fromPlatform();

                      String appName = packageInfo.appName;
                      String packageName = packageInfo.packageName;
                      String version = packageInfo.version;
                      String buildNumber = packageInfo.buildNumber;

                      print(appName);
                      print(packageName);
                      print(version);
                      print(buildNumber);
                    }),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.folderOpen),
                            SizedBox(width: 10),
                            Text("Abrir pasta"),
                          ],
                        )),
                    onTap: () async {
                      var directory = await path_provider
                          .getApplicationDocumentsDirectory();
                      print(directory);
                    }),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.github),
                            SizedBox(width: 10),
                            Text("Github"),
                          ],
                        )),
                    onTap: () async {
                      await launchUrl(
                          Uri.parse('https://github.com/ederusena'));
                    }),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.share),
                            SizedBox(width: 10),
                            Text("Compartilhar"),
                          ],
                        )),
                    onTap: () {
                      Share.share('check out my website https://example.com');
                    }),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.batteryFull),
                            SizedBox(width: 10),
                            Text("Medidor Bateria"),
                          ],
                        )),
                    onTap: () => {
                          Navigator.pop(context, 'OK'),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext bc) =>
                                      const BatteryStatusPage()))
                        }),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            Icon(Icons.task),
                            SizedBox(width: 10),
                            Text("Tarefas Back4App"),
                          ],
                        )),
                    onTap: () => {
                          Navigator.pop(context, 'OK'),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext bc) =>
                                      const TarefasBack4appPage()))
                        }),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            Icon(Icons.shield),
                            SizedBox(width: 10),
                            Text("Marvel API"),
                          ],
                        )),
                    onTap: () => {
                          Navigator.pop(context, 'OK'),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext bc) =>
                                      const MarvelCharactersPage()))
                        }),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            Icon(Icons.task),
                            SizedBox(width: 10),
                            Text("Tarefas"),
                          ],
                        )),
                    onTap: () => {
                          Navigator.pop(context, 'OK'),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext bc) =>
                                      const TarefaSQLitePage()))
                        }),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            Icon(Icons.numbers),
                            SizedBox(width: 10),
                            Text("Gerador de numeros aleatórios"),
                          ],
                        )),
                    onTap: () => {
                          Navigator.pop(context, 'OK'),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext bc) =>
                                      const NumerosAleatoriosHivePage()))
                        }),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: const Row(
                        children: [
                          Icon(Icons.post_add),
                          SizedBox(width: 10),
                          Text("Postagens"),
                        ],
                      )),
                  onTap: () => {
                    Navigator.pop(context, 'OK'),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext bc) => const PostPage()))
                  },
                ),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: const Row(
                        children: [
                          Icon(Icons.settings),
                          SizedBox(width: 10),
                          Text("Configurações"),
                        ],
                      )),
                  onTap: () => {
                    Navigator.pop(context, 'OK'),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext bc) =>
                                const ConfiguracaoHivePage()))
                  },
                ),
                const Divider(),
                const SizedBox(height: 10),
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: const Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 10),
                          Text("Sair"),
                        ],
                      )),
                  onTap: () => {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        elevation: 8,
                        alignment: Alignment.centerLeft,
                        title: const Text(
                          'Fazer logout',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: const Text('Gostaria de sair?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage())),
                            child: const Text('Sim'),
                          ),
                        ],
                      ),
                    )
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
