import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Send Me',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyClass(),
    );
  }
}

class MyClass extends StatefulWidget {
  MyClass({Key? key}) : super(key: key);

  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  final _controller = TextEditingController();
  var phone = "";
  var text = "";
  var code = "+91";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
         centerTitle: true,
        title: const Text("Send Me"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 40, right: 40 , ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/img/send.png", height: 180, width: 180,),
                SizedBox(height: 10,),
                CountryCodePicker(
                  onChanged: (code1) {
                    code = code1.toString();
                  },
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'IN',
                  favorite: ['+91', 'IN'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                ),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    phone = value;
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: "Phone No.",
                      enabledBorder: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 30,
                ),
                //TextField(
                // onChanged: (value) {
                //text = value;
                // },
                // decoration: const InputDecoration(
                //  hintText: "Message", enabledBorder: OutlineInputBorder()),
                // ),
                ElevatedButton(
                  onPressed: () async {
                    // https://wa.me/1XXXXXXXXXX?text=I'm%20interested%20in%20your%20car%20for%20sale
                    code = code.replaceAll("+", " ");
                    var url = 'https://wa.me/$code$phone?text=$text';
                    if (!await launch(url)) throw 'Could not launch $url';
                  },
                  child: Icon(Icons.send),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 150 , 10, 5),
                  child: Column(
                   
                    children: const [
                      Text("Devloped By Sonu Jha", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}
