import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(
    MaterialApp(
        title: 'API',
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: const HomePage()
    )
);
