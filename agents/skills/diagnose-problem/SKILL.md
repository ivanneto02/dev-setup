---
name: diagnose-problem
description: Diagnose a bug, error, codebase behavior, or broken workflow when asked "I need help diagnosing ...", "why does X happen?", or "do you know why Y happens?" Use for cause-finding and possible resolution, not a request to implement a fix or explain a known configuration setting.
---

# Diagnose a problem

1. Pin down the symptom, expected behavior, affected system, and when it started. Reproduce or inspect logs, errors, code paths, and recent changes when access permits. Do not assume the local checkout or machine is the affected one.
2. Search relevant evidence across the available sources: local code and logs; related GitHub repositories, issues, PRs, and commits with `gh`; and relevant Notion docs and Slack channels or chats through available authorized tools. Follow links across sources when they help identify the cause. Keep searches scoped to the reported problem; do not claim to have checked a source you could not access.
3. Compare plausible causes against observed evidence. Distinguish a confirmed cause from a leading hypothesis. If evidence is missing, identify the smallest check that would distinguish the likely causes; ask only for information that materially changes the diagnosis.
4. Answer briefly: likely diagnosis and supporting evidence, where to look (specific repository, file, workflow step, issue, or document), and a concrete possible resolution or next diagnostic check. Link or cite the most useful sources. Say what remains unverified. Do not propose a fix as proven before testing it.
5. Diagnose rather than change production systems or publish content. If the user also asks for a fix, follow the applicable implementation workflow and authorization rules.
