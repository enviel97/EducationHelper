import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MembersListShow extends StatelessWidget {
  final List<Member> members;

  const MembersListShow({
    required this.members,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: _buildMember);
  }

  Widget _nullableBuild(String? value) {
    if (value?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }
    return Text(
      value!,
      style: const TextStyle(
        color: kWhiteColor,
      ),
    );
  }

  Widget _buildMember(BuildContext context, int index) {
    final member = members[index];
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
              color: kPrimaryLightColor.withOpacity(0.5),
              offset: const Offset(5.0, 5.0),
              blurRadius: 5.0)
        ],
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('${member.lastName} ${member.firstName}'),
                _nullableBuild(member.birth),
                _nullableBuild(member.mail),
                _nullableBuild(member.phoneNumber)
              ])),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  member.gender == 'male'
                      ? FontAwesome5Solid.male
                      : FontAwesome5Solid.female,
                  size: 32.0,
                ),
                Icon(
                  member.gender == 'male'
                      ? FontAwesome5Solid.male
                      : FontAwesome5Solid.female,
                  size: 32.0,
                )
              ]),
        ],
      ),
    );
  }
}
