
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/features/select_contact/repository/select_contact_repository.dart';

final getContactProvider = FutureProvider(
        (ref) {
          final selectContactRepository= ref.watch(selectContactsRepositoryProvider);
          return selectContactRepository.getContacts();
        }
);

final selectControllerProvider = Provider((ref) {
  final selectContactRepository = ref.watch(selectContactsRepositoryProvider);
  return SelectController(
      ref: ref,
      selectContactRepository: selectContactRepository
  );
});

class SelectController{
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;

  SelectController({required this.ref,required this.selectContactRepository});

  void selectContact(Contact selectedContact , BuildContext context){
     selectContactRepository.selectContact(selectedContact, context);
  }

}