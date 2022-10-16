import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(title:Text("State Management")),
        body: MainPage(),
      ),
    );
  }
}
class MainPage extends StatefulWidget { //stateful class build every widget on the tree
  //widget will rebuild and whole page will be reloaded
  //like in weather app we doesn't want to rebuild the whole app so the performance issues will occur
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int counter=0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
    Center(child: Text("State Management Tutorial $counter"),),
      Center(child: ElevatedButton(onPressed: () { setState(() {
        counter++;
      }); }, child: Text("Counter"),),),
      Center(child: ElevatedButton(onPressed: () { setState(() {
Get.to(StateFulBuilderExample());
      }); }, child: Text("Goto State ful builder page"),),),
      Center(child: ElevatedButton(onPressed: () { setState(() {
        Get.to(ProviderExample());
      }); }, child: Text("Goto Provider page"),),),
      Center(child: ElevatedButton(onPressed: () { setState(() {
        Get.to(GetXStateManagement());
      }); }, child: Text("Goto Getx page"),),)
    ],);
  }
}
//statefulbuilder build particular widget the widget you want to rebuid
class StateFulBuilderExample extends StatelessWidget {
  const StateFulBuilderExample({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int counter=0;
    return MaterialApp(
      home: Scaffold(appBar: AppBar(title:Text("State ful Builder Example")),
      body:
          StatefulBuilder(builder: (context, mystateFunc){
            return
      Column(children: [
        Center(child: ElevatedButton(onPressed: () {
mystateFunc(()=>counter++);
    } , child: Text("Counter"),),),
        Center(child: ElevatedButton(onPressed: () {
          Get.snackbar("Count", "$counter");
        } , child: Text("Snack bar"),),),

      ],);}
      ) //stateful builder is valid only in these brackets

    ));
  }
}
//easy to manage large apps
//provider has 3 parts
//change notifier: TV
//change notifier provider: Electronic shop
//consumer: user

class ProviderExample extends StatefulWidget {
  const ProviderExample({Key? key}) : super(key: key);

  @override
  State<ProviderExample> createState() => _ProviderExampleState();
}

class _ProviderExampleState extends State<ProviderExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: AppBar(title: Text("Prvoider state management") ,),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ChangeNotifierProvider<PageProvider>(//provides change notification to its listeners
          create: (context) =>PageProvider(),
          //consumer take provider from ancestor and passes it value to builder
          child: Consumer<PageProvider>(//consumer will be rebuild not everything will be rebuild
            builder: (context, provider, child) =>  Column(
              children: [
                TextField(onChanged:(value) => provider.checkEligibility(int.parse(value)),decoration: InputDecoration(hintText: "Enter your age"),keyboardType: TextInputType.number,)
              ,
              Text(provider.elgibilityMessage.toString(),style: TextStyle(color:(provider.isEligible==true)?Colors.green:Colors.red ))],
            )
          ),
        )
      ),)
    );
  }
}
//ChangeNotifier is a class that provides change notification to its listeners.
// That means you can subscribe to a class that is extended
// with ChangeNotifier and call its notifyListeners() method when there's a change in that class.
class PageProvider with ChangeNotifier{
  bool? isEligible;
  String? elgibilityMessage="";
  void checkEligibility(int age){
    if(age>=18){
      isEligible=true;
      elgibilityMessage="You are ELigible";
      notifyListeners();//it will notify the consumers and listeners
    }
    else{
      isEligible=false;
      elgibilityMessage="You are not ELigible";
      notifyListeners();//it will notify the consumers and listeners
    }
  }

}

class Controller extends GetxController{
  var count = 0.obs;
  increment() => count++;
}
class GetXStateManagement extends StatelessWidget {

  @override
  Widget build(context) {

    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final Controller c = Controller();

    return MaterialApp(
      home: Scaffold(
        // Use Obx(()=> to update Text() whenever count is changed.
          appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

          // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
          body: Center(child: Obx(() => Text("Clicks: ${c.count}")),),
          floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add),





















              onPressed: c.increment)),
    );
  }
}

