# rstfuns - My personal R-Package

This is my personal R-Package containing various short functions I wrote for various projects, mostly concerning topics of political science.

## Installation:

Installation of `rstfuns` requires `devtools`. If `devtools` is installed `rstfuns` can be installed using:

```
devtools::install_github("https://github.com/RStelzle/rstfuns", dependencies = T)
library(rstfuns)
```

## Available functions:

### Roll-Call-Data:

Roll-Call-Data is one of the workhorse-data-sources of the sociology of legaslatures, as it is -depending on the legislative body of interest- relatively accessible. One topic of interest to be tackled with Roll-Call-Data might be cohesion or discipline (for a distinction of the two see Özbudun (1970)) of parliamentary groups. For questions of this kind `rstfuns` contains two functions `calc_attina_index()` and `calc_rice_index()`. Both indices can be used to measure cohesion within a set of legislators for a given vote.

That being said, Roll-Call-Data should not be analysed without a word of caution: As roll-call-votes are not staged randomly, any inferences taken from a sample of roll-call-votes on the population of all votes are built on shaky grounds. For a great overview see Carrubba et al. (2006).

#### `calc_attina_index()`

`calc_attina_index()` is used to calculate "Attina's index of agreement" (see Attina (1990: pp. 564f.)). Attina's index of agreement can be used for votes with the option to abstain from the vote, like in the European Paraliament. `calc_attina_index()` takes a vector (max. `length()` = 3) of the amount/share of votes for "yes", "no" and "abstain". When the vector is shorter than `length() = 3`  it is assumed that no legislators voted for the missing option(s).

Attina's index of agreement results values from -33.333 to 100. A value of 100 represents a unanimous vote. Positive values result, if more than half of the votes were casted for one and the same option. -33.33 means, that equal shares of legislatures voted for "yes", "no" and "abstain".

`calc_attina_index()` takes the optional argument `rescale` (default = `FALSE`). If set to `TRUE`, `calc_attina_index()`'s results get rescaled to a scale of 0-1 (for exaple used in Hix, Noury and Roland (2005)). A value of 0.25 now represents that 50% of the values were casted for one of the options.

#### `calc_rice_index()`
`calc_rice_index()` is used to calculate the "Rice Index" as defined in Rice (1925: pp. 62f.). It can be used for votes without an option to abstain. Therefore `calc_rice_index()` only takes a vector of max. `length()` = 2. The Rice Index varies between 1 (all votes where casted for the same option) and 0 (votes where evenly split between "yes" and "no").


## Literature:


Attina, Fulvio. "The Voting Behaviour of the European Parliament Members and the Problem of the Europarties". European Journal of Political Research 18, Nr. 5 (1990): 557–579. [DOI](https://doi.org/10.1111/j.1475-6765.1990.tb00248.x).

Carrubba, Clifford J., Matthew Gabel, Lacey Murrah, Ryan Clough, Elizabeth Montgomery and Rebecca Schambach. "Off the Record: Unrecorded Legislative Votes, Selection Bias and Roll-Call Vote Analysis". British Journal of Political Science 36, Nr. 4 (2006): 691–704. [DOI](htpps://doi.org/10.1017/S0007123406000366).


Hix, Simon, Abdul Noury, und Gérard Roland. "Power to the Parties: Cohesion and Competition in the European Parliament, 1979–2001". British Journal of Political Science 35, Nr. 2 (2005): 209–234. [DOI](https://doi.org/10.1017/S0007123405000128).

Özbudun, Ergun. "Party cohesion in western democracies: a causal analysis". Sage professional papers in Comparative politics 1, Nr. 6 (1970): 303–388.

Rice, Stuart A. "The Behavior of Legislative Groups: A Method of Measurement". Political Science Quarterly 40, Nr. 1 (1925): 60–72. [DOI](https://doi.org/10.2307/2142407).
