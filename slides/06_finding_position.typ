// ============================================================
//  slides/06_finding_position.typ  –  Finding 1: position matters
// ============================================================
#import "../helpers.typ": *

== Finding 1: Position of the Gold Document Matters

  #grid(
    columns: (1fr, 1fr),
    gutter: 24pt,

    // ── left ──
    [
      Three positions tested for the gold document #tag-gold relative to the query *Q*:

      #v(6pt)

      #block(inset: (left: 8pt))[
        #text(fill: c-green, weight: "bold")[Near:] #h(4pt) #prompt("I", "▲", "★", "Q") \
        Gold adjacent to query \ #v(2pt)
        #text(fill: c-orange, weight: "bold")[Far:] #h(4pt) #prompt("I", "★", "▲", "Q") \
        Gold at start of prompt \ #v(2pt)
        #text(fill: c-red, weight: "bold")[Mid:] #h(4pt) #prompt("I", "▲", "★", "▲", "Q") \
        Gold buried in the middle
      ]

      #v(10pt)

      #finding-box[
        *Near > Far > Mid.* The middle of the context is hardest to attend to — worse than the start of the prompt.
      ]
    ],

    // ── right ──
    [
      *Intuition from attention patterns:*

      #v(8pt)
      - Attention scores are *highest near the query* — and also relatively high at the very start of the prompt
      - The *middle* of the context gets the least attention: a U-shaped curve
      - This is exactly the *"Lost in the Middle"* effect (Liu et al., 2023)

      #v(6pt)

      #warn-box[
        *Practical implication:* place relevant docs *immediately before* the query. Start of prompt is second best — never bury them in the middle.
      ]

      #v(4pt)
      #text(size: 13pt, fill: c-muted)[Consistent across all tested models (Llama2, Phi-2, Falcon, MPT).]
    ],
  )
