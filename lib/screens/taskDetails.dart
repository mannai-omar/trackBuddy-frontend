import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackbuddy/models/MiniTask.dart';
import 'package:trackbuddy/models/Task.dart';
import 'package:trackbuddy/services/miniTask_services.dart';
import 'package:trackbuddy/widgets/bottomNav.dart';

class TaskDetails extends StatefulWidget {
  final Tasks task;
  const TaskDetails({super.key, required this.task});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  final MiniTaskService miniTaskService = MiniTaskService();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle FAB press
        },
        backgroundColor: const Color(0xffF26E56),
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
        
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: ListView(
          children: [
            appBar(context),
            const SizedBox(
              height: 30,
            ),
            taskDescription(),
            const SizedBox(
              height: 30,
            ),
            membersAndDeadlineRow(),
            const SizedBox(
              height: 30,
            ),
            checkist(),
          ],
        ),
      ),
    );
  }

  Widget checkist() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Checklist',
          style: TextStyle(
            color: Color(0xff000000),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        if (widget.task.miniTasks != null && widget.task.miniTasks!.isNotEmpty)
          Column(
            children: [
              for (int index = 0;
                  index < widget.task.miniTasks!.length;
                  index++)
                Column(
                  children: [
                    minitask(widget.task.miniTasks![index]),
                    const SizedBox(height: 15),
                  ],
                ),
            ],
          )
        else
          const Text('No mini tasks available'),
      ],
    );
  }

  GestureDetector minitask(MiniTask miniTask) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 1.5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 1.5,
              child: Checkbox(
                activeColor: Color(0xff53C2C5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                value: miniTask.status == 'completed' ? true : false,
                onChanged: (newValue) {
                  setState(() {
                    miniTask.status == 'completed'
                        ? miniTask.status = 'pending'
                        : miniTask.status = 'completed';
                    //update status api
                    miniTaskService.updateMiniTaskStatus(miniTask.id);
                  });
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                miniTask.description,
                style: const TextStyle(
                    color: Color(0xff000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row membersAndDeadlineRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 45,
          width: 150,
          child: Stack(
            children: [
              Positioned(
                  left: 0,
                  child: avatarWithBorder(
                      'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil_23-2149436200.jpg?w=740&t=st=1717496562~exp=1717497162~hmac=aaa80b7b95df9a0f7eaac2bddb58a8d21077807863468134dfce96b5744cccbe')),
              Positioned(
                  left: 35,
                  child: avatarWithBorder(
                      'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil_23-2149436180.jpg?w=740&t=st=1717591944~exp=1717592544~hmac=64269ae1fd2234b533e8c4891368e8556b8f81ede7c8742305e533b12e69c0ca')),
              Positioned(
                  left: 70,
                  child: avatarWithBorder(
                      'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes_23-2149436190.jpg?t=st=1717591944~exp=1717592544~hmac=d8f133ddd34ab3458f6a4c00de14bafa2ac9f75658c57694dcf04a00777162f6')),
              Positioned(
                left: 105,
                child: avatarWithBorder(
                  'https://img.freepik.com/psd-gratuit/illustration-3d-personne-aux-cheveux-veste-punk_23-2149436198.jpg',
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.access_time_rounded),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'Deadline: ',
                style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                DateFormat('MMMM dd').format(widget.task.dueDate),
                style: const TextStyle(
                    color: Color(0xff000000),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column taskDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.task.title,
          style: const TextStyle(
              color: Color(0xff000000),
              fontSize: 28,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.task.description,
          style: const TextStyle(
              color: Color(0xff000000),
              fontSize: 14,
              fontWeight: FontWeight.w300,
              height: 1.8,
              letterSpacing: 1.2),
        )
      ],
    );
  }

  Container avatarWithBorder(image) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          shape: BoxShape.circle),
      child: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(image),
      ),
    );
  }
}

Row appBar(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BottomNav()),
          );
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 15, 10, 15),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
            color: const Color(0xffFEC347),
            borderRadius: BorderRadius.circular(15)),
        child: const Text(
          'in progress',
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}
