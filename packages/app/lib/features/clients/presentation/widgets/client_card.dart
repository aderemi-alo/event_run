import 'package:flutter/material.dart';
import 'package:app/features/clients/domain/entities/client_entity.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({super.key, required this.client, this.onTap});

  final ClientEntity client;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Text(
            client.fullName.isNotEmpty ? client.fullName[0].toUpperCase() : '?',
          ),
        ),
        title: Text(client.fullName),
        subtitle: client.email != null ? Text(client.email!) : null,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
