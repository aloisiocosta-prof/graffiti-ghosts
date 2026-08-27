# GitHub Project Capability Matrix — `game-graffiti-ghosts`

## Purpose

This document maps the requested Project capabilities to the current GitHub CLI and Projects API surface available in this environment.[1] [2]

The current repository access is `ADMIN`, but the persisted CLI credential still cannot query Projects and returns `Resource not accessible by integration`; therefore, capabilities marked `Blocked` are documented with safe alternatives rather than falsely reported as configured.[3]

## Capability matrix

| Requested capability | Native GitHub Project capability | `gh` CLI support | Current environment | Safe alternative |
|---|---|---|---|---|
| Create Project | `gh project create` | Direct | Blocked by Projects scope | Create in GitHub UI, then record owner/number/URL |
| List/view Project | `gh project list`, `view` | Direct | Blocked by Projects scope | GitHub Project URL and manual export |
| Add Issues/PRs | `gh project item-add` | Direct | Blocked by Projects scope | Paste Issue/PR URLs in Project or add from repository UI |
| Remove/archive items | `item-delete`, `item-archive` | Direct | Blocked by Projects scope | Project UI archive/remove |
| Edit item fields | `item-edit` | Direct | Blocked by Projects scope | Edit item fields in table/board UI |
| Create custom fields | `field-create` | Direct | Blocked by Projects scope | Project Settings → Fields |
| Delete custom fields | `field-delete` | Direct | Blocked by Projects scope | Project Settings → Fields |
| List fields/options | `field-list` | Direct | Blocked by Projects scope | Project Settings → Fields or GraphQL query |
| Status | Built-in single-select field | `item-edit --field Status --value ...` | Blocked by Projects scope | Use Status field in Project UI |
| Assignees | Item/repository property and Project field | `item-edit` can edit Project field; `gh issue edit`/`gh pr edit` edits item | Repository CLI available; Project field blocked | Set assignee on Issue/PR, then Project displays it |
| Labels | Issue/PR metadata and Project field | `gh issue edit --add-label`, `gh pr edit --add-label` | Repository CLI available | Apply labels to source Issue/PR; use Project Labels field |
| Milestone | Issue/PR metadata | `gh issue edit --milestone`, `gh pr edit --milestone` | Repository CLI available | Apply milestone to source Issue/PR; Project displays it |
| Parent Issue | Issue relationship | REST/GraphQL relation APIs may be available; no stable simple `gh project` subcommand | Requires API validation | Encode `Parent: #N` in body and use sub-issues UI/API |
| Sub-issues progress | GitHub sub-issues relationship/progress | No dedicated stable `gh project` command | Requires API/UI | Use parent issue → Add sub-issue; display progress in Project when available |
| Linked Pull Requests | GitHub Issue↔PR relationship | `gh pr create --issue`, closing keywords and API links | Repository CLI available | Link PR with `Fixes #N`, `Closes #N`, or PR sidebar linked issue |
| Pull request merged | Built-in workflow sets Status to Done | Built-in Project workflow; no general `gh project workflow` command in stable CLI | Requires Project access/UI | Enable workflow in Project UI; fallback GitHub Action updates source issue/status where API allows |
| Pull request linked to issue | GitHub timeline relationship | PR body closing/reference keywords; `gh pr edit` | Repository CLI available | Add `Fixes #N` or `Related to #N` to PR body |
| Code review approved | Built-in workflow can set status based on approval | Workflow configuration is primarily UI/API | Requires Project access/UI | GitHub Action listens to `pull_request_review` and updates labels/status proxy |
| Code changes requested | Review event | Workflow configuration is primarily UI/API | Requires Project access/UI | GitHub Action listens to `pull_request_review` and applies `changes-requested` label/status proxy |
| Item added to project | Built-in workflow | Project UI workflow | Requires Project access/UI | GitHub Action records `project-item-added` label/comment or uses GraphQL with `project` scope |
| Item closed | Built-in workflow | Project UI workflow | Requires Project access/UI | Repository `issues` event Action applies `status: done` label and closes linked tracking Issue when appropriate |
| Item reopened | Built-in workflow/event | Project UI workflow | Requires Project access/UI | `issues.reopened` Action applies `status: reopened` label and comments the Project item URL |
| Auto-add to project | Built-in workflow | Project UI workflow | Requires Project access/UI | GitHub Action on `issues`/`pull_request` calls `gh project item-add` with a Project-scoped secret |
| Auto-add sub-issues to project | Relationship plus workflow | No stable direct `gh project` command | Requires Project UI/API | Action on sub-issue creation discovers parent and adds the child URL to Project |
| Auto-close issue | Built-in workflow or repository Action | Project UI workflow; Action is reliable fallback | Requires Project access/UI | Action closes issue when configured status/label condition is met |
| Auto-archive items | Built-in workflow | Project UI workflow | Requires Project access/UI | Scheduled Action archives via GraphQL or produces an archive report for manual execution |
| Item reopened | Built-in workflow/event | Project UI workflow | Requires Project access/UI | `issues.reopened`/`pull_request.reopened` Action restores `status: todo` or `status: reopened` label |
| Views: table/board/roadmap | Project UI capability | Not fully managed by stable `gh project` commands | Requires Project access/UI | Configure views manually; keep a repository-generated TSV/CSV mirror |
| Filters/grouping/sorting | Project view capability | Not fully managed by stable `gh project` commands | Requires Project access/UI | Store filter definitions in this document and configure UI manually |
| Draft issues | `gh project item-create` | Direct | Blocked by Projects scope | Create draft in UI or regular Issue in repository |
| Project link/unlink repository | `gh project link/unlink` | Direct | Blocked by Projects scope | Project Settings → Manage access / linked repositories |
| Project close/delete | `gh project close/delete` | Direct | Blocked by Projects scope | UI action with explicit confirmation |

## Requested field model

The canonical Project item model should expose the following fields or source metadata:

| Field | Type | Values/meaning | Source |
|---|---|---|---|
| `Assignees` | Built-in people | Responsible maintainer/agent | Issue/PR |
| `Status` | Single select | `Todo`, `In Progress`, `In Review`, `Blocked`, `Done`, `Archived` | Project |
| `Labels` | Built-in or multi-select | `type:*`, `area:*`, `priority:*`, `status:*`, `platform:*` | Issue/PR + Project |
| `Milestone` | Built-in metadata | `MVP`, `Web/WasmGC Hardening`, `Process Governance` | Issue/PR |
| `Parent issue` | Relationship/text fallback | Parent Issue number | Issue relationship |
| `Sub-issues progress` | Relationship/progress | Completed/total child issues | Parent Issue |
| `Linked pull requests` | Relationship | Open/merged PR URLs | GitHub timeline |
| `Review state` | Single select/text fallback | `Review required`, `Changes requested`, `Approved`, `Not required` | PR reviews |
| `Platform` | Multi-select | `Android`, `Web`, `WasmGC`, `Cloudflare` | Project |
| `Priority` | Single select | `P0`, `P1`, `P2`, `P3` | Project |
| `Spec reference` | Text | GDD/spec path and requirement ID | Project |

## Recommended status transitions

```text
Todo
  → In Progress
  → In Review
  → Approved
  → Done

In Progress → Blocked → In Progress
Done → Reopened → In Progress
In Review → Changes requested → In Progress
```

`Review required` is not a final status; it is a review state that should be visible separately from implementation status.[2]

## Repository-side fallback automation

When Project API access is available to a GitHub Actions secret, the repository can provide deterministic fallbacks for the requested automations without putting a token in source control:

```yaml
on:
  issues:
    types: [opened, closed, reopened]
  pull_request:
    types: [opened, closed, reopened, review_requested]
  pull_request_review:
    types: [submitted]
```

The workflow should use the least-privilege `project` token stored as an Actions secret, add or update the relevant item, and write an audit comment or artifact containing event, item URL, previous state, new state, actor, and timestamp.[2] [4]

The fallback must never approve a Pull Request, bypass branch protection, or merge code; approval remains the responsibility of a different reviewer with write access.[5]

## Current PR review result

The only open PR identified with `REVIEW_REQUIRED` is [PR #26](https://github.com/aloisiocosta-prof/graffiti-ghosts/pull/26). Historical merged PRs with the same GraphQL review indicator are #5–#16; they are not actionable review blockers because they are already merged.[3]

## Access prerequisite

The CLI requires the `project` scope for Project mutations and the `read:project` scope for read-only queries.[2] The current environment has repository `ADMIN` permission, but the persisted credential still fails the Project query; therefore, no Project mutation was executed in this run.[3]

## References

[1]: https://cli.github.com/manual/gh_project "GitHub CLI — gh project"
[2]: https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project/using-the-api-to-manage-projects "GitHub Docs — Using the API to manage Projects"
[3]: https://github.com/aloisiocosta-prof/graffiti-ghosts/pulls "Graffiti Ghosts Pull Requests"
[4]: https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project/automating-projects-using-actions "GitHub Docs — Automating Projects using Actions"
[5]: https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets "GitHub Docs — About rulesets and branch protection"
