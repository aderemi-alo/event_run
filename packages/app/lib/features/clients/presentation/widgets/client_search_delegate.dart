import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/router/route_names.dart';
import 'package:app/features/clients/domain/entities/client_entity.dart';

class ClientSearchDelegate extends SearchDelegate<ClientEntity?> {
  ClientSearchDelegate({required this.clients});

  final List<ClientEntity> clients;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    final filtered = clients.where((c) {
      final q = query.toLowerCase();
      return c.fullName.toLowerCase().contains(q) ||
          (c.email?.toLowerCase().contains(q) ?? false) ||
          (c.phone?.contains(q) ?? false);
    }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          query.isEmpty ? 'Search clients' : 'No clients found',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final client = filtered[index];
        return ListTile(
          leading: CircleAvatar(child: Text(client.fullName[0].toUpperCase())),
          title: Text(client.fullName),
          subtitle: client.email != null ? Text(client.email!) : null,
          onTap: () {
            close(context, client);
            context.pushNamed(
              RouteNames.clientDetail,
              pathParameters: {'id': client.id},
            );
          },
        );
      },
    );
  }
}
