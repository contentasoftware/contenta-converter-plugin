# Contenta Converter plugin

Use **Contenta Converter** from your AI agent on your Windows PC: batch image conversion, resizing, effects, metadata, PDF albums and slideshows for 100+ image formats. The agent calls the app's tools
on files on your computer; nothing is uploaded to the model provider or to ContentaSoft to do the work. It works
with any agent that runs local MCP servers: Cursor, Claude Code, Codex, VS Code, Windsurf and others.

## Install

- **Cursor and other MCP clients** (`mcpServers` JSON): add
  `"contenta-converter": { "command": "npx", "args": ["-y", "@contentasoft/contenta-converter-mcp"] }`. Or install it from
  cursor.directory.
- **Claude Code / Cowork**: install this repository as a plugin. It runs the bundled launcher in `server/`.
- More clients and options: https://www.npmjs.com/package/@contentasoft/contenta-converter-mcp

## What you need

- Windows 10 or 11 with **Contenta Converter** installed. It has a free trial: https://www.contenta-converter.com/download.php
  (if it is not installed yet, the `get_started` tool gives the agent the download link and the steps).
- Node.js 18 or later, which runs the small launcher (MIT, no dependencies; the npm package `@contentasoft/contenta-converter-mcp`,
  also bundled here as `server/index.js`; source: https://github.com/contentasoftware/mcp-launcher). The
  launcher starts the app's own MCP server (`contenta serve`) and passes its messages through; it sends nothing
  over the network itself.
- An agent that runs on that computer. Browser chat apps cannot start local programs, so they cannot use these
  tools.

## What is included

- **MCP server** `contenta-converter` with the tools `convert_image`, `batch_convert`, `ai_transform`, `create_pdf_album`, `create_slideshow`, `merge_pdfs`, `detect_format`, `list_effects`, `read_metadata`, `write_metadata`. Each tool
  says whether it only reads files, writes new files, may overwrite files, or uses the internet.
- **Skill** `contenta-image-processing`: how and when the agent should use those tools.

## What runs and what is sent

- As a Claude plugin it runs `node server/index.js` from the plugin folder, so nothing is downloaded; through
  `npx` the same launcher comes from npm. The launcher looks for
  `contenta.exe` in the app's install folder (`%LOCALAPPDATA%\Programs\ContentaConverter`), on your `PATH`
  or in `Program Files`, and runs `contenta serve`. If the app is missing it serves one tool, `get_started`.
- The skill may only run the app's own command-line tool (`allowed-tools: Bash(contenta:*)`).
- The app processes local files only. It sends anonymous usage telemetry (which tools ran, which MCP client
  connected, trial state) to ContentaSoft; turn it off in the app's settings. Privacy policy: https://www.contenta-converter.com/privacy.php
- ai_transform sends the image to Google Gemini with your own Gemini API key.
- During the trial some outputs carry a watermark or other limits; the tool results say so and link to the
  license.

## License

This plugin and the launcher are MIT-licensed (see LICENSE). Contenta Converter itself is commercial software by
ContentaSoft AB.
