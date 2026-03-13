// ============================================================
//  slides/02_motivation.typ  –  Why does this paper matter?
// ============================================================
#import "../helpers.typ": *

== Motivation: When LLMs Know Too Little

#grid(
  columns: (1fr, 1fr),
  gutter: 24pt,

  // ── left ──
  [
    *Large Language Models are impressive — but limited:*
    #v(6pt)
    - Knowledge is *frozen* at training time
    - Prone to *hallucinations* on factual questions
    - Struggle with *domain-specific* or rapidly changing knowledge

    #v(8pt)
    #warn-box[
      Asking a 2023 LLM about last week's events → unreliable answers
    ]
  ],

  // ── right ──
  [
    *Retrieval-Augmented Generation (RAG) as the fix:*
    #v(6pt)
    - Augment the prompt with *retrieved passages* at inference time
    - Grounds the LLM in real, up-to-date evidence
    - Standard in enterprise & search applications (Bing, ChatGPT, etc.)

    #v(8pt)
    #info-box[
      *But:* the retriever's role itself has received *surprisingly little* systematic study.
      #v(4pt)
      → This paper asks: #text(weight: "bold")[what should a RAG retriever actually retrieve?]
    ]
  ],
)
