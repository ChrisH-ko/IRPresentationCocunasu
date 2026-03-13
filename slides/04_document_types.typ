// ============================================================
//  slides/04_document_types.typ  –  Taxonomy of document types
// ============================================================
#import "../helpers.typ": *

== A Taxonomy of Retrieved Documents

  #grid(
    columns: (1fr, 1fr),
    gutter: 22pt,
    // ── left: four types ──
    [
      The paper formalises four document types a retriever can return:

      #v(10pt)

      #block(inset: (left: 6pt))[
        #tag-gold #h(4pt) — the *ground-truth passage* containing the answer. \
        #v(6pt)
        #tag-relevant #h(4pt) — other passages that *also contain the answer* #text(size: 0.85em, fill: c-muted)[(not directly tested)]. \
        #v(6pt)
        #tag-distracting #h(4pt) — semantically close to the query but *no answer* (top-$k$ but wrong). \
        #v(6pt)
        #tag-random #h(4pt) — *unrelated* to the query; pure noise.
      ]
    ],
    // ── right: prompt notation + example ──
    [
      *Prompt structure notation:*

      #v(6pt)
      #block(
        fill: rgb("#f4f6f7"),
        stroke: c-muted + 0.5pt,
        radius: 5pt,
        inset: 12pt,
      )[
        #set text(size: 15pt)
        #grid(
          columns: (auto, 1fr),
          gutter: 8pt,
          [*I*], [Task instruction],
          [*★*], [Gold document],
          [*●*], [Relevant documents],
          [*▲*], [Distracting documents],
          [*■*], [Random documents],
          [*Q*], [The query],
        )

        #v(8pt)
        Example: #prompt("I", "▲", "★", "Q") means: instruction, then distracting docs, then gold, then query.
      ]

      #v(8pt)
      #info-box[
        The *position* of each document relative to Q will matter greatly.
      ]
    ],
  )
