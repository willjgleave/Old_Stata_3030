// Will Gleave 	QAMO 3030  STATA PS3
// 2/11/21

clear all
cap log close
set more off

cd "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS3"

// 1. Start log file
log using Stata_PS3_GLEAVE_WILL.log, replace

// 2. Import and describe dataset
use "C:\Users\willj\OneDrive\Desktop\Econometrics 3030\StataPS3\birthweight_smoking.dta"
describe

// 3. Summary statistics
summarize
* a. 3382.934 grams is the average birthweight in general.
preserve
	drop if smoker== 0 
	summarize
restore
* b. 3178.832 grams is the average birthweight for smokers.
preserve
	drop if smoker== 1 
	summarize
restore
* c. 3432.06 grams is the average birthweight for non-smokers.

// 4. Tabstat usage
tabstat birthweight, by(smoker) s(mean sd min max)
* c. (3432.06)-(3178.832)=253.228

// 5.
ttest birthweight, by(smoker)
* c. 253.2284
* d. 26.95149
* e. [200.3831   306.0736]
* f. Yes, the value of 0.00 is smaller than .05 so we can conslude that there is a statistical difference between the groups.

// 6. 
reg birthweight smoker
outreg2 using Stata_3_output, excel replace ctitle("Bivariate")
* b. The estimated slope shows the effect of smoking on birthweight. This is the same as the answer for 5c. The intercept shows the average birthweight for the left out group which is non-smokers.
* c. Because birthweight is regressed on a binary variable, the SE of the slope is the same as the SE for the diff in means for the two groups.
* d. Yes, the P>|t| value of 0.00 for smoker is less than .05 ( five percent level).
* e. Yes, People will spend less money on smoking while pregnant since they will care about their childrens' birthweights.

/* 7.
It is unlikely that the smoking variable alone captures 100 of the variance we see in the two groups. I cannot however, think of any obvious alternate causes for such an apperant relationship.
*/

// 8. 
reg birthweight smoker alcohol nprevist
outreg2 using Stata_3_output, excel append ctitle("Multivariate")
* b. If there is covariance in the two variables in their relation to the birthweight variable, smoking would be overestimated as an effect on birthweight.
* c. Yes, it seems like omitting the alcohol variable has a large bias
* d. I suspect that there is a large correlation between smoker and alcohol. This may cause imperfect multicollinearity and SEs to be highly reactive to changes in the model.
* e. 3501 + (8)34.07 - 217.6 = 3105.96

// 9.
reg smoker alcohol nprevist
predict x1tilde, r
reg birthweight alcohol nprevist
predict ytilde, r
reg ytilde x1tilde
* f. The first regression holds constant the variation in the x2 x3... variables. Then the second shows teh correlation for the controlled residuals

// 10.
reg birthweight smoker alcohol tripre0 tripre2 tripre3
outreg2 using Stata_3_output, excel append ctitle("Tripre")
* b. Doing this avoids the DVT and redundancy
* c. Stata throws an error 
* d. It means that on average mothers who have no prenatal checkups give birth to much lighter children.
* e. These show the correlation of birthweight and the time at which the mother had her first prenatal visit.






log close

