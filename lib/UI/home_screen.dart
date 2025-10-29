import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_user.dart';
import '../providers/app_user_provider.dart';
import '../controllers/auth_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(analyticsServiceProvider).logScreenView('HomeScreen');
  }

  @override
  Widget build(BuildContext context) {
    final appUserAsync = ref.watch(appUserProvider);

    final homeItemsAsync = ref.watch(homeItemsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
          )
        ],
      ),
      body: Column(
        children: [
          appUserAsync.when(
            data: (user) => _buildWelcomeHeader(context, user),
            loading: () => const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, s) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Error fetching user: $e'),
            ),
          ),
          const Divider(),

          Text('Screen Size (MediaQuery): ${MediaQuery.of(context).size.width.toStringAsFixed(0)}'),
          
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return buildMobileLayout(homeItemsAsync);
                } else {
                  return buildTabletLayout(homeItemsAsync);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader(BuildContext context, AppUser? user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: (user?.photoUrl != null)
                ? NetworkImage(user!.photoUrl!)
                : null,
            child: (user?.photoUrl == null)
                ? const Icon(Icons.person, size: 30)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome ${user?.displayName ?? user?.email ?? 'Guest'}!',
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'UID: ${user?.uid}',
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMobileLayout(AsyncValue<QuerySnapshot> asyncSnapshot) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            ' Mobile Layout (List)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: asyncSnapshot.when(
            data: (snapshot) {
              if (snapshot.docs.isEmpty) {
                return const Center(child: Text('No data'));
              }
              return buildItemsList(snapshot.docs);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text('Error: $e')),
          ),
        ),
      ],
    );
  }

  Widget buildTabletLayout(AsyncValue<QuerySnapshot> asyncSnapshot) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Tablet Layout (Grid)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: asyncSnapshot.when(
            data: (snapshot) {
              if (snapshot.docs.isEmpty) {
                return const Center(child: Text('No data'));
              }
              final docs = snapshot.docs;
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final data = docs[index].data() as Map<String, dynamic>;
                  return Card(
                    elevation: 4,
                    child: Center(
                      child: Text(
                        data['name'] ?? 'Item ${docs[index].id}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text('Error: $e')),
          ),
        ),
      ],
    );
  }

  Widget buildItemsList(List<QueryDocumentSnapshot> docs) {
    if (docs.isEmpty) {
      return const Center(child: Text('No data to add'));
    }
    
    return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final data = docs[index].data() as Map<String, dynamic>;
        return ListTile(
          leading: const Icon(Icons.data_object),
          title: Text(data['name'] ?? 'Item ${docs[index].id}'),
          subtitle: Text('ID: ${docs[index].id}'),
        );
      },
    );
  }
}

