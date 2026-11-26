import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/connection_state.dart';
import '../../state/hosts_state.dart';
import 'link_progress.dart';

/// The same live connection stages on the chat landing page and host page.
class RemoteConnectionProgress extends ConsumerWidget {
  const RemoteConnectionProgress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final host = ref.watch(activeHostProvider);
    if (host.isLocal) return const SizedBox.shrink();
    final status = ref.watch(hostLinkStatusProvider(host)).value;
    if (status == null || !status.isBusy) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Semantics(
        liveRegion: true,
        child: LinkProgressCard(status: status, relay: host.kind == HostKind.relay),
      ),
    );
  }
}
