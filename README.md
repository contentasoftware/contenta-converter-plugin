# Contenta Converter for Claude

Use **Contenta Converter** from Claude on your Windows PC: batch image conversion, resizing, effects, metadata, PDF albums and slideshows for 100+ image formats. Claude calls the app's tools on files on
your computer; nothing is uploaded to Anthropic or to ContentaSoft to do the work.

## What you need

- Windows 10 or 11 with **Contenta Converter** installed. It has a free trial: https://www.contenta-converter.com/download.php
  (if it is not installed yet, the plugin's `get_started` tool gives Claude the download link and the steps).
- Node.js 18 or later, which runs the small launcher in `server/index.js` (MIT, no dependencies, the same code
  as the npm package `@contentasoft/contenta-converter-mcp`; source: https://github.com/contentasoftware/mcp-launcher). The launcher
  starts the app's own MCP server (`contenta serve`) and passes its messages through; it sends nothing over the
  network itself.
- Claude Code or Cowork on that computer. Chat on claude.ai cannot start local programs, so it does not load
  this plugin's tools.

## What is included

- **MCP server** `contenta-converter` with the tools `convert_image`, `batch_convert`, `ai_transform`, `create_pdf_album`, `create_slideshow`, `merge_pdfs`, `detect_format`, `list_effects`, `read_metadata`, `write_metadata`. Each tool
  says whether it only reads files, writes new files, may overwrite files, or uses the internet.
- **Skill** `contenta-image-processing`: how and when Claude should use those tools.

## What runs and what is sent

- The plugin runs `node server/index.js` from the plugin folder; nothing is downloaded. The launcher looks for
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
