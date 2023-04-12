import 'package:flutter/material.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import '../../../../core/dto/snippet/create_snippet.dart';
import '../../../../core/models/snippet.dart';
import '../../../../core/services/snippet_service.dart';

class CreateSnippetModal extends StatefulWidget {
  const CreateSnippetModal({super.key});

  @override
  createState() => _CreateSnippetModal();
}

class _CreateSnippetModal extends State<CreateSnippetModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  Language? _language;

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      await SnippetService.create(CreateSnippetDTO(
        name: _nameController.text,
        code: _codeController.text,
        language: _language!,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: EdgeInsets.zero,
      title: const YaruDialogTitleBar(
        title: Text('Create a new snippet'),
      ),
      children: [
        SizedBox(
          width: 400,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: _nameValidator,
                          controller: _nameController,
                          decoration: const InputDecoration(hintText: 'Name'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField(
                          validator: _languageValidator,
                          items: Language.values
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e.view())))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => _language = value),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    minLines: 5,
                    maxLines: 20,
                    validator: _codeValidator,
                    controller: _codeController,
                    decoration: const InputDecoration(hintText: 'Code'),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _onSubmit,
                        child: const Text('Create'),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  String? _nameValidator(String? value) {
    return value == null || value.isEmpty ? 'Name is required' : null;
  }

  String? _codeValidator(String? value) {
    return value == null || value.isEmpty ? 'Code is required' : null;
  }

  String? _languageValidator(Language? value) {
    return value == null ? 'Language is required' : null;
  }
}
