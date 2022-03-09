# Rutilitybelt

Some miscellaneous useful R code put together by Quentin for himself to use as ARS SEA statistician, and potentially for ARS scientists to use.

## How to install

Type this into your R prompt the first time you want to use this package, or if you want to get the latest package updates.

```
remotes::install_github('qdread/Rutilitybelt')
```

## How to load

Type this into your R prompt every time you want to run functions from this package.

```
library(Rutilitybelt)
```

## Dependencies

This package interacts with functions from several other common R packages, so it has several dependencies:

- `data.table`
- "tidyverse" packages
  + `tidyr`
- graphics and display packages
  + `ggplot2`
  + `gridExtra`
  + `knitr`
- stats packages
  + `emmeans`
  + `multcomp`
  
If you don't have any of these installed, they will install automatically when you install `Rutilitybelt`.

*last modified by QDR, 09 March 2022*

