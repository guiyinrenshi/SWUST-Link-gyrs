import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/entity/account.dart';

import 'logic.dart';
import 'state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginLogic logic = Get.put(LoginLogic());
  final LoginState state = Get.find<LoginLogic>().state;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("帐号登录"),
        ),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(children: [
                Text(
                  "登录",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownMenu(
                  dropdownMenuEntries: state.dropDownItem,
                  width: double.infinity,
                  initialSelection: state.currentPlatform.value,
                  onSelected: (value) {
                    state.currentPlatform.value = value;
                    logic.loadUseInfo();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => TextFormField(
                    controller: state.usernameController.value,
                    decoration:
                        InputDecoration(labelText: "用户名", hintText: "请输入用户名"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "请输入用户名";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      state.username.value = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => TextFormField(
                    controller: state.passwordController.value,
                    obscureText: state.isShowPassword.value,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        labelText: "密码",
                        hintText: "请输入密码",
                        suffixIcon: IconButton(
                            onPressed: () {
                              logic.changeShowPassword();
                            },
                            icon: Icon(state.isShowPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "请输入密码";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      state.password.value = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            logic.testLogin();
                          }
                        },
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                          backgroundColor: WidgetStateProperty.all(Colors.blue),
                        ),
                        child: Text(
                          "测试登录",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            )));
  }
}
