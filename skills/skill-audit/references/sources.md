# Starting bibliography

Initial review: 2026-09-14. These are seed sources, not a permanently current model ranking. Refresh applicable entries during each audit. Summaries below are brief paraphrases; proposed audit applications are explicitly distinguished from the source's claims.

## OpenAI

### OAI-SKILLS — Rethinking skills and prompts for GPT-6 Astra

- URL: <https://developers.openai.com/blog/rethinking-skills-and-prompts-for-gpt-6-astra>
- Published: 2026-09-11. Accessed: 2026-09-14. Type: direct engineering guidance.
- Scope: GPT-6 Astra and Codex skill/repository instructions; the article explicitly notes differences across models.
- Locators: “Better skills,” “Up-to-date AGENTS.md,” “Decision boundaries,” “Persistence.”
- Guidance: Make descriptions selective and concise; disclose supporting detail when needed. Reconsider rigid recipes and unconditional document loading. Define completion and appropriately scoped autonomy. Instructions useful for older models can overconstrain Astra.
- Audit application: Inspect activation breadth, unnecessary reads, inherited workarounds, and premature stopping. Preserve explicit user requirements; do not use this post as permission to remove mandated checks or authorization boundaries.

### OAI-CARDS — Deployment safety

- URL: <https://deploymentsafety.openai.com/>
- Published: ongoing index. Accessed: 2026-09-14. Type: discovery only.
- Use: Locate the actual target model's card and updates. Read the card before deriving findings; the index alone does not support behavioral claims.

### OAI-ASTRA — GPT-6 Astra System Card

- URL: <https://deploymentsafety.openai.com/gpt-6-astra>
- Published: 2026-09-03. Accessed: 2026-09-14. Type: empirical observations.
- Scope: GPT-6 Astra, with comparison models and safeguard conditions varying by evaluation.
- Locators: §5.2 “Prompt Injection”; §8.2 “Obeying Restrictions”; §8.3.1 “Coding Deception”; §8.3.2 “Broken Search Tool.”
- Observation: The card examines indirect instruction attacks, boundary compliance, misleading completion claims, and acknowledgment of unavailable search. It explicitly limits extrapolation from individual evaluations to production behavior.
- Auditor inference: Test external-content handling, honest tool-failure reporting, and completion evidence where the skill has those affordances. Improved benchmark performance does not justify dropping permission boundaries or claiming immunity to injection.

## Anthropic

### ANT-SKILLS — Equipping agents for the real world with Agent Skills

- URL: <https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills>
- Published: 2025-10-16. Accessed: 2026-09-14. Type: direct engineering guidance.
- Scope: Agent Skills architecture; not a guarantee for every host implementation.
- Locators: “The anatomy of a skill,” “Skills and the context window.”
- Guidance: Skill metadata enables discovery; the body and additional files provide progressively loaded detail. References can keep scenario-specific material out of the entrypoint.
- Audit application: Check that optional references are reachable and explain when to read them. Avoid splitting a simple skill into unnecessary files.

### ANT-CONTEXT — Effective context engineering for AI agents

- URL: <https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents>
- Published: 2025-09-29. Accessed: 2026-09-14. Type: direct engineering guidance.
- Locators: “The anatomy of effective context,” “Context retrieval and agentic search.”
- Guidance: Use high-value context, clear instructions at an appropriate level of detail, representative examples, and retrieval when information becomes relevant. Avoid both brittle procedural detail and instructions too vague to guide decisions.
- Audit application: Evaluate the information value of each mandatory read and example, while retaining details the model cannot infer.

### ANT-EVALS — Demystifying evals for AI agents

- URL: <https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents>
- Published: 2026-01-09. Accessed: 2026-09-14. Type: direct evaluation guidance.
- Locator: “Going from zero to one: a roadmap to great evals for agents.”
- Guidance: Build evaluations from real tasks and failures, define clear outcomes, and account for variability across trials. One successful attempt and consistent success answer different questions.
- Audit application: Compare original and revised skills on matched tasks; keep resource savings separate from task success. A document check cannot establish model reliability.

### ANT-CARDS — Model system cards

- URL: <https://www.anthropic.com/system-cards>
- Published: ongoing index. Accessed: 2026-09-14. Type: discovery only.
- Use: Find the exact Claude model's card. At initial review it listed Claude Fable 5.1 and Mythos 5.1 together; access conditions still need to be checked separately.

### ANT-FABLE — System Card: Claude Fable 5.1 & Claude Mythos 5.1

- Canonical URL: <https://www.anthropic.com/claude-fable-5-1-mythos-5-1-system-card>
- Published: 2026-09-01. Accessed: 2026-09-14. Type: empirical observations.
- Retrieval: Official index link redirects to a PDF; initial browser retrieval exceeded its size limit. The official PDF was downloaded and relevant text extracted locally.
- Locators: Executive Summary, printed p. 2; §5.2 “Prompt injection risk within agentic systems,” printed pp. 81–82.
- Scope: The summary distinguishes generally available Fable from restricted Mythos. Section 5.2 specifically evaluates the final Fable 5.1 snapshot and discusses separate model and product safeguards.
- Observation: External content can carry instructions that redirect an agent. Evaluation conditions and additional protections vary, affecting interpretation of comparisons.
- Auditor inference: Preserve distinctions between model, host, and safeguard configuration. Where a skill reads external material, test that its content cannot authorize unrelated actions. Do not attribute these Fable results to Mythos just because they share a card.
