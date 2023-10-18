import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:trilhapp/pages/auto_size_text/auto_text_page.dart';
import 'package:trilhapp/pages/brasil_fields/brasil_fields_page.dart';
import 'package:trilhapp/pages/card_page.dart';
import 'package:trilhapp/pages/consulta_cep_page.dart';
import 'package:trilhapp/pages/splash_screen/splash_screen_page.dart';
import 'package:trilhapp/shared/widget/custom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Trilha Flutter"),
            ),
            drawer: const CustomDrawer(),
            body: TabBarView(
              controller: tabController,
              children: [
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.green,
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.yellow,
                ),
                const BrasilFieldPage(),
              ],
            ),
            bottomNavigationBar: ConvexAppBar.badge(
              const {0: '99+', 1: Icons.assistant_photo, 2: Colors.redAccent},
              items: const [
                TabItem(icon: Icons.home, title: 'Home'),
                TabItem(icon: Icons.map, title: 'Discovery'),
                TabItem(icon: Icons.add, title: 'Add'),
                TabItem(icon: Icons.message, title: 'Message'),
                TabItem(
                    icon: FaIcon(FontAwesomeIcons.brazilianRealSign),
                    title: 'Brasil Fields'),
              ],
              onTap: (int i) => tabController.index = i,
              controller: tabController,
            )));
  }
}

// const Column(
//           children: [],
//         ),
// Expanded(
//               child: PageView(
//                 controller: pageController,
//                 onPageChanged: (value) {
//                   setState(() {
//                     posicaoPagina = value;
//                   });
//                 },
//                 children: const [
//                   CardPage(),
//                   ConsultaCepPage(),
//                   AutoSizeTextPage(),
//                   SplashScreenPage()
//                 ],
//               ),
//             ),
//             BottomNavigationBar(
//                 type: BottomNavigationBarType.fixed,
//                 onTap: (value) => setState(() {
//                       pageController.animateToPage(value,
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.easeIn);
//                     }),
//                 currentIndex: posicaoPagina,
//                 items: const [
//                   BottomNavigationBarItem(
//                       icon: Icon(Icons.home), label: "Home"),
//                   BottomNavigationBarItem(
//                       icon: Icon(Icons.lock_clock), label: "Via Cep"),
//                   BottomNavigationBarItem(
//                       icon: FaIcon(FontAwesomeIcons.fontAwesome),
//                       label: "Auto Text"),
//                   BottomNavigationBarItem(
//                       icon: FaIcon(FontAwesomeIcons.mobileScreen),
//                       label: "Splash Screen"),
//                 ])
