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
          _imageStack(context),
          _productDetail(context),
        ],
      ),
    );
  }

  Widget _imageStack(BuildContext context) {
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
                color: Theme.of(context).primaryColor,
                child: Text(
                  'First Brewed: ${beer.firstBrewed}',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productDetail(BuildContext context) {
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            beer.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              _infoRow('ABV', beer.abv, context),
              SizedBox(
                width: 16,
              ),
              _infoRow('IBU', beer.ibu, context),
            ],
          ),
          SizedBox(
            height: 16,
          ),
        ]),
      ),
    );
  }

  Widget _infoRow(String title, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(value,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color:
                    Theme.of(context).colorScheme.secondary //Color(0xff77838F),
                )),
      ],
    );
  }
}
