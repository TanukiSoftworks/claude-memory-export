# Claude Context Export

A PowerShell script that consolidates all [Claude Code](https://claude.ai/code) persistent memory files across all your projects into a single Markdown file, ready to paste or attach to a Claude app conversation.

## Requirements

- Windows with PowerShell 5.1+
- Claude Code CLI installed (memory lives at `%USERPROFILE%\.claude\projects\`)

## Usage

Place `export_context.ps1` inside your `%USERPROFILE%\.claude\` folder, then run:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.claude\export_context.ps1"
```

This generates `context_export.md` in the same directory.

## What it exports

For every project that has a `memory/` folder, it includes:
- `MEMORY.md` — the index
- All individual memory files (`user_*.md`, `project_*.md`, `feedback_*.md`, etc.)

Projects without a `memory/` folder are skipped.

## How to use the output

1. Run the script
2. Open `context_export.md`
3. Attach it to a new Claude conversation (claude.ai or the desktop app)
4. Claude will have full context of your past sessions across all projects

## Notes

- `context_export.md` is regenerated every run — safe to re-run anytime
- Add `context_export.md` to `.gitignore` if you fork this, as it may contain project details you don't want public
