import 'package:flutter/material.dart';
import 'package:weather_app/models.dart';

import 'data_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _cityTextController=TextEditingController();

  final _dataService=DetaService();
  WeatherResponse? _response;

  Future<void> _search() async {
    final response=await _dataService.getWeather(_cityTextController.text);
    setState(()=>_response=response);
  }


  @override
  Widget build(BuildContext context) {

    final city=TextFormField(

      autofocus: false,
      controller:_cityTextController,
      keyboardType: TextInputType.name,

      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
         prefixIcon: Icon(Icons.email),
         contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
         hintText: "Email",
         border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
         ),
      ),

    );

    final submitButton=Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          _search();
        },
        child: Text("Submit",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if(_response!=null)
              Column(
                children: [
                  Image.network(_response!.iconUrl),
                  SizedBox(height: 10),
                  Text('${_response!.cityName}'),
                  SizedBox(height: 10),
                  Text('${_response!.tempInfo!.temperatur}'),
                  SizedBox(height: 10),
                  Text('${_response!.weatherInfo!.description}'),
                  SizedBox(height: 10,),
                ],
              ),
            city,
            SizedBox(height: 10),
            submitButton,

          ],
        ),
      ),
    );
  }
}
