clear all
cap log close
set more off

/*
	This is how you block comment
	across multiple 
	lines
*/

* #5: Change Working Directory	

	cd "/Users/u6019721/Box/Teaching/Econometrics/QAMO3030/Spring2021/lectures/W1_IntroMaterial/W1_Supplemental"

* #6: Start a log file

	log using Week1_IntroducingStata.log, replace

* #9: Load in Dataset
	use data/cps_96_15_clean.dta, clear

	
* #10: Describe the Dataset	
		
	describe

	
* #11: Load in CPIU Dataset	

	use data/cpiu.dta, clear

* #15: Merge Datsets together	

	* Merge with CPI-U Data to create real variable
		merge 1:m year using data/cps_96_15_clean.dta

* #16: Drop _merge variable 		
		drop _merge	/* merge stores the merge status of all variables	*/

* #17: Tabulate the year variable
		tab year

* #19: Tabulate sex
		tab sex

* #20: Tabulate without labels
		tab sex, nol
		
* #21: Generate real AHE variable
		gen realAHE_15=ahe*cpiu15
	
* #22/23: use summarize command
		summarize ahe realAHE_15
		
		sum ahe realAHE_15,d

* #24 : generate female
	gen female=.
		replace female=1 if sex==2
		replace female=0 if sex==1

* #25: generate male
	gen male=(sex==1)
	
* #26: cross tabulatoin
	tab sex male

* #27: dummy for young
	
	gen young=(age>=25 & age<=34)		
	label var young "Age 25 to 34"

* #28: summary with an if statement
	sum age if young==1

* #29: tabstat command by gender
	tabstat ahe, by(year) s(mean)

* #30: real average hourly earnings
	gen realAHE=ahe*cpiu15
	label var realAHE "Real Average Hourly Earnings, $2015"

* #31: compare means
	tabstat ahe realAHE, by(year) s(mean)

* #32 : realAHE by gender
	tabstat realAHE, by(sex) s(mean sd)

* #33 : realAHE by year
	tabstat realAHE, by(year) s(mean sd)

* #34 : realAHE by year [Male]
	tabstat realAHE if male==1, by(year) s(mean sd N)
	
* #35 : realAHE by year [Female]
	tabstat realAHE if female==1, by(year) s(mean sd N)
	
* #36 : using Stata's calculator functionality
	disp 33.90563/sqrt(18430)

* #37 : using the mean command instead [Male]
	mean realAHE if male==1 & year==2015

* #38 : using the mean command instead [Female]
	mean realAHE if female==1 & year==2015

* #39 : computing test statistic for null hypothesis of equality by gender
	ttest realAHE if year==2015, by(sex)
	
* #40 : computing test statistic for null hypothesis of equality by gender for young workers
	ttest realAHE if year==2015 & young==1, by(sex)	

* #41/42 : generate histogram of realAHE
	hist realAHE if year==2015
	graph save hist_realAHE_2015, replace
	graph export hist_realAHE_2015.png, as(png) replace
	
* #43 : use frequency option for histogram
	hist realAHE if year==2015, freq

* #44: bar graph by year
	graph bar (mean) realAHE, over(year)

* #45: bar graph by year, cleaning up labels
	graph bar (mean) realAHE, over(year, label(angle(45)))
	
* #46: bar graph by gender
	graph bar (mean) realAHE, over(sex)

* #47: bar graph by gender and year
	graph bar (mean) realAHE, over(sex) over(year)
	
* #47: bar graph by gender and year, cleaning up labels
	graph bar (mean) realAHE, over(sex, relabel(1 "M" 2 "F")) over(year, label(angle(45)))
	graph export realAHE_sex_year.png, as(png) replace

log close

