# Contenta Converter plugin

Use **Contenta Converter** from your AI agent on your Windows PC: batch image conversion, resizing, effects, metadata, PDF albums and slideshows for 100+ image formats. The agent calls the app's tools
on files on your computer; nothing is uploaded to the model provider or to ContentaSoft to do the work. It works
with any agent that runs local MCP servers: Cursor, Claude Code, Codex, VS Code, Windsurf and others.

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

- **MCP server** `contenta-converter` with the tools `convert_image`, `batch_convert`, `ai_transform`, `create_pdf_album`, `create_slideshow`, `merge_pdfs`, `detect_format`, `list_effects`, `read_metadata`, `write_metadata`. Each tool
  says whether it only reads files, writes new files, may overwrite files, or uses the internet.
- **Skill** `contenta-image-processing`: how and when the agent should use those tools and the `contenta` command line.

## What runs and what is sent

- As a Claude plugin it runs `server/launch.cmd` from the plugin folder, which looks for `contenta.exe` in the app's
  install folder (`%LOCALAPPDATA%\Programs\ContentaConverter`), on your `PATH` or in `Program Files`, and runs
  `contenta serve`. Nothing is downloaded. If the app is missing, the bundled Node launcher (`server/index.js`, the same
  bytes as the npm package `@contentasoft/contenta-converter-mcp`, MIT, no dependencies; source: https://github.com/contentasoftware/mcp-launcher)
  or, without Node.js, the Windows PowerShell stub `server/stub.ps1` serves one tool, `get_started`. Neither sends
  anything over the network.
- The skill may only run the app's own command-line tool (`allowed-tools: Bash(contenta:*)`).
- The app processes local files only. It sends anonymous usage telemetry (which tools ran, which MCP client
  connected, trial state) to ContentaSoft; turn it off in the app's settings. Privacy policy: https://www.contenta-converter.com/privacy.php
- ai_transform sends the image to Google Gemini with your own Gemini API key.
- The free trial has no end date: the first 10 outputs per PC come out clean, later ones carry a trial watermark (PDF albums, merged PDFs and slideshows are always marked on the trial). `contenta status` shows how many clean outputs are left; a batch spends one per file. Nothing stops working; a licence removes the limits.

## License

This plugin and the launcher are MIT-licensed (see LICENSE). Contenta Converter itself is commercial software by
ContentaSoft AB.
