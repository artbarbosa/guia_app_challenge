import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../infra/model/suite_model.dart';
import 'alert_suit.dart';
import 'rating_stars.dart';

class MotelCard extends StatelessWidget {
  final String name;
  final String distance;
  final String location;
  final double rating;
  final int reviews;
  final List<SuiteModel> suits;
  final String imageUrl;

  const MotelCard({
    super.key,
    required this.name,
    required this.distance,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.suits,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildHeader(),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildRating(),
        ),
        const SizedBox(height: 16),
        if (suits.isNotEmpty) _buildSuitesCarousel(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            errorWidget: (context, error, stackTrace) {
              return Container(
                width: 40,
                height: 40,
                color: Colors.grey[200],
                child: const Icon(Icons.image, color: Colors.grey),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                "$distance - $location",
                style: TextStyle(color: Colors.grey[600]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const Icon(Icons.favorite, size: 30, color: Colors.grey)
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RatingStars(rating: rating),
        const SizedBox(width: 6),
        Text(
          reviews == 1 ? "$reviews avaliação" : "$reviews avaliações",
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildSuitesCarousel() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double dynamicHeight = 266 + suits.length * 23;
        return CarouselSlider.builder(
          options: CarouselOptions(
            height: dynamicHeight,
            enableInfiniteScroll: false,
            enlargeCenterPage: false,
            viewportFraction: 0.95,
            autoPlay: false,
          ),
          itemCount: suits.length,
          itemBuilder: (context, index, realIndex) {
            return _buildSuiteCard(suits[index], context);
          },
        );
      },
    );
  }

  Widget _buildSuiteCard(SuiteModel suite, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: suite.photos.isNotEmpty ? suite.photos.first : '',
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                    errorWidget: (context, error, stackTrace) {
                      return Container(
                        width: 140,
                        height: 80,
                        color: Colors.grey[200],
                        child: const Icon(Icons.bed, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                suite.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (suite.showAvailableQuantity)
                AlertSuit(quantity: suite.quantity),
              SizedBox(height: 8),
            ],
          ),
        ),
        const SizedBox(height: 4),
        _buildSuitePrices(suite, context),
      ],
    );
  }

  Widget _buildSuitePrices(SuiteModel suite, BuildContext context) {
    return Column(
      children: suite.periods
          .map(
            (period) => Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            period.formattedTime,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              if (period.totalPrice < period.price) ...[
                                Text(
                                  "R\$ ${period.price.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "R\$ ${period.totalPrice.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ] else ...[
                                Text(
                                  "R\$ ${period.price.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]
                            ],
                          )
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
