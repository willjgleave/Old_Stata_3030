// WIll Gleave u1173446

clear all
cap log close
set more off

// Start log, CD, and import data
cd "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS8"
log using Stata_PS8_GLEAVE_WILL.log, replace
use "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS8\income_democracy.dta"

// 3.
describe
*variables are: country, year, dem_ind, log_gdppc, log_pop, age_1, age_2, age_3, age_4, age_5, educ, age_median, and code.

// 4.
sum dem_ind, detail
* mean is .499, median is .5

tab country, sum(dem_ind)
*Turkmenistan, Uzbekistan, and Vietnam have mean values of 0.
*Australia, Belgium, and Canada (Among others) have a mean value of 1

// 5.
sort country year
egen dem_average=mean(dem_ind)

// 6.
bysort country: egen dem_c_avg=mean(dem_ind)
bysort country: egen gdp_c_avg=mean(log_gdppc)

// 7.
/*
#delimit ;
twoway (scatter dem_c_avg gdp_c_avg) (lfit dem_c_avg gdp_c_avg),
title("Democracy and Income")
subtitle("averages 1960-2000")
ytitle("Democracy Index")
xtitle("Log GDP per capita")
legend(off)
name(c_averages, replace);
#delimit cr


preserve

drop if year != 1990
#delimit ;
twoway (scatter dem_c_avg gdp_c_avg) (lfit dem_c_avg gdp_c_avg),
title("Democracy and Income")
subtitle("averages 1990")
ytitle("Democracy Index")
xtitle("Log GDP per capita")
legend(off)
name(c_averages, replace);
#delimit cr

restore
*/

// 8.
reg dem_ind log_gdppc, robust
outreg2 using panelOutreg, excel replace

// 9.
reg dem_ind log_gdppc, vce(cluster country)
outreg2 using panelOutreg, excel append ctitle(2)

* The coefficents for the variables are the same. However, the standard errors increase for both.

// 10.
* The coeffeicnt shows the percentge effect of gdp on the dem index of a country.

// 11.
**xtset country year
*This doesn't work becasue country is of type string.
egen country_id=group(country)

xtset country_id year

// 12.
gen gdp_lag7095=L25.log_gdppc if year==1995
gen gdp_diff_7095= gdp_lag7095- log_gdppc

gen dem_lag7095=L25.dem_ind if year==1995
gen dem_diff_7095= dem_lag7095- dem_ind

// 13.
#delimit ;
twoway (scatter dem_diff_7095 gdp_diff_7095) (lfit dem_diff_7095 gdp_diff_7095),
title("Democracy and Income")
subtitle("Differences")
ytitle("Democracy Index")
xtitle("Log GDP per capita")
legend(off)
name(c_averages, replace);
#delimit cr
* The lfit line is horizontal

// 14.
tab country, gen(c_dummy) 
drop c_dummy1
reg dem_ind log_gdppc c_dummy*, vce(cluster country)
outreg2 using panelOutreg, excel append ctitle(dummy) keep(log_gdppc)

// 15.
xtreg dem_ind log_gdppc, fe
outreg2 using panelOutreg, excel append ctitle(xtreg) keep(log_gdppc)









log close