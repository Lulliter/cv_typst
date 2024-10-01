# CV

My CV (in ENG and ITA) made with quarto & `typstcv` pckg.

## What is `typst`?

[`typst`](https://github.com/typst/typst) is a new markup-based typesetting system that is designed to be as powerful as `LaTeX` while being much easier to learn and use.

![Source: [Nicola Rennie's blog post](https://nrennie.rbind.io/blog/pdf-quarto/making-pdf-with-quarto-typst-latex/)](images/typst.png){width="339"}

It can be installed on macOS with

``` bash
# shell
brew install typst
```

### How do `typst` and `Quarto` interact?

Check it out [here](https://quarto.org/docs/output-formats/typst.html)

With the latest 1.4 release of Quarto, you can now use `typst` as an output format!

``` bash
# shell
quarto --version # 1.4.550
```

### How to use `typst` as a format?

``` yaml
# YAML
---
title: "Hello Typst!"
format: typst
---
```

### How to use `typstcv` (specifically) as a format?

[`typstcv`](https://kazuyanagimoto.com/typstcv/) provides helper functions for rendering a CV like [this](kazuyanagimoto/quarto-awesomecv-typst).

This can be installed with:

``` r
# R
install.packages("typstcv", repos = "https://kazuyanagimoto.r-universe.dev")
```

Basically it is a `*.qmd` file that has format...

``` yaml
# YAML 
---
format:
  awesomecv-typst:
    font-paths: ["PATH_TO_FONT"]
---    
```

...and is rendered into a `*.pdf` file.

-   it allows fontawesome icons
-   it allows SVG icons
-   it basically helps with a `resume_entry()` function that makes it easier to write a CV.
-   in my case, all the CV info are `*.csv` files stored in a `data/` folder, and then called with `readr::read_csv()`.
-   the final, rendered, `cv*.pdf` files are saved in the `docs/` folder
-   hopefully, with `renv.lock` in the mix, this won't break too soon 🤞🏻

Under the hood, the extension `awesomecv-typst` has 2 key files: 

+ `_extensions/kazuyanagimoto/awesomecv/typst-template.typ` \~ the core template file. It defines the styling of the document. 
+ `_extensions/kazuyanagimoto/awesomecv/typst-show.typ` \~ a file that calls the template. It maps Pandoc metadata to template function arguments. .


# Acknowledgments

I adapted the example kindly provided by [Kazuharu Yanagimoto](https://kazuyanagimoto.com/) 👏🏻, who is the creator of the `typstcv` [package](https://kazuyanagimoto.com/typstcv/).
