# Editable PowerPoint Authoring

This file owns reusable rules for creating and revising formal editable PPTX files.

## 1. Workspace

Create and maintain the PPT project in the ChatGPT/agent cloud workspace by default.

Do not place the working project on the user's local desktop/Documents path merely because a connected tool can access that machine.

Use user-local storage only when the user explicitly requests a local path or when a source asset must be read from there. Source access does not imply project-location ownership.

## 2. Native editability

Prefer PowerPoint-native editable objects for:

- text;
- titles;
- equations;
- lines and arrows;
- boxes and callouts;
- process/architecture structures;
- charts;
- tables;
- simple diagrams.

Do not flatten a slide into a screenshot when the intended deliverable is editable.

Do not rasterize equations merely for convenience. Use native/equivalent editable equation objects such as PowerPoint-supported equation structures when the authoring toolchain permits.

## 3. Real images and evidence

Use original real images for source evidence when appropriate.

Do not recreate a real scientific/engineering/source image with Imagegen and present it as the source image.

Before placing a real image, it must have been actually viewed and matched to the slide's claim.

Preserve aspect ratio and avoid misleading crops. Use captions/source notes when the context requires attribution.

## 4. Data charts

When a chart represents real data, prefer rebuilding it from the actual data rather than using a screenshot.

The rebuilt chart should preserve:

- values;
- units;
- axis meaning;
- category/series mapping;
- uncertainty/error representation when present;
- relevant annotations.

If the underlying data are unavailable, do not fabricate them merely to make the chart editable.

## 5. Imagegen-assisted mode

Accepted generated slide visuals may be used when the selected final mode allows them.

Keep editable overlays native where practical: titles, labels, equations, callouts, arrows, page numbers, and source notes should not be unnecessarily burned into a bitmap.

## 6. Native-editable mode

The final deck must contain zero Imagegen pixel/generation residue.

Rebuild generated content using:

- native PowerPoint text and shapes;
- editable equations;
- real source images;
- data-derived charts;
- native diagrams or other editable structures.

Use an Imagegen page only as a temporary visual reference during reconstruction, never as final embedded generated pixels.

## 7. Revision

When revising an existing editable deck:

- change the smallest necessary set of objects;
- preserve accepted content and layout unless dependencies require broader change;
- keep object editability;
- do not replace an editable page with a raster image as a shortcut;
- re-run page-level checks after the edit.

If the requested revision requires re-generating an Imagegen page, switch to the Imagegen handoff workflow for that part, then return to editable revision.

## 8. Final authoring checks

Before returning a candidate PPTX to whole-deck QA, verify:

- no unexpected overflow/clipping;
- equations render correctly and remain editable where intended;
- text is selectable/editable;
- shapes/arrows/lines are native where intended;
- charts and tables use correct data;
- images are the intended source assets;
- page size/master/layout are consistent;
- Native-editable mode has no generated-pixel residue.
