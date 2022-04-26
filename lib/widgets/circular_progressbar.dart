import 'package:flutter/material.dart';

class CircularProgressbarFullscreen extends StatelessWidget {
  const CircularProgressbarFullscreen({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: AlignmentDirectional.center,
          decoration: const BoxDecoration(
            color: Colors.white70,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
