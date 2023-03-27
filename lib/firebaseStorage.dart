import 'package:firebase_database/firebase_database.dart';


FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference dataRef = FirebaseDatabase.instance.ref("https://alphaprototy-default-rtdb.firebaseio.com/");

/*DatabaseReference child = ref.child("name").get();
final snapshot = await ref.child('users/$userId').get();
if (snapshot.exists) {
    print(snapshot.value);
} else {
    print('No data available.');
}*/
