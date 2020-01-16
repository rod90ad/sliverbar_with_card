# Card Sliver App Bar
[![Pub](https://img.shields.io/pub/v/sliverbar_with_card.svg)](https://pub.dev/packages/sliverbar_with_card)
[![Pull Requests are welcome](https://img.shields.io/badge/license-MIT-blue)](https://github.com/rod90ad/sliverbar_with_card/blob/master/LICENSE)
[![Pull Requests are welcome](https://img.shields.io/badge/PRs-welcome-brightgreen)](https://github.com/rod90ad/sliverbar_with_card/pulls)
[![Codemagic build status](https://api.codemagic.io/apps/5e20bb3cc5faa6225933281d/5e20bb3cc5faa6225933281c/status_badge.svg)](https://codemagic.io/apps/5e20bb3cc5faa6225933281d/5e20bb3cc5faa6225933281c/latest_build)

A Flutter package to create a SliverAppBar with a Card.

Inspired by [FaoB](https://github.com/faob-dev)'s [Twitter Post](https://twitter.com/Fa__oB/status/1057740738140798979) design.

![Showcase](https://i.imgur.com/Yjdj1Bw.gif)

## Getting started

Wrap your content with `CardSliverAppBar` and set your desired `options`:

# Basic

```dart
MaterialApp(
  home: Material(
    child: CardSliverAppBar(
        height: 300,
        background: Image.asset("assets/logo.png"),
        title: Text("The Walking Dead"),
        body: Container()
    )
  )
)
```

# With options

```dart
MaterialApp(
  home: Material(
    child: CardSliverAppBar(
        height: 300,
        background: Image.asset("assets/logo.png", fit: BoxFit.cover),
        title: Text("The Walking Dead",
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)
        ),
        titleDescription: Text("Drama, Action, Adventure, Fantasy, \nScience Fiction, Horror, Thriller",
            style: TextStyle(color: Colors.black, fontSize: 11)
        ),
        card: AssetImage("assets/card.jpg"),
        backButton: true,
        backBottonColors: [Colors.white, Colors.black],
        action: IconButton(
          icon: Icon(Icons.favorite),
          iconSize: 30.0,
          color: Colors.red,
          onPressed: (){},
        ),
        body: Container()
    )
  )
)
```

### Options

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| `required` height | Double | The height of background image | -
| `required` background | Image | The image of background | -
| `required` title | Text | The text of title | -
| `required` body | Widget | The body of this widget | - 
| titleDescription | Text | The short description of title | `null`
| backButton | Boolean | If has backButton | `false`
| backButtonColors | List<Color> | The colors of backButton when open and closed | `Colors.white`
| action | Widget | The action between appBar and background | `null`
| card | ImageProvider | The image of card | `null`
