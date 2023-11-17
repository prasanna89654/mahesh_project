import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:project/Riverpod/Models/userModel.dart';
import 'package:project/view/AdminView/approvepage.dart';

import '../../Riverpod/Repository/UserRepository.dart';
import '../../Riverpod/baseDIo.dart';
import '../../Riverpod/config.dart';

class RolesPage extends ConsumerStatefulWidget {
  const RolesPage({super.key});

  @override
  ConsumerState<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends ConsumerState<RolesPage> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final details = ref.watch(getallUsers);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Roles"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          // maintainers = maintainers
                          //     .where((element) =>
                          //         element.name
                          //             .toLowerCase()
                          //             .contains(searchController.text) ||
                          //         element.lastName
                          //             .toLowerCase()
                          //             .contains(searchController.text))
                          //     .toList();
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 28,
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Users",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 10,
              ),
              details.when(
                data: (data) {
                  final users =
                      data.where((element) => element.role == 2).toList();
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                    ),
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 20,
                            child: Text(
                              users[index].username[0].toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            users[index].username,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(users[index].email),
                          trailing: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    context: context,
                                    builder: (context) {
                                      return Wrap(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.02,
                                                vertical: height * 0.02),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextButton(
                                                    onPressed: () async {
                                                      Api()
                                                          .post(
                                                        "${MyConfig.nodeUrl}/user/makeAdmin/${users[index].id}",
                                                      )
                                                          .then((value) {
                                                        Navigator.pop(context);
                                                        setState(() {
                                                          ref.refresh(
                                                              getallUsers);
                                                        });
                                                      });
                                                    },
                                                    child: const Text(
                                                      "Make as Admin",
                                                      style: TextStyle(
                                                        color: Colors.black87,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.more_vert,
                                size: 25,
                              )));
                    },
                  );
                },
                error: (Object error, StackTrace? stackTrace) {
                  return const Text("Error");
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
