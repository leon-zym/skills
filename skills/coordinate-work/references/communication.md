# Communication and Execution Capabilities

Read this when establishing the operating agreement, changing environments, or recovering a broken handoff. Use the host's current documentation and exposed capabilities to resolve concrete operations. These are capability requirements, not a fixed tool API or a claim that every agent supports them.

## Select a mechanism

Prefer the best-supported mechanism that meets the work's lifecycle requirements, not a universal platform ranking.

| Candidate | Confirm before recommending it |
| --- | --- |
| Native independent sessions or threads | Creation authorization, stable destination identity, messages in both directions, actual coordinator wakeup, worker lifetime after the parent yields, and inspectable status. |
| Native subagents | Whether workers survive a parent yield, how results are delivered, whether results wake the parent, and whether workers can be resumed. Subagents need not imply synchronous execution. |
| herdr in a supported terminal environment | Discoverable workspace/tab/pane identities, real prompt delivery into the intended agent, and reliable return routing. Use its available instructions if present; do not infer readiness from the application's installation alone. |
| tmux in an existing terminal workflow | Available agent processes, stable pane/session identities, permission to create or control them, and a tested input/output path. A terminal pane is not an agent, and writing text into it is not proof of prompt submission or wakeup. |

A live-parent subagent arrangement is valid delegation when confirmed with the user. Keep the coordinator alive through the host's supported waiting lifecycle; do not substitute a claim of asynchronous wakeup. If mechanisms exist but none can satisfy the requested autonomy, explain that limitation before dispatch and let the user choose a supported arrangement or stop.

Do not silently install software, create accounts, acquire models, or modify unrelated terminal sessions to manufacture a mechanism. Avoid binding sessions to fragile display positions when stable identities are available.

## Confirm and exercise the route

Record the chosen mechanism, current identities, workspace locations, available settings, and lifecycle limitations in the run state. Resolve provisional creation identities before relying on them. If creation or delivery has an uncertain result, inspect existing state before retrying; do not duplicate a worker or operation merely because a response was lost.

The first real worker assignment should include a small acceptance callback identifying its run, assignment, attempt, workspace, and source baseline. Verify return delivery and the claimed wakeup behavior using this useful handshake where feasible. Until verified, record wakeup as unverified and retain a supported observation path. Do not launch a large unattended batch based on a guessed capability.

## Notification contract

Each notification identifies:

- Run and assignment, attempt or revision, and sender.
- Event: accepted, blocked, ready for review, review result, final verification, or resource release.
- Exact work version, concise result, and durable evidence location.
- Remaining responsibilities, current resource ownership, and the requested next action.

Keep notifications short. Combine readiness and resource release when practical. A worker that sends an intermediate notification continues owning unfinished work. If it cannot continue, it records a blocked handoff with the remaining action instead of merely stating that responsibility is retained.

Persist results first, attempt actual delivery, and check the available delivery result. Delivery acknowledgment is not acceptance of the work. On uncertain delivery, check the receiver or message state where supported, then retry only within a bounded policy. Preserve undelivered results in the assignment record. Do not claim the coordinator was notified if only a final answer or local file was written.

Workers also reconcile duplicate instructions by run, assignment, and attempt identity. On receiving the same attempt again, inspect its durable checkpoint and report or resume its existing execution; do not restart completed side effects. A new attempt must explicitly supersede the old one, with overlapping ownership resolved first. These records support deduplication but do not provide an atomic delivery guarantee. If delivery cannot be inspected and execution cannot be made safe against duplicates, leave it uncertain and obtain a targeted acknowledgment rather than retrying consequential work blindly.

The coordinator processes each event once, using assignment/attempt/version identity. Late results from superseded attempts do not authorize writes or integration. A stale callback can supply evidence but cannot revive paused or completed work. Transfer authority through the coordinator rather than letting implementers and reviewers independently change each other's scope.

## Optional heartbeat

Use a heartbeat only if scheduling and wakeup are available, within the confirmed operating agreement. Record its owner and purpose. It performs a compact check of current state and outstanding responsibilities, not a second CI watcher or a full-history scan.

Unchanged healthy state stays quiet. A missing handoff triggers one targeted reconciliation, not blind task recreation or rerunning tests. A heartbeat cannot guarantee execution when the host or agent runtime is unavailable. It supplements callbacks; it does not establish their reliability.

On pause or completion, disable the run's monitor. On recovery, inspect an existing monitor before enabling it; never create duplicates by default.
