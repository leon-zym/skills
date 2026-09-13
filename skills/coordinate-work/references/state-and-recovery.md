# State, Audit, and Recovery

Read this before the first dispatch and when another coordinator takes over. Runtime documents use the user's language. Filenames and stable identifiers may remain language-neutral.

## Stable discovery, local storage

Use `.agent-work/INDEX.md` at the primary workspace root as the default discovery entry point. Honor an established equivalent instead of creating a second system. Keep it in a writable workspace even when there is no Git repository. All workers, including isolated checkouts, receive the absolute path to the same primary entry point; do not create separate competing run indexes in each worktree.

Before writing under Git, check whether the destination is already tracked. Use the repository's local exclusion facility for new process files and verify they remain untracked and excluded. Do not alter tracked ignore rules or overwrite tracked files merely to establish coordination storage. Local exclusions are a guard against accidental commits, not a security boundary; check staged changes before committing. Without Git, no exclusion setup is needed.

Only when there is no writable workspace, use a named directory under the operating system's standard temporary location. Give the user its exact path and include it in every assignment. Explain that an agent without the workspace or that locator cannot automatically discover it. Never promise recovery after the only state copy is removed.

Keep bulky disposable logs and intermediate outputs in a run-owned temporary directory. Evidence necessary for acceptance or recovery belongs in the workspace's untracked run directory or an explicitly designated durable external location. Record artifact expiry and preservation requirements. A pointer to a deleted temporary file is not preserved evidence; a local backup does not automatically replace an external artifact required by the delivery contract.

## Minimal layout and ownership

Create only the files a run actually needs:

```text
.agent-work/
  INDEX.md
  runs/<run-id>/
    current.md
    tasks/<task-id>.md
    decisions.md
    archive/<phase-id>.md
```

The index lists active runs and a compact completed-run locator. For many completed runs, move their entries to a linked historical index; do not scan or load it during normal recovery.

The coordinator alone updates the index and `current.md`. Each worker owns its assignment record, with coordinator-authored assignment terms separated from worker-reported execution facts. If the host cannot safely share files, workers keep equivalent local handoff records and send their contents or accessible locations; the coordinator incorporates them into canonical state. Avoid multiple writers overwriting one file.

Use replacement writes for current snapshots where supported. Preserve the previous valid snapshot until its replacement is complete. No database, bespoke event bus, or append-only transcript is required.

### `current.md`: the bounded recovery snapshot

Include only:

- Outcome, acceptance criteria or their authoritative locator, exclusions, and current phase.
- Run status, coordinator identity, state revision, last meaningful update, and confirmed authority/configuration.
- Active assignments with owner, attempt, work version, status, evidence pointer, and next action.
- Outstanding CI or external operations and exactly one owner for each.
- Held resources, known processes/output locations, unresolved decisions, and remaining acceptance work.

Use statuses such as running, pausing, paused, blocked, and completed only when supported by observed facts. A scheduled deadline passing does not prove a worker has stopped.

### Assignment record: enough to take over

Preserve the current assignment terms and latest execution checkpoint: base and current revision, branch/checkouts, uncommitted work ownership, run/process identities, output locations, commands or operation descriptions needed to inspect existing work, last completed step, failures, remaining responsibilities, and the next safe action.

In a non-Git workspace, identify the relevant source state with a named snapshot or a manifest of scoped relative paths and content digests. Use the same approach for uncommitted changes not identified by a commit. Associate review and verification with that state; a timestamp or "current workspace" alone is insufficient. Keep snapshots scoped, protect sensitive content, and do not copy an entire workspace by default. Recheck the affected content before accepting old evidence or applying an integration.

Before a consequential external action or long-running operation, record its intent, expected identity, ownership, and recovery check. After it starts, record its actual identity promptly; after completion, record the result and evidence. If interrupted between action and receipt, reconciliation must resolve whether it occurred before attempting it again.

Do not record secrets, credentials, private user content, or full environment dumps. Redact evidence before sharing it externally.

### Decisions and archives

Record only decisions, scope changes, meaningful failures, and resolutions that alter what happens next. Link detailed evidence rather than copying command output or message history. Issues and review systems retain delivery discussion where they are already the agreed authority; do not duplicate them into another running narrative.

Use size budgets as maintenance triggers, not truncation rules. A useful starting budget is about 1,000 words for current state, 500 words for an assignment's latest snapshot, and 1,500 words for the live decision log. Adapt these to the work, but do not let them grow without review.

At a phase boundary or when a budget is exceeded, move settled history to a linked archive and replace it with a brief outcome and evidence locator. Never archive away an unresolved blocker, current authorization, active ownership, or the only copy of a necessary recovery fact. Do not silently delete raw evidence to meet a word budget. Agree on retention at closeout; large archives may remain on disk without being loaded into context.

## Recovery procedure

1. Locate the workspace index, then read only the relevant current snapshot and active assignment records. Open archived evidence only for a specific unresolved question.
2. Establish which coordinator is authoritative. If another may still be active, reconcile ownership before dispatching competing work. Record a new coordinator identity/state revision and supersede old attempts where necessary; a revision number alone does not stop an old process.
3. Check the user's current instruction and recorded run status. Do not resume explicitly paused or completed work merely because a callback or timer arrived. For interrupted running work, continue within existing authorization after reconciling state.
4. Inspect actual work versions, uncommitted changes, workers, processes, CI, and artifacts. Treat recorded status as a lead, not proof that an operation is still running or has completed. Do not restart a command or release a resource until its ownership and state are resolved.
5. Adopt completed evidence, recover an outstanding result, resume the original worker, or assign a replacement with a concise handoff. Do not rerun completed expensive work just to recreate conversational context.
6. Update canonical state and return to the confirmed communication loop. Missing necessary evidence means unverified work, not inferred success.

For a planned pause, stop new dispatch and integration, request safe worker checkpoints, reconcile active external work, and record what actually stopped. Some external work may remain running; name its owner and recovery action instead of declaring a false clean pause.
