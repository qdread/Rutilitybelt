# GGPLOT2 tips 'n' tricks

or, stuff I always have to Google.

Maybe this could become another blog post.

## Multiple rows in legend

```
p +
  guides(fill=guide_legend(nrow = 2, byrow=FALSE))
```

## Label the facet CATEGORIES themselves

There is no good way to do this in ggplot2 internally. You will need to use cowplot.

This is just an example and it mightn't work exactly as is. The numbers may need tweaking. `plot.margin` is 5.5 points for all margins across the board. The first two arguments are top and right so you make them a bit wider to accommodate the labels.

```
library(cowplot)
p <- p + theme(plot.margin = unit(c(25, 25, 5.5, 5.5), 'points'))
ggdraw(p) + 
  draw_label('blah', x = 0.5, y = 0.97) + 
  draw_label('blah', x= 0.99, y= 0.5, angle = -90)
```