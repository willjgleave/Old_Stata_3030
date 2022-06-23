// WIll Gleave u1173446

clear all
cap log close
set more off

// Start log, CD, and import data
cd "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS5"
log using Stata_PS5_GLEAVE_WILL.log, replace
use "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS5\monthlyCPS_2020.dta"

// 3.
describe
/* there are 1,273,475 observations. Sex is of type byte. whyunemp is the reason an 
observed subject is unemployed.
*/

// 4.
tab month
* There are 117,239 observations in January, 101,605 in April, and 108,387 in December.
tab sex
* 51.31 percent of observations are female.
tab empstat month 
* At work in Jan: 54,511/117,239 = .465
* At work in April: 38,284/101,605 = .377

// 5.
drop if age < 25
drop if age > 54

gen female = 0
replace female=1 if sex==2

gen married = 0
replace married=1 if marst== 1 | 2

gen atwork = 0
replace atwork=1 if empstat == 10

gen notworking = .
replace notworking = 1 if empstat == 21
replace notworking = 1 if empstat == 22

gen bdegree = 0
replace bdegree=1 if educ>= 111

gen kidcount = 0
replace kidcount = 1 if nchild >0

gen underfive = 0
replace underfive =1 if yngch <5

// 6.
tabstat age sex labforce notworking married bdegree underfive [aw=wtfinl]

