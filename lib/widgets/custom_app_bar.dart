import 'package:flutter/material.dart';
import 'package:mobile/assets.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 24.0,
      ),
      color: Colors.orange,
      child: SafeArea(
        child: Row(
          children: [
            Image.asset(Assets.netflixLogo0),
            const SizedBox( width: 12.0,),
            Row(
              children: [
                GestureDetector(
                  onTap: () => print('TV Shows'),
                  child: const Text(
                    'TV Shows',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => print('TV Shows'),
                  child: const Text(
                    'TV Shows',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      )

    );
  }
}
class _AppBarButton extends StatelessWidget{
  final String title;
  final Function onTap;
  const _AppBarButton({
    Key? key,
    required this.onTap,
    required this.title,
}) :super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap(),
      child: const Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  
}
