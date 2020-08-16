#Case Study 2 Description
##

Analyst: Dawson

DDSAnalytics is an analytics company that specializes in talent management solutions for Fortune 100 companies.   
Talent management is defined as the iterative process of developing and retaining employees.   
It may include workforce planning, employee training programs, identifying high-potential employees and reducing/preventing voluntary employee turnover (attrition). To gain a competitive edge over its competition, DDSAnalytics is planning to leverage data science for talent management. The executive leadership has identified predicting employee turnover as its first application of data science for talent management. Before the business greenlights the project, they have tasked your data science team to conduct an analysis of existing employee data. 

Youtube(Presentation): https://youtu.be/1Cs0W_6meC8 
R-Shiny App(EDA): https://dawson-data-science.shinyapps.io/DDSCaseStudy2/

Tabs
- Data: csv(s) used in analysis
- Documentation: Provided context docuuments
- Presentation: Youtube & Powerpoint Files
- Rshiny: ui/server files
- RStudio: Rmd files and R related docs

Task Overview: 
DDSAnalytics: Specializes in talent management solutions for Fortune 100 companies. 
Talent management is defined as the iterative process of developing and retaining employees. 
Task: Predict employee turnover 
Perform EDA of existing employee data. 
Provide Job Role insights
Identify Top 3 Contributors & Predict Attrition (Sensitivity & Specificity > 66%)
Predict Monthly Salary (RMSE < $3000)


FYI: 
Data Definitions: 

JobInvolvement	1 'Low'
	2 'Medium'
	3 'High'
	4 'Very High'
	
JobSatisfaction	1 'Low'
	2 'Medium'
	3 'High'
	4 'Very High'
	
PerformanceRating	1 'Low'
	2 'Good'
	3 'Excellent'
	4 'Outstanding'
	
RelationshipSatisfaction	1 'Low'
	2 'Medium'
	3 'High'
	4 'Very High'
	
WorkLifeBalance	1 'Bad'
	2 'Good'
	3 'Better'
	4 'Best'



FAQ and Comments:

1.  Question: In the dataset, what does Relationship Satisfaction mean...(relationship to manager, to peers)

Relationship satisfaction with manager. 

2. Advice: Don't eliminate variables simply because they have a high correlation with one another.  This is an indication that they do share some information although the information they don't share may be correlated with the response individually.  

3. Advice: When plotting and exploring attrition, the percentage of those who left is probably more useful than the count.  

4. Question: In the dataset, is the distance from home in miles or kilos?
We don't have that information (however we do know whether its high or low)


5.  Question: In the dataset: what is the definition of pay rates: Hourly, Daily & Monthly.  These values to not seem to relate to each other or the Monthly Salary (which is different than Monthly Rate).
 
We don't have that information (however we do know whether they are high or low). They may or may not relate to each other or the monthly salary (this is for the student to infer and decide whether theres any correlation or whether this is a useful feature for attrition)

6. Question: In the dataset: we do see that Job Levels go from 1-5 and assume that 1 may symbolize a lower level employee, but this is not defined.  Though this level does have a positive linear relationship with Monthly Income, it does not seem to correlate well with the Job Titles. in other words someone with a Director can be a 2-5, and manager a 3-5.

Yes we can assume 1 is a lower job level than 5. 

7. Question: In the dataset, does overtime mean Hourly vs. Salaried worker?


We can assume that people with overtime are non-exempt employees. 

8 Question: In the dataset, Performance Ratings are only 3 & 4, is there a mistake?  Unless a corrupted system, hard to imagine ratings consistently high, even as 2 still means "good".
It is self-reported data, think about why the employees may only answer 3 and 4

No this is the only data we have, there is no mistake. 

9 Question: In the dataset, does Training times mean: hours, weeks, or instances and over what period?

Training times last year means number of training sessions attended by the employee. 

