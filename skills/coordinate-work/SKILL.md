---
name: coordinate-work
description: Coordinate coding work that benefits from delegation across implementation, code review, and integration. Use for tasks with distinct workstreams or sustained collaboration; not for small, self-contained changes.
license: MIT
metadata:
  author: leon-zym
  version: "1.0.0"
---

# Coordinate Work

Run a delegation-based coding workflow with clear ownership, independent review, and recoverable progress. Choose the smallest team and process that improve delivery. The skill grants no additional permission to edit, publish, merge, install infrastructure, or contact other people.

Write runtime plans, assignments, status, handoffs, and decision records in the user's language. Keep code and repository documentation consistent with their own conventions.

## 1. Establish the operating agreement

Discover actual capabilities before promising unattended execution. Read [Communication](references/communication.md) when selecting or changing the mechanism.

If no delegation mechanism is available, this skill is inapplicable. If the user explicitly invoked it, explain the limitation and stop the requested workflow. If selected automatically, leave this skill and choose another approach. Do not present single-agent work as a fallback implementation of this skill.

Before dispatching work, present one compact configuration for active user confirmation:

- **Communication:** available mechanisms, the recommended default, and whether workers can wake an inactive coordinator or require a live parent.
- **Worker settings by role:** list verifiable available models and their supported reasoning settings, grouping a long catalog for readability, and recommend a configuration for each needed role. Otherwise disclose what is unknown or inherited. Never invent available options. The user controls the coordinator's settings in the current conversation; do not change them.
- **Operating limits:** proposed concurrency and heavy-resource limits, review depth, authority boundaries, and any optional heartbeat.

Use preselected recommended options when the interface supports them; otherwise label recommendations clearly. A preselection is not confirmation. Confirm once per work batch, not per assignment. Reuse confirmed settings after an interruption only after checking that they remain available. Reconfirm material mechanism, model, cost, or authority changes; do not silently substitute unavailable choices.

Define the outcome, acceptance criteria, exclusions, dependencies, and integration authority. Resolve decisions the coordinator cannot responsibly settle, significant changes of direction, and substantial departures from the agreed plan with the user. Handle ordinary implementation and scheduling choices within the approved scope without repeated questions.

## 2. Establish recoverable state

Before launching workers, follow [State and Recovery](references/state-and-recovery.md). Locate an existing run before creating one. Give the user a stable, readable recovery entry point.

Keep current state separate from history and bulky evidence. Persist assignments before dispatch and worker checkpoints before consequential actions; do not rely on a final summary being written. A replacement coordinator must be able to find ownership, versions, evidence, unresolved decisions, and the next action without reading conversation history.

## 3. Delegate coherent work

Split by independently verifiable outcomes and actual dependencies, not by file count or a desire to maximize parallelism. Start with a small number of workers; add one only when it can make independent progress without disproportionate coordination or resource costs.

The coordinator owns planning, scheduling, review routing, integration, and overall acceptance. It normally delegates product implementation and review fixes. Targeted inspection, integration conflict resolution, and tiny mechanical edits are reasonable; substantive coordinator changes still require independent review.

Use implementers and reviewers as needed. Add explorers or planners only for a concrete unresolved question; exploratory output is evidence or a proposal, not implementation approval. Do not create a full roster of roles by default or permit recursive delegation unless explicitly authorized.

Read [Assignments and Acceptance](references/assignments-and-acceptance.md) when dispatching or handing off work. Each assignment needs a bounded outcome, source baseline, workspace, scope, validation expectations, resource allowance, report destination, intermediate handoff, and terminal condition.

Prefer isolated writable checkouts for concurrent changes. Isolation does not separate shared machine resources, ports, Git references, or external services. Avoid concurrent ownership of the same writable branch. Preserve unrelated changes.

## 4. Coordinate by actionable events

Workers report blockers, review readiness, review findings, final verification, and resource release through the confirmed mechanism. Record evidence durably before notification. Do not send acknowledgments that unnecessarily restart an idle worker.

A delivered message, a completed turn, and a completed responsibility are different facts. Review readiness does not release ownership of ongoing verification. Assign exactly one owner to each CI run or comparable external operation until its final result or an explicit handoff is accepted.

If wakeup support is established, the coordinator should yield after dispatch and resume on callbacks. Otherwise use the confirmed live-parent waiting arrangement. Do not pretend that ending a session will preserve work or allow callbacks when the platform cannot do so.

Low-cost, nonconflicting checks are autonomous. Coordinate heavy or conflicting work by actual load, not command names. Grant a bounded validation loop covering setup, execution, local corrections, and cleanup rather than approving each command. Count cumulative retries and setup costs. A timeout does not prove resources were released; verify owned processes and outputs before reallocating them.

Preserve failures. Repeating an unchanged failing operation is not progress; require new evidence, a corrected input, or a justified bounded retry. Distinguish product defects, test defects, environment failures, and missing evidence before assigning a fix. Revisit the approach when scaffolding or coordination becomes more expensive than the outcome warrants.

## 5. Review, integrate, and finish

Use an independent reviewer for substantive changes. Independence means not authoring the change, not necessarily opening a new session every time. Reuse a reviewer for revisions; add another only for a concrete uncovered risk. Context contamination, repeated handoff failures, or a different work domain can justify a fresh worker with a concise handoff.

Route required findings back to the implementer, then return the corrected version to review. Separate required fixes from optional preferences. Match re-review and testing to the actual delta, preserving valid evidence for unchanged work without claiming it ran on a different version.

Before integration, reconcile the exact revision, independent review coverage, required checks, artifacts, unresolved findings, and authorization. Follow the repository's integration policy; protect against the reviewed revision changing underneath the action. Do not treat a green check or one merged subtask as completion of the whole outcome.

Report meaningful milestones, blockers, changed plans, and requested status rather than every internal message. Estimate progress against acceptance outcomes, account for new scope separately, and show remaining uncertainty instead of using task or commit counts as a completion percentage.

At completion, verify the agreed integrated outcome, identify any explicitly deferred work, produce a concise final handoff, mark the run complete, and stop only the monitors owned by this run. Retain the audit record according to the agreed retention policy; do not leave a monitor capable of reviving finished work.
