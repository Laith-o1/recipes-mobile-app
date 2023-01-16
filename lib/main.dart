import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:flutter/services.dart' as rootBundle;
import 'dart:convert';
import 'Data_model/recipe_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'your Recipes',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Your Recipes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: readjson(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          } else if (snapshot.hasData) {
            var items = snapshot.data as List<Recipes>;

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  title: Text(items[index].name!),
                  subtitle: const Text("click to see more!"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecipeDetails(
                                  recipe: items[index],
                                ),
                            fullscreenDialog: true));
                  }),
                ));
              },
            );
          } else {
            return const Text('hi data');
          }
        },
      ),
    );
  }

  Future<List> readjson() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('Data/Recipes.json');
    final list = jsonDecode(jsondata) as List<dynamic>;
    return list.map((e) => Recipes.fromJson(e)).toList();
  }
}

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({super.key, required this.recipe});

  final Recipes recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name!),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("ingredients", style: TextStyle(fontSize: 17)),
          const SizedBox(
            height: 10,
          ),
          Text(recipe.ingredients!.join(',')),
          const SizedBox(
            height: 10,
          ),
          const Text("instructions", style: TextStyle(fontSize: 17)),
          const SizedBox(
            height: 10,
          ),
          Text(recipe.instructions!.join(',')),
        ],
      ),
    );
  }
}
