// ============================================================
//  slides/08_finding_noise_oracle.typ  –  Noise helps (oracle)
// ============================================================
#import "../helpers.typ": *

== Finding 3: Random Noise #emph[Improves] Accuracy — Oracle Setting

  #grid(
    columns: (1fr, 1fr),
    gutter: 24pt,

    // ── left ──
    [
      *Oracle setting:* the gold document is always included.
      Random Wikipedia passages are added around it.

      #v(8pt)
      Prompt: #prompt("I", "■■■", "★", "Q") — noise + gold near Q

      #v(10pt)

      *Results (MPT-7b, Near):*
      #v(4pt)
      #block(
        fill: rgb("#f4f6f7"),
        stroke: c-muted + 0.5pt,
        radius: 5pt,
        inset: 12pt,
      )[
        #set text(size: 15pt)
        #grid(
          columns: (1fr, auto),
          gutter: 8pt,
          [Only gold #prompt("I", "★", "Q")],  text(fill: c-muted)[0.215],
          [+ 4 random docs (best)],             text(fill: c-green, weight: "bold")[0.293],
        )
      ]

      #v(8pt)
      #surprise-box[
        *+36% accuracy improvement* from adding documents that contain no answer at all!
      ]
    ],

    // ── right ──
    [
      *Not consistent across all models:*

      #v(6pt)
      - *MPT:* noise helps in _all_ positions (Near, Far, Mid)
      - *Llama2 & Phi-2:* noise helps only in the *Near* setting; hurts in Far/Mid
      - *Falcon:* noise does _not_ improve accuracy in this oracle setting

      #v(6pt)

      #finding-box[
        The benefit of noise is *model-dependent* in the oracle setting — but Near positioning + noise is the most robust combination.
      ]

      #v(6pt)
      #text(size: 15pt)[*Best noise position:* far from query; gold near query.
      #prompt("I", "■■■", "★", "Q") outperforms #prompt("I", "★", "■■■", "Q").]
    ],
  )
