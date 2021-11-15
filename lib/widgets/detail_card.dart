import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String? title;
  final String? details;
  final String? imagePath;
  final void Function()? onTap;
  final bool? isSelected;
  const DetailCard(
      {this.title, this.details, this.imagePath, this.onTap, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: isSelected! ? 3 : 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 150,
          height: 150 * (3 / 2),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          decoration: BoxDecoration(
            color: isSelected! ? const Color(0xffe9f4f3) : Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xffe9f4f3),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:
                          isSelected! ? const Color(0xff057163) : Colors.black,
                    ),
                  ),
                  Text(
                    details!,
                    style: TextStyle(
                        color: isSelected! ? Color(0xff057163) : Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    imagePath!,
                    height: 80,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
