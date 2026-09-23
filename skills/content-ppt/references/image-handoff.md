# Imagegen Handoff

This file owns reusable image inspection, reference selection, file delivery, and Imagegen handoff/regeneration mechanics.

## 1. Inspect before use

Any image recommended for a slide or sent to Imagegen as a reference must be actually viewed.

Do not infer visual content from:

- filename;
- folder name;
- search thumbnail text;
- metadata;
- another model's description alone.

When many assets exist, use previews/contact sheets or equivalent visual inspection to narrow candidates efficiently, but the final chosen references still need actual visual confirmation.

Track enough provenance to answer:

- which slide uses the asset;
- where the asset came from;
- whether it has actually been viewed;
- whether it has been selected, rejected, or delivered.

## 2. Separate inspection from formal handoff

Asset inspection/selection does not itself trigger file delivery.

Only enter the formal handoff gate when the current task is to give the user a complete page-generation package.

## 3. Atomic handoff gate

For a slide with no reference images:

- deliver one complete self-contained final prompt.

For a slide with reference images, the handoff is complete only when all of the following happen in the same response:

1. Every required reference image has been actually viewed.
2. Every required reference image has been actually transferred into the current chat using CCM send_file or an equivalent real file-transfer capability.
3. All required file transfers succeeded.
4. The complete self-contained final prompt is provided.
5. The response explicitly identifies which just-sent images the user should upload to the fresh Imagegen chat.

A path, filename, markdown mention, or workspace location does not count as delivery.

If any required send fails, the handoff is incomplete. Do not instruct the user to start generation yet.

Do not send a .md file as a substitute for the prompt. The full prompt must appear directly in the response so the user can copy it.

## 4. Prompt completeness

Each page prompt must be self-contained. Do not rely on “same style as previous page” or hidden context.

Include, as applicable:

- slide title;
- purpose and takeaway;
- exact facts/numbers/equations that must be preserved;
- required labels and terminology;
- layout regions and reading order;
- information density;
- real/reference image role;
- generated illustration role;
- visual/formality constraints;
- explicit prohibitions;
- any prior error that must not recur.

The prompt should tell Imagegen what to produce, not merely describe the source spec abstractly.

## 5. Fresh-chat workflow

For each slide generation:

1. Use a fresh Imagegen chat unless the user explicitly chooses otherwise.
2. Upload only the reference images designated for that slide.
3. Paste the complete prompt.
4. Generate the page.
5. Return the generated page to the PPT workflow chat for review.

Fresh chats reduce accidental style/content leakage between slides.

## 6. Regeneration

When a returned page is rejected:

- identify the minimum material defects;
- update the canonical spec/prompt accordingly;
- keep accepted content stable;
- resend reference images only when the new generation needs them;
- if references are required again, execute the full atomic handoff gate again.

Do not push an assessable accept/regenerate decision back to the user. The PPT workflow should make the decision and give the next executable package.

## 7. Capability failure

If the workflow requires real reference-image delivery and CCM/equivalent file transfer is unavailable, state that the handoff gate is not complete.

Do not silently degrade to “the file is at this path” or “please find this image yourself.”
