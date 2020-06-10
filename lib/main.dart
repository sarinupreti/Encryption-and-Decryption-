import 'package:activation_code/encryption.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController codeController = new TextEditingController();

  String encryptedKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activation Code"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(hintText: "Enter device code"),
                controller: codeController,
                onSubmitted: (value) {
                  setState(() {
                    encryptedKey =
                        encryptAESCryptoJS(codeController.text.trim(), "1234");
                  });
                },
              ),
            ),
            encryptedKey != null && encryptedKey.isNotEmpty
                ? Card(
                    margin: EdgeInsets.all(20),
                    elevation: 10,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            encryptedKey != null && encryptedKey.isNotEmpty
                                ? "Activation Code"
                                : "",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            encryptedKey != null && encryptedKey.isNotEmpty
                                ? "click to copy code."
                                : "",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                new ClipboardData(text: encryptedKey));
                            Flushbar(
                              message: "Copied to clipboard",
                              duration: Duration(seconds: 3),
                              backgroundGradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xffEE0979),
                                  Color(0xffFF6A00)
                                ],
                              ),
                              backgroundColor: Colors.red,
                              boxShadows: [
                                BoxShadow(
                                  color: Colors.blue[800],
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 3.0,
                                )
                              ],
                            )..show(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              encryptedKey != null && encryptedKey.isNotEmpty
                                  ? encryptedKey
                                  : "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : SizedBox(
                    height: 0,
                    width: 0,
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            encryptedKey =
                encryptAESCryptoJS(codeController.text.trim(), "1234");
          });
        },
        tooltip: 'Activation Code',
        child: Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
