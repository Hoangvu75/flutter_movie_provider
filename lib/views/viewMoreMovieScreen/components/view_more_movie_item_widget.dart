import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app_mvvm/src/PColor.dart';
import 'package:movie_app_mvvm/utils/app_utils.dart';
import 'package:movie_app_mvvm/views/movieDetailsScreen/movie_details_screen.dart';

import '../../../apiResponse/movie_response.dart';
import '../../../generated/assets.dart';

class ViewMoreMovieItem extends StatefulWidget {
  final Movie movie;

  const ViewMoreMovieItem({required Key key, required this.movie})
      : super(key: key);

  @override
  State<ViewMoreMovieItem> createState() => _ViewMoreMovieItemState();
}

class _ViewMoreMovieItemState extends State<ViewMoreMovieItem> {
  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(id: widget.movie.id!)),
        );
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            16 * responsiveSize.width,
            10 * responsiveSize.width,
            16 * responsiveSize.width,
            10 * responsiveSize.width),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12 * responsiveSize.width),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5 * responsiveSize.width,
                  blurRadius: 7 * responsiveSize.width,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white),
          child: Padding(
            padding: EdgeInsets.all(8 * responsiveSize.width),
            child: SizedBox(
              height: 160 * responsiveSize.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 120 * responsiveSize.width,
                    height: 160 * responsiveSize.width,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8 * responsiveSize.width),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                  width: 4 * responsiveSize.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        4 * responsiveSize.width),
                                    color: PColors.darkBlue,
                                  )),
                              SizedBox(width: 8 * responsiveSize.width),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: widget.movie.title == null
                                            ? widget.movie.name.toString()
                                            : widget.movie.title.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15 * responsiveSize.width,
                                            color: PColors.defaultText,
                                            fontFamily:
                                                Assets.fontsSVNGilroyBold),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 10 * responsiveSize.width),
                                    Text.rich(
                                      TextSpan(
                                        text: widget.movie.overview,
                                        style: TextStyle(
                                            color: PColors.lightColorText,
                                            fontSize: 13 * responsiveSize.width,
                                            fontFamily:
                                                Assets.fontsSVNGilroySemiBold),
                                      ),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              Assets.svgsIcTimer,
                              width: 15 * responsiveSize.width,
                              height: 15 * responsiveSize.width,
                            ),
                            SizedBox(
                              width: 5 * responsiveSize.width,
                            ),
                            Text(
                              widget.movie.releaseDate == null
                                  ? 'Released on ${widget.movie.firstAirDate}'
                                  : 'Released on ${widget.movie.releaseDate}',
                              style: TextStyle(
                                  color: PColors.lightColorText,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12 * responsiveSize.width,
                                  fontFamily: Assets.fontsSVNGilroyRegular),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
