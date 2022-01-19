import 'package:demo_plugin/demo_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  int? number = 0;
  static const MethodChannel _channel = const MethodChannel('demo_plugin');

  countNumber({int? number1, int? number2}) async {
     int? numb =
        await _channel.invokeMethod('getCountNumber', [number1, number2]);
    if (numb != null) {
      setState(() {
        number = numb;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> creationParams = <String, dynamic>{};
    const String viewType = 'native-view';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                // height: 250,
                color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    SampleButton(
                      text: "Open Native Screen",
                      onPressed: () {
                        SampleCallNativeFlutter.openNativeScreen();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<String?>(
                      future: SampleCallNativeFlutter.platformVersion,
                      builder: (_, snapshoot) {
                        return Text(
                          'Platform Version is: ${snapshoot.data}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.amber),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: TextFormField(
                              controller: controller1,
                              decoration: const InputDecoration(
                                  labelText: 'Số a', border: InputBorder.none),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: TextFormField(
                              controller: controller2,
                              decoration: const InputDecoration(
                                  labelText: 'Số b', border: InputBorder.none),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SampleButton(
                      text: "Get Count Number",
                      onPressed: () {
                        countNumber(
                            number1: controller1.text.isNotEmpty
                                ? int.parse(controller1.text)
                                : 0,
                            number2: controller2.text.isNotEmpty
                                ? int.parse(controller2.text)
                                : 0);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Count number is: $number',
                      style: const TextStyle(fontSize: 16, color: Colors.amber),
                    )
                  ],
                ),
              ),
              Expanded(
                child: UiKitView(
                  viewType: viewType,
                  layoutDirection: TextDirection.ltr,
                  creationParams: creationParams,
                  creationParamsCodec: const StandardMessageCodec(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
