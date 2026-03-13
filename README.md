# IR Presentation
*The Power of Noise: Redefining Retrieval for RAG Systems*

This folder holds the details on our presentation about a information retreival research paper, including `typst` code for the presentation slides, as well as info on the study and assignment.

* The research paper can be found in `Cuconasu2024.pdf`. 
* The manual for the presentation can be found in `Manual Paper Presentation.pdf`.
* A grading scheme can be found in `IR1_template_presentations.pdf`. 
* The code of the original study is in `The-Power-of-Noise/`.
* I wrote some personal notes on the study, summarizing the paper and noting things relevant to the presentation in `notes.md`.
* Some `csv` extractions of all tables and results of the research is in `tables/`
* The entry point to the `typst` program is `main.typ`.
* Reusable `typst` code can be found in `helpers.typ`.
* In the `slides/` folder there is a `.typ` file for every slide.
* `presentation.pdf` is the compiled presentation.

To compile the presentation, run `typst compile main.typ presentation.pdf`. You can also use `typst watch main.typ presentation.pdf` to automatically recompile the presentation when you make changes to the code. To install `typst`, follow the instructions on [repo](https://github.com/typst/typst).