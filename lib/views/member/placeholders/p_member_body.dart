import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PMemberBody extends StatelessWidget {
  const PMemberBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: kBlackColor),
                  boxShadow: [
                    BoxShadow(
                      color: kBlackColor.withOpacity(.5),
                      offset: const Offset(0, 4),
                      blurRadius: 4.0,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 70.0,
                      width: 70.0,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: const CircularProgressIndicator(
                        color: kSecondaryColor,
                      ),
                    ),
                    SPACING.SM.horizontal,
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: kWhiteColor,
                        highlightColor: kWhiteColor.withOpacity(.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: SPACING.M.size + 1.5,
                                    width: double.infinity,
                                    color: kWhiteColor,
                                  ),
                                ),
                                SPACING.S.horizontal,
                                SizedBox(
                                  width: SPACING.M.size,
                                  height: SPACING.M.size,
                                  child: const CircularProgressIndicator(
                                    color: kSecondaryColor,
                                  ),
                                )
                              ],
                            ),
                            SPACING.S.vertical,
                            Container(
                              width: double.infinity,
                              height: SPACING.M.size,
                              color: kWhiteColor,
                            ),
                            SPACING.S.vertical,
                            Container(
                              width: double.infinity,
                              height: SPACING.M.size,
                              color: kWhiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
