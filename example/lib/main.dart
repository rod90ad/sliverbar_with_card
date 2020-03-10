import 'package:flutter/material.dart';
import 'package:sliverbar_with_card/sliverbar_with_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  bool favorito = false;
  bool expandText = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "CardSliverAppBar Example",
        home: Material(
          child: CardSliverAppBar(
            height: 300,
            background: Image.asset("assets/logo.png", fit: BoxFit.cover),
            title: Text("The Walking Dead",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            titleDescription: Text(
                "Drama, Action, Adventure, Fantasy, \nScience Fiction, Horror, Thriller",
                style: TextStyle(color: Colors.black, fontSize: 11)),
            card: AssetImage("assets/card.jpg"),
            backButton: true,
            backButtonColors: [Colors.white, Colors.black],
            action: IconButton(
              onPressed: () {
                setState(() {
                  favorito = !favorito;
                });
              },
              icon:
                  favorito ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
              color: Colors.red,
              iconSize: 30.0,
            ),
            body: Container(
              alignment: Alignment.topLeft,
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _ratingIcon(
                            Icon(Icons.star),
                            Text("84%",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        _ratingIcon(
                            Icon(Icons.personal_video),
                            Text("AMC",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        _ratingIcon(
                            Icon(Icons.people),
                            Text("TV-MA",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        _ratingIcon(
                            Icon(Icons.av_timer),
                            Text("45m",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    height: expandText ? 145 : 65,
                    margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            expandText = !expandText;
                          });
                        },
                        child: Text(
                            "The series centers on sheriff's deputy Rick Grimes, who wakes up from a coma to discover the apocalypse. He becomes the leader of a group of survivours from the Atlanta, Georgia..\n" +
                                "region as they attempt to sustain themselves and protect themselves not only against attacks by walkers but by other groups of survivors willing to assure their longevity by any means necessary.")),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 30),
                    child: Text("Related shows",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        _exampleRelatedShow(),
                        _exampleRelatedShow(),
                        _exampleRelatedShow(),
                        _exampleRelatedShow(),
                        _exampleRelatedShow(),
                        _exampleRelatedShow(),
                        _exampleRelatedShow(),
                        _exampleRelatedShow(),
                        _exampleRelatedShow(),
                        _exampleRelatedShow(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _exampleRelatedShow() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.grey,
      ),
      width: 80,
      height: 100,
    );
  }

  Widget _ratingIcon(Icon icon, Text text) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.grey),
            child: IconButton(
              onPressed: () {},
              icon: icon,
              color: Colors.white,
              iconSize: 30,
            ),
          ),
          Divider(),
          text
        ],
      ),
    );
  }
}
