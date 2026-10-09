# Editable PowerPoint Authoring

This file owns reusable rules and implementation cautions for creating, reconstructing, validating, and revising editable PPTX files. Workflow-stage decisions stay in workflow.md; this file owns how the PowerPoint artifact itself is authored and verified.

## 1. Authoring environment

For persistent Content PPT projects, author inside the active project runtime or the project-declared working directory. The project runtime owns the current canonical files, approved artifacts, scripts, and final PPT work.

Do not create a second project copy merely because another tool surface is available.

If the user explicitly selects another working location, follow that project decision and keep one authoritative working copy.

Do not open or modify unrelated local PPT files merely for validation.

## 2. Native editability requirements

Prefer PowerPoint-native editable objects for:

- text and titles;
- equations;
- lines, connectors, and arrows;
- boxes, callouts, and process/architecture structures;
- charts;
- tables;
- simple diagrams.

Do not flatten a slide into a screenshot when the intended deliverable is editable.

Do not rasterize equations, labels, tables, or diagrams merely for convenience when they are expected to remain editable.

An object merely existing in the PPTX is not enough. It must also be accessible and editable in the user's intended PowerPoint workflow.

## 3. Visual evidence, generated illustration, and real images

Classify the role of a visual before authoring it:

### Evidence / project-specific factual visual

If a visual communicates “this is the actual object, actual work, actual measurement, or actual result,” use a traceable real source or faithful reconstruction from real data.

Examples include:

- actual experimental apparatus/test rig/site photographs;
- microscopy, measurement, sensor, or observation outputs;
- real quantitative data charts and uncertainty plots;
- CFD/DNS/simulation result figures carrying specific numeric conclusions;
- visuals used to demonstrate actual project work or a specific named real-world facility.

Do not recreate these with CPA-generated lookalikes and present them as evidence.

Faithful redraw from real data using code/PowerPoint is allowed. Fabricating plausible values or a plausible-looking result image is not.

### Conceptual scientific illustration

Generated visuals may explain a mechanism, structure, process, force relationship, scale change, or generic experimental concept.

They may be realistic or photorealistic if the page does not imply that the image is an actual project record, actual experiment photograph, or measured result.

For apparatus visuals:

- use a real image when the claim is “this is our actual apparatus”;
- a generated generic apparatus illustration is acceptable when the purpose is only to explain how such a system is conceptually arranged.

### Application / scene-setting illustration

Introduction, background, motivation, and engineering-application pages may use photorealistic CPA-generated visuals for generic scenes such as power plants, factories, chemical facilities, pipelines, energy systems, offshore platforms, heat-transfer systems, or industrial environments.

These generated scenes are allowed when they:

- do not claim to depict a specific real project/site;
- do not carry precise geometry, quantitative results, measurements, or project facts;
- are not used as proof of actual work performed.

If a specific named plant/facility/case is itself part of the factual claim, prefer a real source image instead of a generated lookalike.

Page titles, captions, and surrounding text must not mislabel generated illustration as “actual plant image,” “experimental setup,” “measured field,” or equivalent factual evidence.

Before placing any real source image, actually view it and match it to the slide's claim. Preserve aspect ratio and avoid misleading crops.

For genuine scientific plots, experiment photos, microscopy and other geometry- or evidence-bearing images, **never non-uniformly stretch to match a generated layout**. Preserve aspect ratio. If the reserved space is incompatible, revise the layout or (for reproducible data-derived figures) change the plotting script's canvas, axes, legend, and typography, render anew from the authoritative data, then place proportionally. Never distort data curves or measurements to satisfy a screenshot's geometry.

## 4. Native equation authoring

“Looks like an equation” is not the same as a native editable equation.

When the requirement is a PowerPoint-native equation:

- use an equation structure that the target PowerPoint actually recognizes and edits as math;
- do not treat ordinary text in a math font as equivalent to a native equation;
- do not assume manually injected OOXML is valid merely because the package is well-formed or another renderer displays it.

If an Office-native path is used to create equations, validate the resulting object in the target PowerPoint application when that capability is available.

## 5. Default ImgGen-to-editable reconstruction

When reconstructing an approved or user-designated ImgGen/CPA slide into editable PowerPoint:

- treat the user-designated artifact as the visual source of truth when the user explicitly says to reproduce it;
- **place the original generated slide as a temporary bottom-layer image on the same slide** to serve as a visible alignment template;
- above that guide, rebuild the intended editable text, equations, labels, scientific figures, tables, shapes, connectors, and arrows using actual editable PowerPoint objects or faithful real assets;
- preserve approximate geometry, alignment, hierarchy, and accepted visual relationships unless a verified scientific error or explicit user request requires change;
- do not redesign from an old prompt when the user has said the current artifact is the base;
- aim for **editable and approximately positioned**, not a complete one-pass pixel-perfect clone; the user will visually align and modify objects with the guide in place, then delete it;
- **temporary doubled text, equations, or graphics are acceptable** because the underlying guide is deliberately visible during reconstruction; do not hide editable objects or distort geometry to suppress this double image;
- when the user requests the **clean final deck**, remove the temporary guide and verify that native content remains complete and legible; a guide-bearing working draft is a valid intermediate deliverable;
- a generated artifact can serve as this **reconstruction target/visual guide** but is not thereby an eligible CPA reference input or scientific evidence.

Use connectors for logical relationships when editability matters, rather than baking arrows/lines into a raster layer.

### Reconstruction pilot and verification

Before rolling out a new reconstruction method to a large deck, choose a representative complex page containing several of the actual object types: mathematical equations, charts/real scientific figures, tables, and connectors as appropriate. Open, save, close, reopen, and edit it in the intended PowerPoint application. Correct the underlying authoring method before bulk conversion.

The generated guide may be visually noisy while editing; judge the reconstruction on its editability and its **guide-hidden / guide-deleted** content, not the double appearance of the working view. Avoid a hidden-edit-layer workaround: editable objects must be selectable, visible in the clean view, and genuinely modifiable.

Check for missing objects, inaccessible overlays, wrong object order, and content that vanishes when the guide is hidden. Do not mistake guide duplicates for actual overlapping native objects. The guide must remain easy for the user to select/remove without deleting the objects above it.

## 7. Charts, tables, and diagrams

When a chart represents real data, rebuild it from the actual data when available.

Preserve:

- values and units;
- axis meaning and scaling;
- category/series mapping;
- uncertainty/error representation;
- relevant annotations.

If the underlying data are unavailable, do not fabricate them merely to make the chart editable.

Prefer native PowerPoint tables for editable tabular content. Prefer native shapes/connectors for simple schematics and process diagrams.

For complex scientific figures that cannot be faithfully reconstructed without losing meaning, retain the real source figure rather than replacing it with a fabricated editable approximation.

## 8. Mode-specific authoring

### CPA generation path

Accepted generated slide visuals may remain when the selected final mode allows them.

Keep overlays native where practical: titles, labels, equations, callouts, arrows, page numbers, and source notes should not be unnecessarily burned into a bitmap.

### Native-editable mode

The **cleaned final deck**, after guide removal, must contain no generated **full-page** image pretending to be editable content. A working reconstruction PPTX may intentionally retain its temporary full-page ImgGen guide. Ordinary non-evidence generated conceptual illustrations may remain when expressly part of the selected final visual design.

Rebuild generated content using:

- native PowerPoint text and shapes;
- editable equations;
- real source images;
- data-derived charts;
- native diagrams or other editable structures.

Use a CPA-generated page as the temporary bottom-layer reconstruction target, never as a substitute for independently editable content and never as a CPA reference merely because it is the reconstruction target.

## 9. Revision

When revising an existing editable deck:

- change the smallest necessary set of objects;
- preserve accepted content and layout unless dependencies require broader change;
- keep object editability;
- do not replace an editable page with a raster image as a shortcut;
- re-run page-level checks after the edit.

Run QA/validation in read-only mode. Never hide a corrective write operation inside a validator. For local changes, compare **non-target pages** and their PPTX slide parts/objects to the baseline when feasible and reject accidental changes outside the intended pages; repairs must be separate explicit authoring steps.

When the user designates a current screenshot/PPT artifact as the editable reconstruction base, that artifact controls the reconstruction. This authoring rule does not override CPA reference-eligibility rules.

## 10. PowerPoint application-level compatibility validation

Structural/package checks are auxiliary. ZIP/XML validity, python-pptx readability, or successful LibreOffice rendering do **not** prove that Microsoft PowerPoint will open and edit the file correctly.

For complex native outputs, especially those involving:

- Office Math;
- manually/programmatically authored OOXML;
- external Office objects;
- complex tables;
- hidden layers/objects;
- image-base plus editable overlays;

perform application-level validation in the target PowerPoint environment when available:

1. open the PPTX;
2. save it;
3. close it;
4. reopen it;
5. confirm there is no repair/read error;
6. spot-check that critical objects are still editable.

Only after this check may the result be described as PowerPoint-verified.

If target PowerPoint validation is unavailable, state the validation boundary. Do not claim PowerPoint compatibility merely because XML/package checks or another renderer succeeded.

## 11. Final authoring checks

Before returning a candidate PPTX to whole-deck QA, verify:

- no unexpected overflow/clipping;
- equations render correctly and remain genuinely editable where intended;
- text is selectable/editable;
- shapes/arrows/connectors are native where intended;
- charts and tables use correct data;
- real images are the intended source assets;
- generated illustrations are used only in permitted non-evidence roles;
- no unintended duplicate/hidden layers remain;
- temporary guide remains removable, and guide-hidden content stands alone; overlapping guide and editable objects during construction are expected, not final-layout defects;
- evidence-bearing images preserve their true aspect ratios (redraw data figures from source code rather than non-uniformly stretching them);
- page size/master/layout are consistent;
- complex outputs have completed the available PowerPoint compatibility check;
- clean native-editable delivery has no residual full-page generated guide unless the user explicitly requested the working alignment draft.
