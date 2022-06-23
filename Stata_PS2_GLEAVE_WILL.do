clear all
cap log close
set more off
 
 
cd "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS2"
log using Stata_PS2_GLEAVE_WILL.log, replace

// 3. import data
use "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS2\IPUMS_2012_ACS.dta"

// 4. personal income data
sum incearn, detail
count if incearn<0

* 4(b)	239 people have negative income. According to the IPUMS website, these data include the income from people opperating their own businesses at a loss. These people would have negative values.

gen earnings=incearn
replace earnings=. if incearn<=0

* 4(d) Using tab on earnings will display all of the values that are taken by the earnings variable in the data set. This set is too unruly to use well. 

* 4(e) drop if earnings<0
drop if earnings<0

// 6.
lookfor education
numlabel educd_lbl, add

// 7.
recode educd (1/2=0) (11/22=5) (23/25=7) (26/30=9) (40=10) (50=11) (61/64=12) (65=13) (71=13) (81=14) (101=16) (114=18) (115=18) (116=20), gen(edyears)

// 8.
tab edyears, sum(earnings)
* 8(a) The table shows that the majority of people surveyed finish highschool. There is also a large pay increase for those who finish 12 years of school. I suspect these are highly related.

* 8(b) This is a good point, we need consider that 4 year olds can't make very much money regardless of their future abilities. The general minimum working age in the US is 14.
//drop if age <14

// 9.
drop if age < 23
gen bdegree=1
replace bdegree=0 if edyears<16
tab bdegree, sum(earnings)
* 9(a) on average it seems that those with bachelor's degrees make over twice as much as those without.

// 10.
*---twoway (scatter earnings bdegree)
* 10(a) It looks stripe-y because we have a binary variable on the x axis. X cannot take an value between 0 and 1
twoway (scatter earnings edyears, mcolor(black))

// 11.
keep if age>=25
keep if age<=60

// 12.
reg earnings edyears 
* 12(a) B0 tells us the theoretical value of earnings when 0 years of schooling have been atteneded. B1 tells us how much earnings increasese for each year of education

// 13.
predict yhat
predict uhat, resid
browse
//twoway (line y edyears), ytitle(Income) xtitle(Years of Education)

// 14.
gen edmonths = edyears*10
reg earnings edmonths
* 14(a) The slope B1 gets smaller because the increments it uses are smaller now.
* 14(b) The intercept stays the same beause B1 is 0 in both cases so it has no effect.

// 15.
gen earn_cents = earnings*100
reg earn_cents edyears
* 15(c) The slope gets much much larger because of the change in unit
* 15(d) The intercept gets much larger because of the change in unit
* 15(e) The slope coefficent now shows the change in income (in cents) per each year of schooling completed

// 16.
gen earn_5 = earnings*5
gen edyears_5 = edyears*5
reg earn_5 edyears_5
* 16(a) The slope remained the same and the intercept halved.

// 17.
* No, these are all linear transofrmations of the same data. The reationship between earnings and schooling is fundementally the same.

// 18.
gen ln_earnings = ln(incearn)

// 19.
reg ln_earnings edyears
* 19(a) The new slope coefficent shows the percent change in earnings for each additional year of schooling attended.
* 19(b) The change to a percentage based model changes the interpretation of B1 compared to number 14.

// 20.
gen female = 0
replace female =1 if sex != 1
gen male = 1
replace male = 0 if female == 1
tab male, sum(earnings) 
tab female, sum(earnings) 
* tells us the average earnings for men and women.
reg earnings female

* 20(a) When female = 0 it shows the average earnings of the left out group (men).
* 20(b) The unit change in X shows the difference in a group where the dummy variable is true vs false.
* 20(c) The slope coeffeicent shows the average change in earnings from men to women.
reg earnings male
* 20(d) The data here is the same but the interpretation is framed from the other perspective. The slope is the additional earnings for being a man and the intercept is the mean earnings for women.
reg ln_earnings female 
* 20(e) The slope coefficent shows the percent change in earnings between men and women.


log close