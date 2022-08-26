import 'package:flutter/material.dart';

class Bottoms extends StatelessWidget {
  const Bottoms({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Container(
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(icon: const Icon(Icons.menu),
                  onPressed: () {},),
                IconButton(icon: const Icon(Icons.refresh),
                  onPressed: () {},),
              ],
            ), //left_side
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(icon: const Icon(Icons.arrow_back),
                  onPressed: () {},),
                IconButton(icon: const Icon(Icons.arrow_forward),
                  onPressed: () {},),
              ],
            ), //right_side
          ],
        ),
      ),
    );
  }
}
