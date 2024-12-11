import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfine_task/data/models/todo.dart';

class FireStoreServices {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('todos');

  Future<void> addTodo(Model model) async {
    try {
      await _collection.doc(model.id).set(model.toMap());
    } catch (e) {
      rethrow; 
    }
  }

  Stream<List<Model>> getTodos() {
    return _collection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Model.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
