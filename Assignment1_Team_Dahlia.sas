/************************************************
* Assignment No. 1
* Team Member #1: 	Sushil Kharel 		
* Team Member #2: 	Raghav Sharda 		
* Team Member #3: 	Jing Zhang			
* Team Member #4: 	Haoran Ma			
* Team Member #5: 	Stephen LaPierre	
*
* Mark				__________/__________
*************************************************/


/************************************************
* Assignment 1, Question 1 by Sushil Kharel
*************************************************/

proc print data=Stock;
var Stock PurDate PurPrice Number SellDate SellPrice TotalPur TotalSell Profit;
run;


*a)	Copy and paste the  program below into SAS editor. Debug it to create work.newemps  dataset and format Salary  with $ sign and 2 decimals for cents. 
b)	Print the data set work.newemps
c)	Print descriptor part of the dataset using proc contents.  What are the types, length and format of the variables in this dataset? 
data work.newemps;

data work.newemps;
input First_Name$ Last_Name$ Job_Title$ Salary;
datalines ;
Steven Worton Auditor 40450
Merle Hieds Trainee 24025
John Smith Manager 35666
;
run;

* Work.newemps dataset with Salary formatted;

title "work.newemps";
proc print data=work.newemps;
format Salary dollar8.3;
run;
*Summarized Report of the Content of the work.newemps dataset;

proc contents data=work.newemps;
run;

/***************************************************
*Assignment 1, Question 2 by Stephen LaPierre
****************************************************/
/*
Part a - Insertion of missing code to process data
*/

*create permanent dataset and save to course directory;
libname Assign1 'C:\445\course_data';

data Assign1.Survey2007;

input 	@1	Age	 	 2.
		@4	Gender 	$1.
		@6	Q1		 1.
		@7	Q2		 1.
		@8	Q3		 1.
		@9	Q4		 1.
		@10	Q5		 1.
;

datalines;
23 M  5243
30 F 11123
42 M 23555
48 F 55531
55 F 4 232
62 F 3333 
68 M 4412 
;
run;

*Print to validate data management;
title1 "Survey2007 Results";
title2 "(1 = strongly agree, 5 = strongly disagree)";

proc print data=Assign1.Survey2007;
run;

*Part b;
*Print to validate data management;

title1 "Survey2007 Results";
title2 "Disatisfied Women Over 40";
title3 "Who Answered 5 on Q1 & Q3";
proc print data=Assign1.Survey2007;
	where Gender = 'F';
	where Age in (41 99);
	where (Q1=5) and (Q3=5);
run;

/*********************************************************
* Assignment 1, Question 3 by Stephen LaPierre
**********************************************************/

data Assign1.TrueFalse;
input 	@1	Question			$1.
		@3	Answer				$5.
		@9	False_Reason		$40.
		;

datalines;
A True
B False Must end with a semi-colon
C True
D True
E False Varaibles cannot contain dashes
F False Default numeric storage is 8 bytes
G True
H False Default is a period for missing data
I True
J True
;
run;

title1 "Assignment1 Question 3 True or False Answers";
proc print data=Assign1.TrueFalse;
run;



/***************************************************
*Textbook Question 3.6 by Sushil Kharel
****************************************************/
/*
Create a temporary SAS data set called Bank using this data file (bankdata.txt). Use column input to
specify the location of each value. Include in this data set a variable called Interest
computed by multiplying Balance by Rate. List the contents of this data set using
PROC PRINT 
*/

data Bank;
infile 'C:\445\course_data\bankdata.txt';
input 	Name			$	1-15
		Account_Number	$	16-20
		Account_Balance		21-26
		Interest_Rate       27-30;
Interest_Balance = Account_Balance*Interest_Rate;	
run;

title " Interest_for_Each_Individual";
proc print data=Bank;
var Name Account_Number Interest_Balance;
run;



proc print data = Assign1.Bank;
run;

/***************************************************
*Textbook Question 3.10 by Sushil Kharel
****************************************************/

/* 
You are given a text file called stockprices.txt containing information on the
purchase and sale of stocks. The data layout is as follows
*/

data Stock;
 infile 'C:\445\course_data\stockprices.txt';
input 	@1 Stock $	4.
		@5 PurDate  mmddyy10.
		@16 PurPrice dollar6.2
		@22 Number 3.
		@25 SellDate mmddyy10.
		@35 SellPrice dollar6.2;
TotalPur=Number*PurPrice;
TotalSell=Number*SellPrice;
Profit=TotalSell-TotalPur;
run;


title 'stockprice data set';
proc print data=stock;
	format 	PurDate 	mmddyy10.
			PurPrice 	dollar6.2
			SellDate 	mmddyy10.
			SellPrice	 dollar6.2
			TotalPur 	dollar11.2
			TotalSell	dollar11.2
			Profit		dollar11.2
			;
run;

/*****************************************************
*Textbook question 5.2 by Stephen LaPierre
******************************************************/

proc format; *format code provided from question 5.1;
   value agegrp 	0 - 30 		= '0 to 30'
               		31 - 50 	= '31 to 50'
               		51 - 70 	= '50 to 70'
               		71 - high	= '71 and older';
   value $party 	'D' 		= 'Democrat'
                	'R' 		= 'Republican';
   value $likert 	'1'		 	= 'Strongly Disagree'
					'2' 		= 'Disagree'
					'3' 		= 'No Opinion'
                 	'4'		 	= 'Agree'
					'5'			= 'Strongly Agree';
                 
run;

data voter; *Data code provided from question 5.1;
   input Age Party : $1. (Ques1-Ques4)($1. + 1);
   label Ques1 = 'The president is doing a good job'
         Ques2 = 'Congress is doing a good job'
         Ques3 = 'Taxes are too high'
         Ques4 = 'Government should cut spending';
   format Age agegrp.
          Party $party.
          Ques1-Ques4 $likert.;
datalines;
23 D 1 1 2 2
45 R 5 5 4 1
67 D 2 4 3 3
39 R 4 4 4 4
19 D 2 1 2 1
75 D 3 3 2 3
57 R 4 3 4 4
;


*Specialized formating for the frequency modifications. Grouping positive and negative views together; 
proc format;
value $forassig 	'1'-'2'		 	= 'Generally Disagree'
					'3' 			= 'No Opinion'
					'4'-'5' 		= 'Generally Agree';
run;

title "Frequencies on the Four Questions";
proc freq data=voter;
   tables Ques1-Ques4;
   format Ques1-Ques4 $forassig.; *apply special grouping format to the table;
run;

/***************************************************
*Textbook question 5.3 by Stephen LaPierre
****************************************************/

libname Myforms 'C:\445\course_data';
options fmtsearch = (Myforms Work);

data Assign1.voter;
	input Age Party : $1. (Ques1-Ques4)($1. + 1);
   	label Ques1 = 'The president is doing a good job'
          Ques2 = 'Congress is doing a good job'
          Ques3 = 'Taxes are too high'
          Ques4 = 'Government should cut spending';
  	format Age agegrp.
           Party $party.
           Ques1-Ques4 $likert.;
datalines;
23 D 1 1 2 2
45 R 5 5 4 1
67 D 2 4 3 3
39 R 4 4 4 4
19 D 2 1 2 1
75 D 3 3 2 3
57 R 4 3 4 4
;
run;

proc format library=Myforms;
value $forassig 	'1'-'2'		 	= 'Generally Disagree'
					'3' 			= 'No Opinion'
					'4'-'5' 		= 'Generally Agree';
run;

title "Format Definitions in the Myforms Library";

proc format library=Myforms fmtlib;
run;

/****************************************************
*Textbook question 6.2 by Raghav Sharda
*****************************************************/

data soccer;
	input Team : $20. Wins Losses;
datalines;
Readington 20 3
Raritan 10 10
Branchburg 3 18
Somerville 5 18
;
options nodate nonumber;
title;
ods listing close;
ods csv file= 'C:\445\course_data\soccer.csv';
proc print data=soccer noobs;
run;
ods csv close;
ods listing;

/****************************************************
*Textbook question 7.6 by Raghav Sharda
*****************************************************/

title "Selected Sales Observations";

proc print data=Assign1.sales_2010 noobs;
where Region eq "North" and Quantity le 60 or Customer eq "Pet's are Our's";
run;

/***************************************************
*Textbook Question 8.14 by Sushil Kharel
****************************************************/

/*
Generate a table of integers and squares starting at 1 and ending when the square
value is greater than 100. Use either a DO UNTIL or DO WHILE statement to
accomplish this.

y= squares
n= integers
f = number of iterations
*/

data square;
f=0;
y=1;
do until (y gt 100);
n+1;
f = f +1;
y = f*f; 
output;
end;
run;

title "Listing of Integers and Squares";
proc print data=square noobs;
var n f y;
run;

proc gplot data=square;
plot y*n;
run;

/**********************************************
*Textbook Question 9.6 by Jing Zhang
***********************************************/

*libname learn 'C:\445\Course_data';
data freq_medical;
set Assign1.medical;
Day = weekday(VisitDate);
Month = Month(VisitDate);
format day 2. month 2.;
run;

proc freq data=freq_medical;
tables day /nocum;
run;

/**********************************************
*Textbook Question 9.10 by Jing Zhang
***********************************************/

data hosp1;
set Assign1.hosp;
MonthsDec = intck('month',AdmitDate,'31Dec2007'd);
MonthsToday=intck('month',AdmitDate,Today());
run;

proc print data=hosp1 obs=20;
run;

/**********************************************
*Textbook Question 9.12 by Jing Zhang
***********************************************/

data medical_912;
set Assign1.medical;
Followdate=intnx('week',VisitDate,5,'sameday');
format followdate mmddyy10.;
run;

proc print data=medical_912;
var Patno Visitdate Followdate;
run;

/**********************************************
*Textbook Question 10.10 by Haoran Ma
***********************************************/

data purchase;
set Assign1.purchase_sort;
run;
data inventory;
set Assign1.inventory;
run;
proc sort data=purchase_sort;
by model;
run;
proc sort data=inventory;
by model;
run;
data combine;
merge purchase inventory;
by model;
run;
title "purchase and inventory combine";
proc print data=combine;
run;


data notpurchased;
merge inventory(in=InInventory) 
purchase(in=InPurchase);
by Model;
if InInventory and not InPurchase;
keep Model Price;
run;
title "Listing of NOT PURCHASED";
proc print data=notpurchased;
run;

/**********************************************
*Textbook Question 10.12 by Haoran Ma
***********************************************/

data demographic;
set Assign1.demographic;
run;
data survey;
set Assign1.survey1;
run;
proc sort data=demographic;
by ID;
run;
proc sort data=survey;
by Subj;
run;
data combine;
merge demographic 
	  survey(rename=(subj=ID));
by ID;
run;
title "demographic and survey combine";
proc print data=combine;
run;
