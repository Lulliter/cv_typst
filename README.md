# CV 

My CV (in ENG and ITA) made with quarto & `typstcv` pckg. 


### What is `typst`?

[`typst`](https://github.com/typst/typst) is a new markup-based typesetting system that is designed to be as powerful as LaTeX while being much easier to learn and use.  

It can be installed on macOS with 

```bash
# shell
brew install typst
```

### How do `typst` and `Quarto` interact? 

Check it out [here](https://quarto.org/docs/output-formats/typst.html)

### What is `typstcv`?

[`typstcv`](https://kazuyanagimoto.com/typstcv/) provides helper functions for rendering a CV like [this](kazuyanagimoto/quarto-awesomecv-typst).  

This can be installed with: 

```r
# R
install.packages("typstcv", repos = "https://kazuyanagimoto.r-universe.dev")
```
Basically it is a `*.qmd` file that has format 

```yaml
# YAML 

format:
  awesomecv-typst:
    font-paths: ["PATH_TO_FONT"]
```

and is rendered into a `*.pdf` file.


+ it allows fontawesome icons
+ it allows SVG icons
+ it basically helps with a `resume_entry()` function that makes it easier to write a CV.
+ in my case, all the CV info are `*.csv` files stored in a `data/` folder, and then called with `readr::read_csv()`.
+ the final, rendered, `cv*.pdf` files are saved in the `docs/` folder
+ hopefully, with `renv.lock` in the mix, this won't break too soon 🤞🏻

# Acknowledgments  
I adapted the example kindly provided by [Kazuharu Yanagimoto](https://kazuyanagimoto.com/) 👏🏻, who is the creator of the `typstcv` [package](https://kazuyanagimoto.com/typstcv/).
 
 
