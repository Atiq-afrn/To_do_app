import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data_base/database.dart';
import 'package:random_string/random_string.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool college = true, personel = false, office = false;
  bool suggest = false;
  TextEditingController taskcontroller = TextEditingController();
  Stream? todoStream;
  getontheLoad() async {
    todoStream = await DatabaseService().getTask(personel
        ? "Personal"
        : college
            ? "College"
            : "Office");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget getwork() {
    return Expanded(
      child: StreamBuilder(
        stream: todoStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, Index) {
                        DocumentSnapshot docsnap = snapshot.data.docs[Index];
                        return CheckboxListTile(
                          activeColor: Colors.blue.shade400,
                          title: Text(docsnap['work']),
                          value: docsnap["Yes"],
                          onChanged: (newvalue) async {
                            DatabaseService().tickMethod(
                                docsnap["id"],
                                personel
                                    ? "Personal"
                                    : college
                                        ? "College"
                                        : "Office");
                            setState(() {
                              Future.delayed(const Duration(seconds: 4), () {
                                DatabaseService().removeMethod(
                                    docsnap["id"],
                                    personel
                                        ? "Personal"
                                        : college
                                            ? "College"
                                            : "Office");
                              });
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }))
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          openBox();
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 207, 112, 224),
            Color.fromARGB(255, 183, 237, 185),
            Color.fromARGB(255, 224, 148, 173)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 60, left: 20),
              child: const Text(
                "Hii !",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                "Atiq ",
                style: TextStyle(fontSize: 40),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                "Let's get the work",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                college
                    ? Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            "College",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          college = true;
                          personel = false;
                          office = false;
                          await getontheLoad();
                          setState(() {});
                        },
                        child: const Text(
                          "College",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                personel
                    ? Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            "Personal",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          college = false;
                          personel = true;
                          office = false;
                          await getontheLoad();
                          setState(() {});
                        },
                        child: const Text(
                          "Personal",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                office
                    ? Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            "Office",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          college = false;
                          personel = false;
                          office = true;

                          await getontheLoad();
                          setState(() {});
                        },
                        child: const Text(
                          "Office",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            getwork(),
          ],
        ),
      ),
    );
  }

  Future openBox() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Text(
                      "Add todo task",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: const Text('Add text'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(),
                  child: TextField(
                    controller: taskcontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: " Add task"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      String id = randomAlphaNumeric(10);
                      Map<String, dynamic> UserTodo = {
                        "work": taskcontroller.text,
                        "id": id,
                        "Yes": false,
                      };
                      college
                          ? DatabaseService().addCollegTask(UserTodo, id)
                          : personel
                              ? DatabaseService().addPersonelTask(UserTodo, id)
                              : DatabaseService().addOfficeTask(UserTodo, id);

                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
