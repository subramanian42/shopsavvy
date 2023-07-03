import 'package:flutter_test/flutter_test.dart';
import 'package:shopsavvy/core/model/beer_model.dart';

void main() {
  group('Beer', () {
    test('fromJson() should return a valid Beer object', () {
      final json = {
        "id": 1,
        "name": "Buzz",
        "tagline": "A Real Bitter Experience.",
        "first_brewed": "09/2007",
        "description":
            "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
        "image_url": "https://images.punkapi.com/v2/keg.png",
        "abv": 4.5,
        "ibu": 60,
        "target_fg": 1010,
        "target_og": 1044,
        "ebc": 20,
        "srm": 10,
        "ph": 4.4,
        "attenuation_level": 75
      };

      final beer = Beer.fromJson(json);

      expect(beer.id, 1);
      expect(beer.name, 'Buzz');
      expect(beer.tagline, 'A Real Bitter Experience.');
      expect(beer.firstBrewed, '09/2007');
      expect(beer.description,
          'A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.');
      expect(beer.imageUrl, 'https://images.punkapi.com/v2/keg.png');
      expect(beer.abv, '4.5');
      expect(beer.ibu, '60');
      expect(beer.targetFg, '1010');
      expect(beer.targetOg, '1044');
      expect(beer.ebc, '20');
      expect(beer.srm, '10');
      expect(beer.ph, '4.4');
      expect(beer.attenuationLevel, '75');
    });

    test('toJson() should return a valid JSON object', () {
      final beer = Beer(
        id: 1,
        name: 'Buzz',
        tagline: 'A Real Bitter Experience.',
        firstBrewed: '09/2007',
        description:
            'A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.',
        imageUrl: 'https://images.punkapi.com/v2/keg.png',
        abv: '4.5',
        ibu: '60',
        targetFg: '1010',
        targetOg: '1044',
        ebc: '20',
        srm: '10',
        ph: '4.4',
        attenuationLevel: '75',
      );

      final json = beer.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'Buzz');
      expect(json['tagline'], 'A Real Bitter Experience.');
      expect(json['first_brewed'], '09/2007');
      expect(json['description'],
          'A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.');
      expect(json['image_url'], 'https://images.punkapi.com/v2/keg.png');
      expect(json['abv'], 4.5);
      expect(json['ibu'], 60);
      expect(json['target_fg'], 1010);
      expect(json['target_og'], 1044);
      expect(json['ebc'], 20);
      expect(json['srm'], 10);
      expect(json['ph'], 4.4);
      expect(json['attenuation_level'], 75);
    });
  });
}
