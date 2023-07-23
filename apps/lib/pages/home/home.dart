import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:niku/namespace.dart' as n;

class HomeIndexPage extends HookConsumerWidget {
  const HomeIndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCount = (MediaQuery.of(context).size.width ~/ 200).toInt();

    return Scaffold(
      appBar: AppBar(
        title: n.Text('Home'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: n.IconButton(
          Icons.menu,
          onPressed: () {},
        ),
        actions: [
          n.IconButton(
            Icons.add,
            onPressed: () {},
          ),
          n.IconButton(
            Icons.menu,
            onPressed: () {},
          ),
        ],
        centerTitle: false,
      ),
      backgroundColor: Colors.transparent,
      body: GridView.count(
        crossAxisCount: max(currentCount, 2),
        // gap
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        // padding
        padding: const EdgeInsets.all(16),
        children: [
          ...List.generate(
            3,
            (index) => Center(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(16),
                ),
                height: 300,
                width: 300,
                child: n.Column([
                  n.Icon(Icons.ac_unit)
                    ..color = Colors.cyan.shade600
                    ..size = 48,
                  n.Text('100%')
                    ..color = Colors.white
                    ..fontSize = 34
                    ..textAlign = TextAlign.left
                    ..bold,
                  n.Text('Lorem Ipsum is simply dummy text of ')
                    ..color = Colors.white.withOpacity(0.75),
                ])
                  ..p = 16
                  ..wFull
                  ..gap = 4,
              ),
            )),
          ),
          Center(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                borderRadius: BorderRadius.circular(16),
              ),
              height: 300,
              width: 300,
              child: n.Column([
                n.Row([
                  n.Icon(Icons.sunny)
                    ..color = Colors.orange.shade600
                    ..size = 48,
                  n.Text('10%')
                    ..color = Colors.white
                    ..fontSize = 34
                    ..textAlign = TextAlign.left
                    ..bold
                ]),
                n.Text('ok this sunny')..color = Colors.white.withOpacity(0.75),
              ])
                ..p = 16
                ..wFull
                ..gap = 4,
            ),
          )),
          Center(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                borderRadius: BorderRadius.circular(16),
              ),
              height: 300,
              width: 300,
              child: n.Column([
                n.Row([
                  n.Icon(Icons.mood_bad)
                    ..color = Colors.blue.shade600
                    ..size = 48,
                  n.Text('SAD')
                    ..color = Colors.white
                    ..fontSize = 34
                    ..textAlign = TextAlign.left
                    ..bold
                ]),
                n.Text('ok this not funny')
                  ..color = Colors.white.withOpacity(0.75),
              ])
                ..p = 16
                ..wFull
                ..gap = 4,
            ),
          )),
        ],
      ),
    );
  }
}
