## Research Question

In the intro they say:

What characteristics are desirable in a retriever to optimize prompt construction for RAG systems? Are current retrievers ideal?

But in the results they say:

"What char- acteristics are desirable in a retriever to optimize prompt construction for RAG systems in order to increase the LLM effectiveness?"

## Contributions

1. We conduct the first comprehensive study examining the impact of the type of retrieved documents in RAG on the LLM effectiveness.
2. We propose retrieval RAG heuristics that leverage the unexpected results of this study.
3. We release all associated code and data to the community to encourage further research.

# 1. Introduction

* Should mention the retriever and generator concepts of RAG.
* Should also mention the research question.
* Should mention the three types of documents (relevant, random, distracting), but maybe also mention the notion of "gold document" here, which the authors introduce later in the paper. Lets give an example for every type, for e.g. the Napolean example they give or something else more interesting to students.
* Should mention the contributions.

# 2. Related Works

## 2.1. Generative Language Models

This section doesnt contain anything relevant to the presentation.

## 2.2. Information Retrieval

Here they mention the main retriever techniques existing. They differentiate between sparse and dense, where sparse retrievers are more like the old-school IR techniques (BM25, TF-IDF) and dense retrievers are more recent, using neural networks to learn dense vector representations of documents and queries. But they don't mention the newer learned sparse retrievers, which are kind of a hybrid between the two. Maybe we can briefly mention those as well, just to be complete, or to extend their ideas. But it's not really essential to the presentation or to their results. They study what retrievers should retrieve, not how they should retrieve it, so the specific retriever technique is not that relevant.

## 2.3. Retrieve and Generate 

Here they introduce the RAG paradigm, and mostly name a lot of papers that investigate this topic. But this paragraph doesn't contain any specific information that we should mention in the presentation. They don't give any details, for that they have written section 3. Though there might be something interesting in the papers they mention, but let's not focus on that for now. 

# 3. Retrieval Augmented Generation

In this section they go more in depth on technical details of RAG.

## 3.1. Open Domain Question Answering

In this section they explain the specific task they are working on, which is open-domain question answering. The task is that given a question, the answer must be found in a large collection of documents. They follow by stating that the prevalent approach for this task is two do this in two phases: first retrieve document that might contain the answer or help finding the answer, and then synthezise an answer. Here they also introduce the notions 'retriever' and 'reasoner', where the reasoner is typically a 'generator'. I guess these terms can be used quite interchangeably, though 'generator' give some detail on how the 'reasoner' was implemented. They used 'generator' in the introduction, but here they switch to mainly 'reasoner'. 

## 3.2. Retriever

Here they go more in depth on the retriever. They only really mention the dense retriever, which they introduce as a retriever that has encoders to embed both the query and the documents into a vector space. Usually with a transformer based neural network. And then once the query is embedded, the retriever can find the most similar document embeddings to the query embedding, and return those documents. Usually the distance metric is the dot product. 

They only really mention this for the dense techniques. But of course this is about the same for the sparse techniques (old-school and newer learned sparse techniques). The main difference is just how the embeddings are created, and how the similarity is calculated. Though in newer techniques there mights be systems where no embedding representations are created at all, and no distance metric is calculated.

One things to mention is that they don't mention cross encoders, but that is quite sensible since those are not really used as retrievers, but more as re-rankers. So they are not really relevant for this paper, since they only focus on the retriever component of RAG.

I think this section is to introduce the most used type of retriever, which is also the one they are using in their experiments. I think that for us it is nice to mention that there are a wide variety of retriever techniques, but that this paper focuses on the dense retriever, which is the most commonly used one in RAG systems.

## 3.3. Reasoner

Here they introduce the reasoner, the second phase that synthesizes the answer. They right away jump to the 'generator' type (or at least they mainly talk about generative LLM's as reasoners). 

For this generator, they write down the basic probabilistic model language generators are built around which the generative model tries to maximize:

$$ P(w_1, w_2, ..., w_n) = \prod_{i=1}^{n} P(w_i | w_1, w_2, ..., w_{i-1}) $$

And then they add documents and queries to the model, and rewrite it into a form that is more appropriate for RAG systems:

$$ P(y_1, y_2, ..., y_n | q) = \prod_{i=1}^{n} \sum_{d \in D_r} P(d|q) P(y_i | y_1, y_2, ..., y_{i-1}, q, d) $$

Where $P(d|q)$ is the probability of retrieving document $d$ given query $q$, and $P(y_i | y_1, y_2, ..., y_{i-1}, q, d)$ is the probability of generating the next word $y_i$ given the previous generated words, the query, and the retrieved document $d$. $D_r$ is the set of all retrieved documents.

In dense systems, $P(d|q)$ is usually modeled as $P(d|q) \approx exp(E(q) \cdot E(d))$, or with some other distance metric. 

The most important part of this section is that they point out what this research is trying to optimize, which is $D_r$, the set of retrieved documents. They want to find out what characteristics of $D_r$ are desirable to optimize the performance of the RAG system. So mabe for the presentation is to give the formula of the model, and then point out that $D_r$ is the thing we are optimizing here. What documents should be in $D_r$? What documents shouldn't? In what order should they be? In what layout or form? Etc.

# 4. Experimental Methodology

## 4.1. Natural Question Dataset

The dataset they use to their experiments is the Natural Questions dataset. This contains queries/questions based on real Google search data, and every entry contains a question / query, and the corresponding Wikipedia page that contains the answer to the question. So this passage is the 'gold document' for the question, and the answer can be found in this passage.

They use a subset of this dataset, called NQ-Open, which contains the a subset of the question but they don't link the question to the Wikipedia page. I don't really understand what they mean by this. I guess this dataset contain the questions and general answers to them, instead of the specific page that contains the answer. They say this is more realistic, but I dont see why. They need the target labels anyway and the NQ-Open dataset doesnt contain these I think? Or does it? It seesm that you could also ignore the wikipedia page in the original NQ dataset, to get the exact same but there must be specific reason they do this.

For a source of documents to retrieve from, they use a Wikipedia dump from 2018, which contains all Wikipedia pages that were available at that time. But since this dump is from a different time than the NQ-Open dataset, and therefore gold passages might not exist in the dump, they have extended the dump with the gold documents from the original NQ dataset. This is one reason why I don't get the point of the NQ-Open dataset. 

Also they state that all documents are split into passages of 100 words (non-overlapping). 

## 4.2. Types of Documents

Here they explain the now four types of documents that they will be using in their experiments, which are:

1. Gold document: the document that contains the answer to the question.
2. Random document: a random document from the Wikipedia dump that does not contain the answer.
3. Distracting document: a document that is similar to the gold document, but does not contain the answer. For example a document about Napoleon that does not contain the answer to a question about Napoleon. So relevant, and semanticly similar, but not containing the answer.
4. Noisy document: a document that is similar to the gold document, but contains random noise, such as random sentences or words. So relevant, and semanticly similar, but containing a lot of irrelevant information.

I don't get why they first introduces three types of documents and now four. They should've done four right away. Lets commit one slide in the presentation to explaining these types. 

## 4.3. Document Retrieval

Here they state they use a typical dense retriever, where transformer based encoders are used to create dense vector representations of the documents and the query, and then the most similar documents are retrieved based on a distance metric. They note that the embedding is calculated as an average of the token features from the last layer. And that they use a BERT-based model for the encoders, specifically the Contriever system introduced by Gautier et al. (2021). This part is about the first phase of RAG, the retrieval phase. 

## 4.4. LLM Input

Here they explain the start of the second phase in RAG: generating. How the LLM prompts are constructed based on the query, the top-k retrieved documents, and instruction. 

They also give an extra note on the NQ-Open dataset, that it only contains questions and answers whose answers are 5 words or less. The LLM is instructed to extract (copy word by word) the answer from the retrieved documents.

They also note that they always use the structure: instruction, context, query. So the instrcution is always at the start of the prompt, and the question/query at the end. The context, containing all the documents, is always in the middle but it's structure is different across the different experiments.

They don't specify (or at least here they don't) why the instruction is always at the start and the query at the end. Probably because research has shown this to be best. But maybe nice to look into this and maybe mention their reason for this in the presentation.

## 4.5. LLMs Tested

They specify they test four different LLMs as reasoners, which are:

* LLama 2-7B 
* Falcon 7B
* Phi-2 2.7B
* MPT 7B

For all models they test both the base and the instruct version, but only report the results for the instruct version, since the behavior is similar but the instruct version performs better.

Moreover,

* They quantize the models to 4-bit.
* They restrict to a maximum of 15 generated tokens. 
* They use a greedy approach, so I guess they argmax the probability distribution at every step, instead of sampling from it.
* Multi shot prompting is not used and hasnt been tested (future work?).

## 4.6. Accuracy

This section talks how they measure the accuracy of the generated answer. They first again give a bit more insight into the NQ-Open dataset, that it multiple answer for a question, all of which are basically different ways to say the same thing. So maybe this is where NQ-Open differs from the original NQ dataset, that it contains multiple answers for a question, instead of just the wiki page that contains the answer or just one answer.

Then they say they use some assesment technique (they cite other papers for details) that checks if at least one of the answers in the dataset is contained in the generated answer. So they don't give specific details how this works. But I suppose some algorithm based on old school substring matching or with synonym maps or something like that. But I really don't know, we should check the cited papers to see how this works. They do note that for instance when the answer is "President Roosevelt", then "Roosevelt" would not be counted as correct. So maybe the algorithm isnt as smart, maybe it is just exact string matching. But we should check the cited papers to be sure.

# 5. Results

This quote sums things up nicely:

"Studying the characteristics of optimal prompts for RAG systems corresponds to answering our research question (RQ): "What char- acteristics are desirable in a retriever to optimize prompt construction for RAG systems in order to increase the LLM effectiveness?". More specifically, we focus on three essential elements of the configura- tion: type, number, and positioning of the documents, and for each, we test various prompt combinations."

In this intro section they also clear up all symbols they will be using to refer to the different types of documents, and prompt layouts. Let's use the same way in the presentation it is really nice. So like [I, G, R, Q] for instruction, gold document, random document, and then query. But then with nice symbols maybe. Or if its do much to explain symbols in the presentation just with words maybe. But it should work I guess. 

"To facilitate the understand- ing of our experimental setup, we employ a streamlined schema for representing the composition of prompts via the following symbols:"

## 5.1. Impact of Distracted Documents

Their first experiment is the following. They assume a retriever that always finds the gold document, and 0-10 distracting documents which the Contriever retriever found and put into a top-k. They test the performance of RAG system with different numbers of distracting documents, and differenc positioning of the gold document (before distracting, after distracting, or in between distracting passages). Though the positioning variable is more looked at in the next section.

Since the results of this might depend highly on which distracting documents where found by the retriever, they also test this on a retreiver that was specifically trained on hard negatives, so that it is less likely to retrieve distracting documents. But even for this retriever they find similar results.

They note that this is all very important, since typical retrievers and especially the semantic similarity based ones, often retrieve documents that are similar to the gold document, but do not contain the answer. So this is very common.

They find that even one distracting document can lead to a significant drop in performance, and that more distracting documents leads to even worse performance. So the more distracting documents, the worse the performance. This result is found across all LLM's, across different positionings of the gold documents, and like I said even for a different retriever that is trained to not retrieve distracting documents. So this is a very robust result.

They give a visual explanation on why this happens. Namely when you look at the attention weights during generation of a wrong answer, you seen a lot of attention of the model on a distracting document, as well as on the gold document. And this seems logical. The models are trained to have high attention weights for tokens that are relevant to each other or similar in some sense and that is exactly what distracting documents are.

Conclusions

* More distracting documents leads to worse performance.
* Even one distracting document can lead to a significant drop in performance.

## 5.2. Impact of Gold Positioning

Here is where they go into the position aspect a bit more. So there are three positions, at the start, in the middle, or at the end of the retrieved documents. The experiment and results are I think the same one as before, but with a focus on positioning of the gold document instead of the number of distracting documents.

Their finding here align with some other paper that already had this conclusion (Liu et al., 2023). Which is that there is a direct correlation between the position of the gold document to the query and the performance of the RAG system. The system performs best when the gold document is closest to the query, in the close setting, at the end of the prompt. Then the second highest performance is seen when the gold document is at the start of the prompt. The worst performance is seen when the gold document is in the middle of the prompt. They call this the "lost in the middle" effect, which is also the title of the paper by Liu et al. (2023) that they cite for this effect.

So $$\text{Performance} \propto \frac{1}{\text{Distance of gold document to query}} $$

And $$\text{Close to query} > \text{Far from query} > \text{Middle}$$

Results are again consistent across all LLMs in the experiment with the distracting documents. 

And though not mentioned in this section, when you look at the results from the experiment where noise was added, you can also see the general trend that putting the gold document closer to the query leads to better performance, even when noise is added. But one difference here is that far is not always better than middle, sometimes middle is better than far. So the lost in the middle effect is not as clear when noise is added, but still the general trend that closer to query is better than further from query still holds.

## 5.3. Impact of Noise

Here they do basically the same experiment as before, which provided the results for 5.1 and 5.2, but now they don't add distracting documents, but noise documents. These noise documents are passages that are just randomly sampled from the dataset. So they are not similar to the gold document, and they don't contain the answer, and they also don't contain a lot of relevant information. They are just random passages.

But the setup is the same, they test different numbers of noise documents, and for all three positions of the gold document.

They find out noise against expectations, that more noise doesn't deteriorate the performance. For the setting where the gold document is at the end, closest to the query, they even find that more noise leads to better performance. So noise can actually help.

Results here are not consitent across all LLMs. Namely, for Llama and Phi, more noice leads to better performance in the close setting (gold document at the end), but in the far and mid setting (gold document at the start or middle) more noise leads to worse performance. Falcon didn't see any improvement by adding noise, accuracy just always drops when adding noise in all settings. But MPT saw an increase in performance in all settings. So no matter the position of the gold document, more noise leads to better performance for MPT. 

As an addition to 5.2, the results from this experiment also show a general trend that gold document close to question is better than gold document far from question. But one difference here is that the "lost in the middle" effect is not always seen here. For instance, for the Phi and Llama models, in some cases the middle position of the gold document performs better than the far position. 

## 5.5. RAG in Practice

Here they follow up on the results from the previous sections, but now they do more realistic experiments, to get back to the original research question: "What characteristics are desirable in a retriever to optimize prompt construction for RAG systems in order to increase the LLM effectiveness?".

### No Oracle

Whereas the experiments before always included the gold document in the context, now they do an actual normal retrieval step with the Contriever, and then they use these retrieved documents as input to the LLM, which is always the Llama model in this experiment. So in this setup, they don't differentiate between distracting and gold documents, they are all just 'retrieved documents'. 

The thing they do change is that sometimes they add noise documents to the retrieved documents, and sometimes they don't. The results from this show that, at least for Llama, that adding noise is almost always beneficial, even in this more realistic setting. 

### Sparse BM25

They also do the exact same experiment but with a sparse retriever, namely BM25, and they find similar results. Adding noise is almost always beneficial in the case of a Llama generator, even for BM25. As a sidenote they also observe better performance for BM25 than for Contriever.

### Different Noise

In the previous experiment on noise documents, they just randomly sampled noise documents from the Wikipedia dataset. But the authors question whether this can actually be considered noise, since they are still document from the same domain and might help the LLM answer the question in a way consistent with the dataset. So since these noisy documents might be a bit biased, they redo the experiment but now they add noise from another dataset, Reddit Webis-TLDR-17. They even do another type of noise, which are just nonsensical sentences consisting of random words. In both of these added scenarios they find similar results, that adding noise is beneficial to the performance of the RAG system. 

### Falcon

Whereas the more realisic experiment above where done using the Llama model, here they do some extra testing for the Falcon model. They do this because Falcon was the only model that didn't see any improvement by adding noise in the previous experiments, so they want to test this more in depth. In this setting they do the same experiment as before but now the prompt is [I, N, R, Q] instead of [I, N, G, Q], so the gold document is replaced by the retrieved documents. In this setting, in contrast to the previous experiments, they do see an improvement by adding noise. So in the more synthetic setting the noise didn't help, but in the more realistic setting it does seem to help. 

## 5.6. Retriever Trade-off

In this section they introduce a concept they see in their results, which is some kind of trade-off between the number of relevant documents and the number of totally irrelevant documents. This line sums it up:

"While establishing a formal or comprehensive theory behind these findings remains an open research challenge, we can still infer that there seems to be a trade-off between the number of relevant and totally irrelevant doc- uments. More specifically, we observed that the best effectiveness is achieved when a minimal set of documents is initially retrieved and then supplemented with random documents until the context limit is reached. For the queries examined in this study, retrieving be- tween 3 and 5 documents is the most effective choice. Adding more increases the risk of including too many distracting, thus coun- terproductive, documents."

They end this section (though I feel like its more of an extra section) by trying to give an explanation for the unreasonable effectiveness of adding noise. They state the ad hoc conclusion that adding noise does something that better conditions the generation model. And what this is, is that it might be that it increased the entropy in the attention scores of the model. 

They refer to other papers that also investigated this issue: "Previous research [3, 14], particularly [58], hints that there might be cases in which a pathologically low attention entropy causes the LLM to generate degenerate outputs with a sharp decrease in performance. These episodes are named entropy collapse.".

So basically, in every transformer layer, the model calculated attention scores between all tokens right? How high these scores are gives some measure of how much information is passed betweem tokens on every attention layer. The idea is that when these scores are very low (e.g. the entropy of the attention scores is low), then the model will perform bad. So what adding noise does, is that it increases the entropy of the attention scores, which leads to better performance.

When testing this, they find that indeed, a setting of [I, N, G, Q] has higher attention entropy than [I, G, Q]. To be specific, a 3x increase. So this shows that entropy is indeed higher when adding noise. But this just shows correlation, not causation. The authors clearly state that it's an interesting pattern to look into for explanation, but it cannot directly answer the question: "why does adding noise help?". Nice for future work.

# 6. Conclusion
Sums up the whole paper. Everything here is important to the presentation. But the most important three findings are a nice summation of the results:

"This study led to several im- portant findings, including two unexpected ones. First, the position of relevant information should be placed near the query; otherwise, the model seriously struggles to attend to it. Second, in contrast to common perception, top-scoring retrieved documents that do not contain the answer, when added to a prompt, negatively impact the LLM effectiveness. Finally, and even more surprisingly, random, noisy documents are actually helpful in increasing the accuracy of these systems when correctly positioned within a prompt."












