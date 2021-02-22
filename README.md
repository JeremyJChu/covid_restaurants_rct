# Peel Restaurants See Improved Business and Positivity Reopening for Restricted In-Person Dining with Vaccinated Workers - A Stratified Clustered Randomized Trial
What would happen if the government of Ontario could run a Randomized Control Trial on restaurants reopening? This project is a simulation of that reality. 

The context is as follows: Posing as a polling company (Petit Poll Canada), we were given anywhere between 5,000 - 10,000 vaccines to design an experiment for an intervention of any kind to try and help the restaurant industry. The report and project details the steps we would have taken if this scenario came true, from choosing the intervention, calculating the scope and sample size, the logistics of implementing the intervention, to evaluation the effects of the intervention. While survey responses are simulated, they are based on actual survey data from other organizations such as Restaurants Canada to paint a realistic what-if scenario.

The report is designed to appeal to policy makers and statisticians alike, though leaning towards a more general audience with little to no understanding of statistical terms.

The paper can be found [here](https://github.com/JeremyJChu/covid_restaurants_rct/blob/main/outputs/paper/covid-restaurants-rct.pdf).

## The Surveys
We created 3 surveys. A scoping survey to determine our sample and scope, an intervention survey sent to the treatment group at the end of the intervention, and a control survey for the control group at the end of the intervention. Our calculations landed on 500 for the treatment group and 1002 for the control group. Surveys were created using the free version of Typeform.

- [Scoping Survey](https://c1m2jwzr5dk.typeform.com/to/GomHmnnL)
- [Intervention Survey](https://c1m2jwzr5dk.typeform.com/to/r98QZqE6)
- [Control Survey](https://c1m2jwzr5dk.typeform.com/to/YMR7bXHD)

## Packages
This project was done entirely with R through R Studio. Results were knitted into a pdf through R Markdown. Packages used:
- tidyverse
- here
- bookdown
- grid
- gridExtra
- gghighlight
- ggpubr
- kableExtra
- knitr
- magick
- oddsratio

## Setup
R Markdown was setup using the following settings:
```
classoption: table
output: bookdown::pdf_document2
header-includes: 
  \usepackage{float}
  \usepackage{colortbl} 
  \arrayrulecolor{white}
```

## How to Use 
The project is entirely reproducible. All data downloading, cleaning, and transformation are performed and segmented in the [scripts](scripts) folder. The [R Markdown](outputs/paper) sources all the scripts using the library `here`, so simply clone the repo and everything will run accordingly.

I have also taken the liberty in saving all the raw and cleaned datasets and stored them [here](inputs/data). The R Markdown contains the both options of either running the scripts or reading in the data from inputs, simply comment/uncomment the parts you would like to run. Clone the repo and everything will be there. 

## Changelog
2021-02-21
- Pushed first edited version. Currently missing peer review. Testing tbd on reproducibility on another comptuer 

## Meta
Jeremy Chu - [@Jeremyjchu](https://twitter.com/Jeremyjchu) - [jeremychuj@gmail.com](jeremychuj@gmail.com)

Distributed under the MIT License. See `LICENSE` for more information. 

https://github.com/JeremyJChu

## Credits
[Rohan Alexander](https://rohanalexander.com/) for support. 




