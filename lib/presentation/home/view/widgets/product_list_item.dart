import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/model/beer_model.dart';
import '../../../../core/utils/assets.dart';

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.beer});
  final Beer beer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/productdetail', extra: beer),
      child: Column(
        children: [
          _imageStack(),
          _productDetail(),
        ],
      ),
    );
  }

  Widget _imageStack() {
    return Expanded(
      flex: 75,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(Assets.background),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 30),
                child: Image.network(
                  beer.imageUrl,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                color: Color(0xFF1E2022),
                child: Text(
                  'First Brewed: ${beer.firstBrewed}',
                  style: TextStyle(
                      color: Color(0xfff2f2f2),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productDetail() {
    return Expanded(
      flex: 74,
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 14, 12, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            beer.name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            beer.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Color(0xff77838F),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              _infoRow('ABV', beer.abv),
              SizedBox(
                width: 16,
              ),
              _infoRow('IBU', beer.ibu),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _infoRow(
    String title,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
        Text(
          value,
          style: TextStyle(
            color: Color(0xff77838F),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
