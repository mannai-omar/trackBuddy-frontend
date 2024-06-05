import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:trackbuddy/screens/taskDetails.dart';
import 'package:trackbuddy/services/task_services.dart';
import '../models/Task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Tasks>> futureTasks;
  final TaskService taskService = TaskService();

  @override
  void initState() {
    super.initState();
    futureTasks = taskService.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: ListView(
          children: [
            appBar(),
            const SizedBox(
              height: 20,
            ),
            statusCards(),
            const SizedBox(
              height: 20,
            ),
            tasksList(context)
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<Tasks>> tasksList(context) {
    return FutureBuilder<List<Tasks>>(
        future: futureTasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tasks found.'));
          } else {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 15); 
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Tasks task = snapshot.data![index];
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskDetails()),
                        );
                      },
                      child: Container(
                        height: 120,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: Colors.black, width: 1.5)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  task.title,
                                  style: const TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  task.description,
                                  style: const TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.check_circle_outline),
                                    Text(
                                      task.miniTasks!.length.toString() +
                                          ' tasks',
                                      style: const TextStyle(
                                          color: Color(0xff000000),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      top: 15,
                      bottom: 15,
                      child: CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 6.0,
                        animation: true,
                        animationDuration: 1200,
                        percent: 0.7,
                        center: const Text(
                          "70.0%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.green,
                      ),
                    )
                  ],
                );
              },
            );
          }
        });
  }

  Column statusCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Color(0xff5694F2),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white12,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.cached,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'On going',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '24 Tasks',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 13,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Color(0xffFEC347),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white12,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.access_time_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'In progress',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '4 Tasks',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 13,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Color(0xff52C0C3),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white12,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.file_copy_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Completed',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '43 Tasks',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 13,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Color(0xffF06D55),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white12,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Canceled',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '8 Tasks',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 13,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row appBar() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
              'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil_23-2149436200.jpg?w=740&t=st=1717496562~exp=1717497162~hmac=aaa80b7b95df9a0f7eaac2bddb58a8d21077807863468134dfce96b5744cccbe'),
          radius: 25,
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hi, Bruce',
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Your daily adventure starts now',
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 13,
                  fontWeight: FontWeight.w300),
            )
          ],
        )
      ],
    );
  }
}
