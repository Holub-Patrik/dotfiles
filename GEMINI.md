# Gemini CLI Project Mandates

This file contains foundational instructions for Gemini CLI when working within this repository.

## Documentation & Context
- **Primary Knowledge Base:** Always check and prioritize information found in the `.gemini_docs/` directory. These files contain the specific architectural patterns, style guides, and project histories for this workspace.
- **Session Initialization:** At the start of a task, verify current standards in `.gemini_docs/OVERVIEW.md` and relevant project files.

## Engineering Standards
- **Hyprland:** Use modern `windowrule` syntax (match:class, etc.). Avoid `windowrulev2`.
- **Aesthetics:** Adhere to the OLED-first philosophy (true black backgrounds, high contrast).
- **Scripts:** New helper scripts should be placed in `hypr/scripts/` (for WM tasks) or `~/.local/bin/` (for general tasks) and documented in `.gemini_docs/projects/scripts.md`.
