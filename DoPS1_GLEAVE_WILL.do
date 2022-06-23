clear all
cap log close
set more off

/*
	Will Gleave u173446
	qamo 3030-001
*/

cd "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\PS1"
log using StataPS1_GLEAVE_WILL.log, replace

/* 1 a. CPS data is a monthly survey of household workforce participation. It is measured by the Bureau of Labor Statistics and helps us understand the employment rates and other important labor statistics in the US.
*/

log using "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\PS1\StataPS1_GLEAVE_WILL.log"

*PS 1: Introducing Stata.
describe

/* 7 a. 320,941 observations
     b. 96 var
	 c. County: A unique numeric FIPS code that describes the county the data is from.
	    Grade92: The highest grade the individual completed in schooling.
	 d.
*/ 
browse

*append data
append using "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\PS1\morg06.dta"
append using "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\PS1\morg13.dta"

tab year
browse
browse year state

*lookfor
lookfor marital
lookfor citizen

* 10 marital and prcitshp are the variable names

tab lfsr94
tab lfsr94, nolabel
browse year lfsr94
numlabel, add
tab lfsr94
sum lfsr94
* This is not useful because the data is catagorically organized 1-7. The SD and Mean mean nothing.
tab lfsr94, missing
* The ,missing option allows the inclusion of missing values.
tab lfsr94, nol


*gen unemployed var
generate unemployed = 0
replace unemployed = 1 if lfsr94>=3
drop unemployed
generate unemployed =(lfsr94>=3)

drop unemployed
generate unemployed = 0
replace unemployed = 1 if lfsr94>=3
replace unemployed = . if lfsr94==.
replace unemployed = . if lfsr>=5

drop if lfsr94>=5

* 12 a. Because stata sees missing variables as infinity, >5 will include missings

browse year lfsr94 unemployed
br year lfsr94 unemployed

sum unemployed
tab unemployed

* 16. The mean and percentage quantities both give a unemployment percentage of 5.85

summarize unemployed if year==2006
summarize unemployed if year==2009
summarize unemployed if year==2013
tab year unemployed
tab year unemployed, row nofreq

*make age catagories
replace agecat=2 if age>=30 & age<=39
replace agecat=3 if age>=40 & age<=49
replace agecat=4 if age>=50 & age<=59
replace agecat=5 if age>=60 & age<=69
replace agecat=6 if age>=70 & age<=79
replace agecat=7 if age>=80 & age<=89
tab agecat

label define ageLab 1 "age 20-29" 2 "age 30-29" 3 "age 40-49" 4 "age 50-59" 
lael values agecat ageLab 
tab agecat

tab agecat year
tab agecat year, sum(unemployed)
tab agecat year, sum(unemployed) nofreq

log close

