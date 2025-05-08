# Advice/Tips data visualization

### Points of view presentation: [link](https://docs.google.com/presentation/d/1HvGeGT9NBhVc0SKlyTx5Fae_4aTbyyfjVA7LIUvFBZA/edit#slide=id.p) 
Covering
- Layout
- Gestalt principles (how people organize visual information)
- Color usage
- Plot specific parts
    - Heatmaps
    - Networks
- Plot horrors


### Plot galleries
##### BBGallery of plots (legacy from BBGcloud)
- [BBGplots](https://bbgcloud.irbbarcelona.org/dashboard/bggallery/bbgplots/index.html)
- [Matplotlib](https://bbgcloud.irbbarcelona.org/dashboard/bggallery/examples_mpl/index.html)
- [Bokeh](https://bbgcloud.irbbarcelona.org/dashboard/bggallery/examples_bkh/index.html) 
##### Other galleries
- [The R Graph Gallery:](https://r-graph-gallery.com/) A collection of charts made with R, including reproducible code. 


### Color usage:
##### Perception of color: 
Some important considerations when selecting a color palette include:
- **Does the palette retains its integrity when printed in black and white?** Gradients are a good idea to satisfy this criteria, e.g. the `viridis` palettes.  
- **Are people with colorblindness able to understand it?** [Color blindness simulators](https://www.color-blindness.com/coblis-color-blindness-simulator/). Can help with that. Also, the `colorblindr` R package can simulate color blindness to ggplot objects.

##### Color palettes:
- [ColoRBrewer](https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3): Classic tool for picking colorblind-safe and print-friendly palettes.
- [Viridis](https://search.r-project.org/CRAN/refmans/viridisLite/html/viridis.html): Perceptually uniform and colorblind-friendly.
- [Color Palette Finder](https://r-graph-gallery.com/color-palette-finder) (Also accessible with the `paletteer` R package).
- [Coolors](https://coolors.co/): Nice tool to explore and create palettes (but limited to ~5 colors).

### Creating reusable themes in R:
Creating reusable themes in R is a great way to ensure consistency and save time across visualizations. 
##### 1. 1. Create a Custom Theme Function
```R
library(ggplot2)

theme_tidy <- function(base_size = 12, base_family = "sans") {
  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      plot.title = element_text(face = "bold", size = base_size + 2, hjust = 0.5),
      plot.subtitle = element_text(size = base_size),
      plot.caption = element_text(size = base_size - 2, color = "gray40"),
      axis.title = element_text(face = "bold"),
      axis.text = element_text(size = base_size - 1),
      panel.grid.major = element_line(color = "gray85"),
      panel.grid.minor = element_blank(),
      legend.position = "bottom",
      legend.title = element_text(face = "bold"),
      strip.text = element_text(face = "bold", size = base_size),
      plot.background = element_rect(fill = "white", color = NA)
    )
}
```
##### 2. Apply to any ggplot
```R
ggplot(mtcars, aes(x = mpg, y = hp)) +
  geom_point(color = "#2c7fb8") +
  labs(title = "Horsepower vs. MPG") +
  theme_tidy()
```
##### 3. Make It Reusable Across Projects
Save theme and palette functions in a script (e.g., `mythemes.R`) and source it:
```R
source("path/to/mythemes.R")
```
##### 4. Set Your Theme Globally
Use your theme across all plots in a session:
```R
theme_set(theme_tidy())
```

## Reference
- Axel Rosendahl Huber
- Laura Torrens
