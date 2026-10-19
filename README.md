# Contenta Converter plugin

Use **Contenta Converter** from your AI agent on your Windows PC: batch image conversion, resizing, effects, metadata, PDF albums and slideshows for 100+ image formats. You ask in plain words and the
agent does the work on files on your computer. It works with any agent that runs local MCP servers: Cursor,
Claude Code, Codex, VS Code, Windsurf and others.

## Ask your agent

- "Make every photo in my Products folder a 2000 x 2000 square on a white background for Amazon."
- "Convert the HEIC photos from my iPhone to JPG so I can email them."
- "Shrink these listing photos to under 500 KB each."

Contenta Converter also works without an agent: open it from the Start menu and work in its own window.

## Price and trial

- $129, a one-time purchase. No subscription needed. Prices: https://www.contenta-converter.com/buy.php
- The free trial has no end date: the first 10 outputs per PC come out clean, later ones carry a trial watermark (PDF albums, merged PDFs and slideshows are always marked on the trial). `contenta status` shows how many clean outputs are left; a batch spends one per file. Nothing stops working; a licence removes the limits.

## Install

**Claude Code** (Windows): two commands, typed inside Claude Code. This repository is its own one-plugin
marketplace, named after the repository:

```
/plugin marketplace add contentasoftware/contenta-converter-plugin
/plugin install contenta-converter@contenta-converter-plugin
```

From a terminal the same is `claude plugin marketplace add contentasoftware/contenta-converter-plugin` and `claude plugin install contenta-converter@contenta-converter-plugin`.
Cowork and the Claude.ai directory: install **Contenta Converter** from the directory once it is listed.

**Cursor, Claude Desktop, VS Code, Codex and other MCP clients** (`mcpServers` JSON):
`"contenta-converter": { "command": "cmd", "args": ["/c", "npx", "-y", "@contentasoft/contenta-converter-mcp"] }` (needs Node.js 18+), or,
once the app is installed, `"contenta-converter": { "command": "contenta", "args": ["serve"] }` with no Node.js at all.
Client-by-client instructions: https://www.npmjs.com/package/@contentasoft/contenta-converter-mcp

## What you need

- Windows 10 or 11 with **Contenta Converter** installed. It has a free trial: https://www.contenta-converter.com/download.php
  (if it is not installed yet, the `get_started` tool gives the agent the download link and the steps).
- Nothing else for the Claude Code plugin: its launcher is a Windows batch file (`server/launch.cmd`) that starts the
  app's own MCP server. Node.js is not required; only the `npx` route for other clients needs it.
- An agent that runs on that computer. Browser chat apps cannot start local programs, so they cannot use these
  tools.

## What is included

- **MCP server** `contenta-converter` with the tools `convert_image`, `batch_convert`, `ai_transform`, `create_pdf_album`, `create_slideshow`, `merge_pdfs`, `detect_format`, `get_file_info`, `list_formats`, `list_effects`, `read_metadata`, `write_metadata`, `get_license_status`. Each tool
  says whether it only reads files, writes new files, may overwrite files, or uses the internet.
- **Skill** `contenta-image-processing`: how and when the agent should use those tools and the `contenta` command line.

## For developers

- Windows 10 and 11, 64-bit only. There is no macOS or Linux version.
- `contenta` never waits for input or shows a dialog, so it runs unattended from Task Scheduler or a script.
  To convert each new photo saved to a folder while you are signed in, start `watch` at logon; it runs until you sign out or close its window:

  ```
  schtasks /create /tn "Contenta Converter watch" /sc onlogon /tr "contenta watch D:\Inbox -o D:\Ready --format webp"
  ```
- Every command takes `--json` and prints one JSON object on stdout (logs go to stderr): `success`, `exitCode`, `error`, `warnings`, `errors` and `outputs`, plus the trial fields when they apply. Add `--progress` for one `{"type":"progress",...}` line per finished file before that object.
- Exit codes: 0 done · 1 unexpected error · 2 invalid arguments · 3 input not found or unreadable · 4 some items failed (the others are written) · 5 nothing succeeded · 6 the licence or trial refused the run · 130 cancelled. The four ContentaSoft command lines share this table.
- The skill (`skills/contenta-image-processing/SKILL.md`) tells the agent which commands to use.

## Full CLI and MCP reference

Every `contenta` command, option and exit code, the JSON output and every MCP tool with its parameters:

- Command line: https://github.com/brunojanvier77/ContentaSoft/blob/main/contenta-converter/cli.md
- MCP server: https://github.com/brunojanvier77/ContentaSoft/blob/main/contenta-converter/mcp-server.md

## Privacy

- Converting, resizing, effects, metadata, PDF albums and slideshows run on this PC and need no internet connection.
- One tool uses the internet: `ai_transform` sends the image to Google Gemini on your own Gemini API key. The skill tells the agent to ask you first.
- The app sends usage statistics (which tools ran, which MCP client connected, trial state) and crash reports to
  ContentaSoft, tagged with a hashed machine ID. They never contain your files; a crash report can contain a file
  name, but folder paths are removed. To turn them off, open the app and
  go to Settings, Privacy: Send usage statistics and crash reports. The same switch covers the command line and the
  MCP server. On a PC where nobody opens the app, set `"allowUsageMetrics": false` in `%APPDATA%\ContentaConverter\settings.json`.
- Privacy policy, with the full list of what is sent: https://www.contenta-converter.com/privacy.php

## What runs

- As a Claude plugin it runs `server/launch.cmd` from the plugin folder, which looks for `contenta.exe` in the app's
  install folder (`%LOCALAPPDATA%\Programs\ContentaConverter`), on your `PATH` or in `Program Files`, and runs
  `contenta serve`. Nothing is downloaded. If the app is missing, the bundled Node launcher (`server/index.js`, the same
  bytes as the npm package `@contentasoft/contenta-converter-mcp`, MIT, no dependencies; source: https://github.com/contentasoftware/mcp-launcher)
  or, without Node.js, the Windows PowerShell stub `server/stub.ps1` serves one tool, `get_started`. Neither sends
  anything over the network.
- While Claude Code uses the skill, it can run the app's own command-line tool in Bash or PowerShell without asking
  (`allowed-tools: Bash(contenta *) PowerShell(contenta *) Bash(contenta.exe *) PowerShell(contenta.exe *)`). That permission ends when you send your next message. Other commands, and the
  plugin's MCP tools, follow your own Claude Code permission settings.

## License

This plugin and the launcher are MIT-licensed (see LICENSE). Contenta Converter itself is commercial software by
ContentaSoft AB.
