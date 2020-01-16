library sliverbar_with_card;

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sliverbar_with_card/clips/clip_chanfro.dart';

class CardSliverAppBar extends StatefulWidget {
  final double height;
  final Image background;
  final double appBarHeight = 60;
  final Text title;
  final Text titleDescription;
  final bool backButton;
  final List<Color> backBottonColors;
  final Widget action;
  final Widget body;
  final ImageProvider card;

  CardSliverAppBar(
      {@required this.height,
      @required this.background,
      @required this.title,
      @required this.body,
      this.titleDescription,
      this.backButton = false,
      this.backBottonColors,
      this.action,
      this.card,
      Key key})
      : assert(height != null && height > 0),
        assert(background != null),
        assert(title != null),
        assert(body != null),
        super(key: key);

  @override
  _CardSliverAppBarState createState() => _CardSliverAppBarState();
}

class _CardSliverAppBarState extends State<CardSliverAppBar>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController;
  AnimationController animationController;
  Animation<double> fadeTransition;
  Animatable<Color> animatedBackButtonColors;
  Animation<double> rotateCard;

  double scale = 0.0;
  double offset = 0.0;

  @override
  void dispose() {
    scrollController?.dispose();
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    fadeTransition = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.4, 1.0, curve: Curves.easeIn)))
      ..addListener(() {
        setState(() {});
      });
    if (widget.card != null) {
      rotateCard = Tween(begin: 0.0, end: 0.4).animate(
          CurvedAnimation(curve: Curves.linear, parent: animationController))
        ..addListener(() {
          setState(() {});
        });
    }
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {});
    });
  }

  void _animationController(double scale) {
    animationController.value = scale;
  }

  @override
  Widget build(BuildContext context) {
    if (scrollController.hasClients) {
      scale = scrollController.offset / (widget.height - widget.appBarHeight);
      if (scale > 1) {
        scale = 1.0;
      }
      offset = scrollController.offset;
    }
    _animationController(scale);
    scale = 1.0 - scale;

    if (widget.backBottonColors != null &&
        widget.backBottonColors.length >= 2) {
      animatedBackButtonColors = TweenSequence<Color>([
        TweenSequenceItem(
            weight: 1.0,
            tween: ColorTween(
              begin: widget.backBottonColors[0],
              end: widget.backBottonColors[1],
            ))
      ]);
    }

    List<Widget> stackOrder = List<Widget>();
    if (scale >= 0.5) {
      stackOrder.add(_bodyContainer());
      stackOrder.add(_backgroundConstructor());
      stackOrder.add(_shadowConstructor());
      stackOrder.add(_titleConstructor());
      if (widget.card != null) stackOrder.add(_cardConstructor());
      if (widget.action != null) stackOrder.add(_actionConstructor());
      if (widget.backButton != null && widget.backButton)
        stackOrder.add(_backButtonConstructor());
    } else {
      stackOrder.add(_backgroundConstructor());
      if (widget.card != null) stackOrder.add(_cardConstructor());
      stackOrder.add(_bodyContainer());
      stackOrder.add(_shadowConstructor());
      stackOrder.add(_titleConstructor());
      if (widget.action != null) stackOrder.add(_actionConstructor());
      if (widget.backButton != null && widget.backButton)
        stackOrder.add(_backButtonConstructor());
    }

    return SafeArea(
      child: Container(
        child: ListView(
          controller: scrollController,
          primary: false,
          children: <Widget>[
            Stack(
              key: GlobalKey(),
              children: stackOrder,
            )
          ],
        ),
      ),
    );
  }

  Widget _backButtonConstructor() {
    return Positioned(
      top: offset + 7,
      left: 5,
      child: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            color: animatedBackButtonColors != null
                ? animatedBackButtonColors
                    .evaluate(AlwaysStoppedAnimation(animationController.value))
                : Colors.white,
            iconSize: 25,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  Widget _bodyContainer() {
    return Container(
      key: GlobalKey(),
      margin: EdgeInsets.only(top: widget.height),
      child: widget.body,
    );
  }

  double _getRotationAnimationValue(double animValue) {
    animValue = animValue * 5;
    double value = -pow(animValue, 2) + (2 * animValue);
    return value;
  }

  double _getCardTopMargin() {
    double value = scale <= 0.5
        ? widget.height - ((widget.appBarHeight * 3.6) * scale)
        : widget.height - (widget.appBarHeight * 1.8);
    return value;
  }

  Widget _cardConstructor() {
    return Positioned(
      key: GlobalKey(),
      top: _getCardTopMargin(),
      left: 20,
      child: Transform.rotate(
        angle: _getRotationAnimationValue(rotateCard.value),
        origin: Offset(50, -70),
        child: SizedBox(
          width: widget.appBarHeight * 1.67,
          height: widget.appBarHeight * 2.3,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(image: widget.card, fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }

  Widget _backgroundConstructor() {
    return Container(
      key: GlobalKey(),
      height: widget.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: FadeTransition(
        opacity: fadeTransition,
        child: widget.background,
      ),
    );
  }

  Widget _shadowConstructor() {
    return Positioned(
        key: GlobalKey(),
        top: scale == 0.0 ? offset + widget.appBarHeight : widget.height,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 1.0,
              )
            ])));
  }

  Widget _titleConstructor() {
    return Positioned(
      key: GlobalKey(),
      top: scale == 0.0 ? offset : widget.height - widget.appBarHeight,
      child: ClipPath(
        clipper: MyCliperChanfro(animationController.value),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
              left: scale >= 0.12
                  ? 40 + ((MediaQuery.of(context).size.width / 4) * scale)
                  : 50),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          height: widget.appBarHeight,
          child: _titleDescriptionHandler(),
        ),
      ),
    );
  }

  Widget _titleDescriptionHandler() {
    if (widget.titleDescription != null) {
      var titleContainer = Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(bottom: (25 * scale)),
        child: widget.title,
      );

      var titleDescriptionContainer = Opacity(
        opacity: scale <= 0.7 ? scale / 0.7 : 1.0,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: (25 * scale)),
          child: widget.titleDescription,
        ),
      );

      return Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          titleDescriptionContainer,
          titleContainer,
        ],
      );
    } else {
      return widget.title;
    }
  }

  Widget _actionConstructor() {
    return Positioned(
        key: GlobalKey(),
        top: widget.height - widget.appBarHeight - 25,
        right: 10,
        child: Transform.scale(
            scale: scale >= 0.5 ? 1.0 : (scale / 0.5),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(color: Colors.black54, blurRadius: 3.0)
                  ]),
              child: widget.action,
            )));
  }
}
