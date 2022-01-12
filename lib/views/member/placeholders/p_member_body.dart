import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/views/widgets/button/custom_icon_button.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shimmer/shimmer.dart';

class PMemberBody extends StatelessWidget {
  const PMemberBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = context.mediaSize.height;
    final isLightTheme = context.isLightTheme;
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: kPrimaryColor,
          highlightColor: kWhiteColor,
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100.0,
                  height: 16.0,
                  color: kWhiteColor,
                ),
                Container(
                  width: 54.0,
                  height: 27.0,
                  color: kWhiteColor,
                )
              ],
            ),
          ),
        ),
        SPACING.SM.vertical,
        Container(
          width: double.infinity,
          height: height * 3 / 5,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          decoration: BoxDecoration(
              color: kWhiteColor,
              border: Border.all(color: kBlackColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: isLightTheme ? kBlackColor : kWhiteColor,
                  offset: const Offset(2.0, 4.0),
                  blurRadius: 4.0,
                )
              ],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: double.infinity,
                  height: SPACING.XXL.size,
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
                  )),
              SPACING.SM.vertical,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
              SPACING.SM.vertical,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  KIconButton(
                    icon: const Icon(
                      AntDesign.adduser,
                      color: kBlackColor,
                    ),
                    backgroundColor: kPlaceholderDarkColor,
                    sideColor: kPlaceholderDarkColor,
                    text: 'Add Member',
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    textStyle: const TextStyle(color: kBlackColor),
                    onPressed: () {},
                  ),
                  KTextButton(
                    text: 'Add With CSV',
                    isOutline: true,
                    color: kBlackColor,
                    backgroudColor: kWhiteColor,
                    width: 150.0,
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
