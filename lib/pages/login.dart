import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginC = Get.put(LoginController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    if (box.read("dataRememberMe") != null) {
      loginC.rememberMe.value = true;
      loginC.emailC.text = box.read("dataRememberMe")["email"];
      loginC.passC.text = box.read("dataRememberMe")["pass"];
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: loginC.emailC,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              label: const Text("Email"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => TextField(
              controller: loginC.passC,
              autocorrect: false,
              obscureText: loginC.isHidden.value,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                label: const Text("Password"),
                suffixIcon: IconButton(
                  onPressed: () => loginC.isHidden.toggle(),
                  icon: const Icon(Icons.remove_red_eye),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Obx(
            () => CheckboxListTile(
              value: loginC.rememberMe.value,
              onChanged: (value) => loginC.rememberMe.toggle(),
              title: const Text("Remember me"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => loginC.login(),
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
