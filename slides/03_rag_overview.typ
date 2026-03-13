// ============================================================
//  slides/03_rag_overview.typ  –  RAG pipeline & research question
// ============================================================
#import "../helpers.typ": *

== How RAG Works — and What We Don't Know

  // Pipeline diagram (text-art in a styled block)
  #block(
    fill: rgb("#f4f6f7"),
    stroke: c-muted + 0.5pt,
    radius: 6pt,
    inset: 14pt,
    width: 100%,
  )[
    #set text(size: 16pt)
    #align(center)[
      #grid(
        columns: (auto, auto, auto, auto, auto, auto, auto),
        gutter: 6pt,
        align: center + horizon,
        block(fill: c-lblue,  stroke: c-blue + 0.8pt,  radius: 4pt, inset: 8pt)[*Query*],
        text(size: 22pt, fill: c-muted)[→],
        block(fill: c-lblue,  stroke: c-blue + 0.8pt,  radius: 4pt, inset: 8pt)[*Retriever* \ #text(size: 10pt, fill: c-muted)[(IR system)]],
        text(size: 22pt, fill: c-muted)[→],
        block(fill: c-gold.lighten(70%), stroke: c-gold + 0.8pt, radius: 4pt, inset: 8pt)[*Documents* \ #text(size: 10pt, fill: c-muted)[(passages)]],
        text(size: 22pt, fill: c-muted)[→],
        block(fill: c-green.lighten(80%), stroke: c-green + 0.8pt, radius: 4pt, inset: 8pt)[*LLM* \ #text(size: 10pt, fill: c-muted)[(generator)]],
      )
      #v(4pt)
      #text(size: 12pt, fill: c-muted)[→ Answer]
    ]
  ]

  #v(6pt)

  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      *Common assumption:*
      - Feed top-$k$ highest-scoring retrieved docs to the LLM
      - More semantically relevant = better
      - Number of docs limited only by context window

      #v(4pt)
      #text(size: 15pt)[*Contributions:* first comprehensive study of doc type in RAG; new retrieval heuristics; all code & data released.]
    ],
    [
      *This paper's research question:*
      #finding-box[
        _"What characteristics are desirable in a retriever to optimize prompt construction for RAG systems in order to increase the LLM effectiveness?"_

        #v(4pt)
        Three dimensions studied: *type*, *position*, and *number* of documents.
      ]
    ],
  )
