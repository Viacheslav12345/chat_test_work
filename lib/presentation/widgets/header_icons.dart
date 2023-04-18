// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../../common/const.dart';

class HeaderIcons extends StatefulWidget {
  final List<Image> avaImages;
  const HeaderIcons({
    Key? key,
    required this.avaImages,
  }) : super(key: key);

  @override
  State<HeaderIcons> createState() => _HeaderIconsState();
}

class _HeaderIconsState extends State<HeaderIcons> {
  @override
  Widget build(BuildContext context) {
    double pShift = -18;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    List<Widget> listOfIcons = [];

    for (var i = 0; i < widget.avaImages.length; i++) {
      pShift = pShift + 20 * fem;
      listOfIcons.add(Positioned(
        left: pShift,
        top: 0 * fem,
        child: Container(
          padding: EdgeInsets.fromLTRB(1 * fem, 1 * fem, 1 * fem, 1 * fem),
          width: 26 * fem,
          height: 26 * fem,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(13 * fem),
          ),
          child: Center(
            child: SizedBox(
              width: 24 * fem,
              height: 24 * fem,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150 * fem),
                child: widget.avaImages[i],
              ),
            ),
          ),
        ),
      ));
    }

    return Stack(
      children: listOfIcons,
    );
  }
}
