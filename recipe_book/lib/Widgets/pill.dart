import 'package:flutter/material.dart';

class Pill extends StatelessWidget{
  const Pill({ super.key, required this.text });

  final String text;

  @override
  Widget build(BuildContext context) {
   return  Container(
                    width: 96,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor.withAlpha(190),
                          Theme.of(context).primaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
  }
}