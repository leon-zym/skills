# Assignments, Reviews, and Acceptance

Read this when creating an assignment, replacing a worker, or integrating a reviewed result. Templates are prompts for useful information, not mandatory ceremony for every small task.

## Assignment brief

Provide a concise brief containing:

- **Identity:** run, task, attempt, role, report destination, and canonical recovery entry point.
- **Outcome:** concrete problem, required result, acceptance evidence, exclusions, and dependencies.
- **Workspace:** source baseline, checkout/branch, writable scope, and shared resources or outputs to avoid.
- **Configuration:** confirmed worker model/reasoning settings or explicit inherited/unconfigurable settings; do not silently choose an alternative.
- **Authority and cost:** permitted edits and external actions, autonomous lightweight checks, heavy-resource allowance, retry/stop conditions, and cleanup ownership.
- **Handoffs:** intermediate events, terminal condition, and whether verification or other responsibilities remain after review readiness.

Workers first verify the assignment, source baseline, workspace, and return route. A checkout created from a default branch is not proof that it matches the requested baseline. Resolve discrepancies without destroying existing work.

For exploratory assignments, ask a bounded question and specify the evidence or recommendation required. Do not authorize implementation implicitly. For implementation, make expected behavior and acceptance concrete enough that a reviewer can assess the result independently.

## Responsibility and resource ledger

Every outstanding operation has one named owner, even when several people consume its evidence. An implementer commonly owns natural CI through completion, but another explicit arrangement is valid. Reviewing an artifact is not the same as taking over monitoring its production.

Resource allowances specify the resource and collision domain, concurrency, cumulative cost limit, stop condition, and cleanup responsibility. Tailor them to the environment instead of hardcoding one machine-wide slot or universal timeouts. A small isolated test is not automatically a heavy operation because of its command name.

A worker that cannot finish writes the last valid checkpoint, identifies any still-running work, and requests a transfer. The coordinator accepts or reassigns the remaining responsibility. Until then, mark it unresolved rather than claiming that a successful notification completed the operation.

## Independent review loop

Review the resolved change and its acceptance contract, including relevant callers and upper-layer behavior when risk warrants it. A design review does not replace implementation review. A clean review with no findings is a valid outcome.

Report required findings with the trigger, consequence, affected revision, and evidence. Distinguish unresolved hypotheses from demonstrated defects. Optional improvements must not silently expand the acceptance bar or block delivery by preference alone.

Route findings through the coordinator. Return fixes to the original implementer and revisions to the reviewer who owns that review scope. Keep a compact finding list with status and resolution evidence instead of reproducing the conversation. Separate a newly discovered product defect from a test defect or unrelated feature request; choose a separate work item only when independent ownership or acceptance makes it useful.

For a revised change, assess what the delta invalidates. Reuse earlier evidence where code, environment assumptions, and relevant behavior remain unchanged; state the provenance honestly. Do not rerun every test or reopen every review by default. Additional reviewers need a specific uncovered risk, not merely a desire for more opinions.

## Integration gate

Before integrating, reconcile:

- The reviewed source baseline and exact candidate revision, including all later deltas.
- Independent review coverage and resolution of required findings.
- Required verification and artifact validity at that revision, or explicitly justified unchanged-content evidence.
- Compatibility and integration with current upstream work, authorization, and repository policy.

Use the platform's normal protection against integrating a different revision than the one accepted. Do not prescribe one merge strategy across repositories. Synchronize near an actual integration window when possible, rather than rebuilding and re-reviewing after every unrelated upstream change.

Treat an invalid measurement, unavailable artifact, incompatible environment, and performance regression as different results. A setup failure cannot certify correctness; an incompatible benchmark cannot certify a budget pass. Do not remove failed samples or silently adjust acceptance to obtain a green result. Preserve enough evidence to explain infrastructure retries and their bounded rationale.

## Keep coordination proportional

Reuse a worker for coherent same-domain work while its context remains useful. Start a new worker when stale assumptions, repeated handoff mistakes, or accumulated history undermine reliability; pass current facts and unresolved work, not the entire transcript.

When effort grows, identify its cause: necessary product work, missing test infrastructure, invalid assumptions, or coordination overhead. Prefer a smaller solution that still meets the outcome. Escalate major scope or direction changes to the user rather than optimizing an obsolete plan indefinitely.

An outcome is complete only when its own acceptance criteria are met or the user explicitly accepts a revised boundary. Report unresolved or deferred items as such. Final delivery should let the user understand what changed, how it was checked, remaining limitations, and where to inspect the audit trail without reading every worker conversation.
