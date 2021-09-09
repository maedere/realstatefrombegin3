import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import '../../model/object/agent.dart';
import 'package:realstatefrombegin3/util/size_config.dart';

class AgentShow extends StatelessWidget {
  final Agent agent;

  AgentShow({@required this.agent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 10.v,
      margin: EdgeInsets.symmetric(vertical: 2.v, horizontal: 2.h),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: agent.image == null
                    ? AssetImage(Constant.IMAGE_ADDRESS + "women.jpg")
                    : NetworkImage(Constant.BASE_IMAGE_ADDRESS + agent.image),
              ),
            ),
            width: 10.v,
            height: 10.v,
          ),
          SizedBox(
            width: 3.h,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(agent.name),
              SizedBox(
                height: 5,
              ),
              Text(agent.email),
            ],
          )
        ],
      ),
    );
  }
}
