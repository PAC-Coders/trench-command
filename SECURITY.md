# Security Policy

We take security seriously and appreciate responsible disclosures from the community.

## Reporting a Vulnerability

Please **do not file public GitHub issues** for security problems.

- Email: paccoders@proton.me

Include:
- Affected version/commit/branch
- Reproduction steps or PoC
- Impact assessment (e.g., RCE, info leak)
- Any logs, screenshots, or crash output

We prefer reports in English and plaintext/Markdown. If needed, you can encrypt with our PGP key.

## Our Commitment & Timeline

- **Acknowledgment:** within 2 business days  
- **Initial triage:** within 5 business days  
- **Fix ETA:** shared after triage (varies by severity)  
- **Disclosure:** coordinated with you once a patch is available and users have had time to update

We’re happy to credit reporters (with consent) in release notes. CVEs may be requested for applicable issues.

## Scope

In scope:
- This repository’s code and CI/CD workflows
- Default configuration and documented features
- Public endpoints/services we operate (if any) related to this project

Out of scope (examples):
- Social engineering, physical attacks
- DoS/volumetric attacks or automated scans without impact
- Vulnerabilities in third-party services or dependencies (please report upstream)

If unsure, email us and we’ll advise.

## Safe Harbor

We support good-faith security research. We will not initiate legal action for:
- Testing that respects privacy and does not degrade service
- Making a reasonable effort to avoid accessing, modifying, or destroying data
- Reporting promptly with details and refraining from public disclosure until a fix is available

## Fixes & Updates

Security fixes are shipped via normal releases. Check release notes for:
- CVE IDs (when applicable)
- Impact & severity (we loosely align with CVSS)
- Upgrade and mitigation guidance
