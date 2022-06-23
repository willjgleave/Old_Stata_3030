// Will Gleave 	QAMO 3030  STATA PS3
// 2/18/21

clear all
cap log close
set more off

cd "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS4"

// Start log file and import data
log using Stata_PS4_GLEAVE_WILL.log, replace
use "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS4\fed_2012.dta"

// 1.
* a. The question is whether or not the Fed influences the elections of politcal officials.
* b. The data are Fed policies from the last 50 years
* c. The findings are that the Fed gives an advantage to conservative candidates.

// 3.
preserve
	drop if democrat == 0
	twoway (scatter FEDFUNDS quarters), title(Democrat in Office)
restore

preserve
	drop if democrat == 1
	twoway (scatter FEDFUNDS quarters), title(Republican in Office)
restore
* The dems seem to increase FFR has their terms come to in end and the republicans seem to have high FFR at the start and finish.

// 4. 
gen quartersXdemocrat = quarters*democrat

// 5.
reg FEDFUNDS quarters democrat quartersXdemocrat
* a. -0.2648658 
* b. -4.609
* c. Yes, it is.
lincom quarters+democrat+quartersXdemocrat
* d. Yes, it is.

// 6.
preserve
	drop if democrat == 0
	twoway lfit (FEDFUNDS quarters), title(Democrat in Office)
restore

preserve
	drop if democrat == 1
	twoway lfit (FEDFUNDS quarters), title(Republican in Office)
restore
* The democrat line goes down as quarter increase where the republican goes up.

// 7.
reg FEDFUNDS quarters democrat quartersXdemocrat lag_FEDFUNDS inflation
* a.  -.0230025 
* b. No, it is not.
* c. .0469915
* d. No, it is not.
* e. .1164818, it is statistically significant.
* f. .8892713, it is statistically significant.

log close