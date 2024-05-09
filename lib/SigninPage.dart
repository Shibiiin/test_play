
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/dashBoard_page.dart';
import 'package:untitled/upgrade_widget.dart';



class SiginPage extends StatefulWidget {
  const SiginPage({Key? key}) : super(key: key);

  @override
  State<SiginPage> createState() => _SiginPageState();
}

class _SiginPageState extends State<SiginPage> {

  var formkey = GlobalKey<FormState>();
  bool viewvalue = true;


  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  late SharedPreferences logindata;
  late bool newuser;


  @override
  void initState() {
    check_if_already_login();
    super.initState();
  }

  Future<void> check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? false);
    if (kDebugMode) {
      print(newuser);
    }
    if (newuser == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const DashBoard()));
    }
  }

  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Icon(Icons.import_contacts_sharp,color: Colors.white,),
        actions: [
          const Row(
              children: [
                Text('Privacy',),
              ]
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert),)
        ],
      ),
      body:
      Form(
        key: formkey,
        child: ListView(
          children: [

            const Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Icon(Icons.account_circle_outlined,size: 90,color: Colors.red,),
                ),
                Text("Login"),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child:
              TextFormField(
                controller: username_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
                // validator: (text) {
                //   if (text!.isEmpty) {
                //     return 'Enter a Valid Email address';
                //   } else {
                //     return null;
                //   }
                // },
                textInputAction: TextInputAction.next,
              ),),

            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                obscureText: viewvalue,
                obscuringCharacter: '*',
                controller: password_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
                // validator: (text) {
                //   if (text!.length < 7 || text.isEmpty) {
                //     return 'Password should be greater than 7 or Must be filled';
                //   } else {
                //     return null;
                //   }
                // },
                textInputAction: TextInputAction.done,
              ),),

            ElevatedButton(onPressed: ()
            {
              // String username = username_controller.text;
              // String password = password_controller.text;
              // final isValid = formkey.currentState!.validate();

              // if (isValid) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const UpgradingWidget()));
                // logindata.setBool('login', false);
                // logindata.setString('username', username);
              // }
              // else {
              //  return null;
              // }
            },

              child: const Text('login'),
            ),
          ],
        ),
      ),
    );
  }
}


