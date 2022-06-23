// WIll Gleave u1173446

clear all
cap log close
set more off

// Start log, CD, and import data
cd "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS6"
log using Stata_PS6_GLEAVE_WILL.log, replace
use "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS6\dynarski.dta"

// 3.
describe 
* States: NC, SC, GA, FL, TN, AL.
* Years: 89, 90, 91, 92, 93, 94, 95, 96, 97.
* We must account for sampling bias in the data
* Average age is 18.4866
* 25.98 percent are black
* 71.15 percent are low income

// 4.
gen post = 0
replace post=1 if year > 93
label define postLabel 0 "Pre" 1 "Post"
label values post postLabel

gen GA = 0
replace GA=1 if state == 58
label define GALabel 0 "Control States" 1 "GA"
label values GA GALabel

gen postGA = post * GA

reg inCollege post GA postGA, robust
* .076629

// 6. 
predict yhat, r
graph bar yhat,over(GA) over(post) ytitle("College Enrollment")