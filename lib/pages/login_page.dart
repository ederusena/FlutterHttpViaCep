import 'package:flutter/material.dart';
import 'package:trilhapp/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController(text: "eder.sena@live.com");
  var passwordController = TextEditingController(text: "123456");
  var isObscure = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 15, 18, 33),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      flex: 5,
                      child: Image.network(
                        "https://hermes.digitalinnovation.one/assets/diome/logo.png",
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(height: 30),
                const Text("Já tem cadastro?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                const Text("Faça seu login e make the change_",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                const SizedBox(height: 40),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    height: 30,
                    child: TextField(
                      controller: emailController,
                      onChanged: (value) => {},
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: (-3)),
                        prefixIcon: Icon(Icons.email,
                            color: Color.fromARGB(255, 130, 20, 255)),
                        hintText: "Informe seu e-mail",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(151, 126, 126, 126)),
                        ),
                      ),
                    )),
                const SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    height: 30,
                    child: TextField(
                      obscureText: isObscure,
                      controller: passwordController,
                      onChanged: (value) => {},
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: (-3)),
                        prefixIcon: const Icon(Icons.lock,
                            color: Color.fromARGB(255, 130, 20, 255)),
                        suffixIcon: GestureDetector(
                          onLongPressDown: (value) => {
                            setState(() {
                              isObscure = !isObscure;
                            })
                          },
                          // InkWell(
                          // onTap: () => {
                          //   setState(() {
                          //     isObscure = !isObscure;
                          //   })
                          // },
                          child: Icon(
                              isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromARGB(255, 130, 20, 255)),
                        ),
                        hintText: "Senha",
                        hintStyle:
                            const TextStyle(color: Colors.white, fontSize: 14),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(151, 126, 126, 126)),
                        ),
                      ),
                    )),
                const SizedBox(height: 30),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(double.infinity, 40)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 112, 30, 244)),
                        ),
                        onPressed: () {
                          if (emailController.text == "eder.sena@live.com" &&
                              passwordController.text == "123456") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainPage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Usuário ou senha inválidos"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: const Text("Entrar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                      ),
                    )),
                Expanded(child: Container()),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  height: 30,
                  child: const Text("Esqueci minha senha",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w400)),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  height: 30,
                  child: const Text("Criar Conta",
                      style: TextStyle(color: Colors.green)),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
