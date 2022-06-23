// WIll Gleave u1173446

clear all
cap log close
set more off

// Start log, CD, and import data
cd "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS7"
log using Stata_PS7_GLEAVE_WILL.log, replace
use "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS7\employment_08_09.dta"

// 3.
describe
* the average age is 42.6
* 87% are employed in 2009
 
// 4. 
gen age2 = (age*age)
gen ln_earnwke = log(earnwke)
gen highschool = educ_lths+educ_hs
gen college = 0
replace college=1 if educ_somecol == 1
replace college=1 if educ_aa == 1
replace college=1 if educ_bac == 1
gen gradschool = 0
replace gradschool = 1 if educ_adv == 1
replace gradschool = 1 if educ_bac == 1
gen white = 0
replace white = 1 if race == 1
gen black = 0 
replace black = 1 if race == 1
gen other = 0
replace other = 1 if race == 1

// 5.
*a 34.39 percent has at most a highschool degree
*b 52.75 has attended college
*c 34.94 attened grad school

// 6.
*twoway lfit employed age || scatter employed age

// 7.
reg employed age age2, robust
outreg2 using binaryOutreg, excel replace ctitle(LPM 1)
*b. 24.5 is the determinant age for employment according to the model
*c. yes people who are unemployed past a ceratin point are unlikely to become employed. Also people are more likely to start employement at different points in life

*f. A 20 y/o worker has a predicted employment probability of .75
*   A 40 y/o worker has a predicted employment probability of .95
*   A 60 y/o worker has a predicted employment probability of .83

*g The regression does suffer from OVB. accounting for race and sex would help this.

*h
reg employed age age2 female, robust
outreg2 using binaryOutreg, excel append ctitle(LPM 2)

*i 
reg employed age age2 female ln_earnwke black other college gradschool, robust
outreg2 using binaryOutreg, excel append ctitle(LPM 3)

*j. The age is still a valuable predictor of employment but its coeffeicent has decreased slightly meaning it is less influencial on the proabilibility of employement

// 8.
probit employed age age2, robust
outreg2 using binaryOutreg, excel append ctitle(P1)
probit employed age age2 female, robust
outreg2 using binaryOutreg, excel append ctitle(P2)
probit employed age age2 female ln_earnwke black other college gradschool, robust
outreg2 using binaryOutreg, excel append ctitle(P3)

// 9.
margins, dydx(*) post atmeans
outreg2 using PS8_Solns, excel replace ctitle(P3_margins)
*a. a year increase in age increases the proabilibility of employment by 1.8 percentage points
*b. no. the percent point change is small

// 10.
logit employed age age2, robust
outreg2 using binaryOutreg, excel append ctitle(L1)
logit employed age age2 female, robust
outreg2 using binaryOutreg, excel append ctitle(L2)
logit employed age age2 female ln_earnwke black other college gradschool, robust
outreg2 using binaryOutreg, excel append ctitle(L3)

* d. The outputs have positive signs meaning additional years of age increase probability of employment

* e.
margins, dydx(*) post atmeans
outreg2 using PS8_Solns, excel append ctitle(L3_margins)

*f. a year increase in age increases the proabilibility of employment by 1.7 percentage points
*f. no. the percent point change is small


log close
