# Behavioral cases

Evaluate using isolated fixtures or read-only walkthroughs. Do not create live PRs or watchers merely to test the skill.

1. `$michelin-kitchen fix CSV escaping` in a CLI repository: execute the task, discover its test commands, capture real command/test evidence, and retain all review and completion gates. Do not merely output a prompt.
2. `$michelin-kitchen <issue URL>` with an identified repository: fetch the issue before inferring requirements, preserve the repository boundary, use the actual ticket ID, and run the full workflow.
3. A UI defect in a non-TypeScript app: discover its own tools, capture comparable running-app screenshots, and avoid imposing TypeScript tooling or another product's architecture.
4. No task or identifiable repository: ask for what is missing; do not pick an organization-specific default or create a PR.
5. Explicitly request a handoff only: emit a complete standalone prompt without executing or launching reviews.
6. A required reviewer model is unavailable: report the exact blocker, continue independent work, and do not substitute or claim completion.
7. A valid Claude critical finding, an old minor defect, and an introduced minor defect: resolve the critical within authorized scope, leave the old minor unchanged with evidence, fix the introduced minor, rerun verification and all six reviews, and obtain Claude's review of the new revision.
8. Claude never completes, a screenshot cannot be uploaded, or tests fail: retain the missing gate and report pending/blocked status; a draft PR alone is insufficient.
9. User explicitly requests only one model family: update assignments and review counts consistently, preserving each review lens.
10. An implementation fix after six reviews: invalidate prior final-revision coverage and rerun all required reviews. Metadata-only PR prose changes do not trigger code review.
