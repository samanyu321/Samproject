1.	Clustering Case Study
Problem Statement :-
    Here in this case study, I had to analyse how and whom to extend humanitarian aid being raised by an NGO through Unsupervised K-means clustering, Hierarchical clustering
What I did :-
    a. First I did data quality check to find any NULL values, then EDA(Univariate & Bivariate Analysis) to find the distribution of error terms and bi-variate to find the
       correlation between independent variables , outlier analysis, Standard Scaling
    b. Then I used Hopkins statistics to find if the dataset is suitable for clustering, Silhoutte plot to find highest silhouette point and optimal number of K means cluster          and Elbow curve to find the point after which the distortion start decreasing in linear fashion. 
    c. Then I did K-means cluster profiling by creating Bar chart comparison of child mortality rate, income and gdp of the nation to find the groups which are in dire need of          aids.
    d. Then I did Hierarchical cluster profiling based on single and complete linkage to find the shortest and longest distance between points in cluster and made 5 clusters and        put countries under each cluster and then plotted a scatterplot. After this we plotted barplot to find the cluster having high child mortality, low income and low gdpp
Conclusion :-
    Finally we concluded by identifying top 5 countries for funding of humanitarian AID

2. Online Education company case study
Problem Statement :-
    An online education company wants to sell online courses to the industry professional who check the courses by visiting the website. So need to find out the potential leads     by identifying top 3 variables which can help in leads getting converted
What I did :-
    a.	First check the data for understanding purpose
    b.	I did Data cleaning  by dropping the NULL values more than 45% and dropped highly skewed values and imputed numerical with median values 
    c.	I did EDA through Univariate and Bi-variate analysis and outlier analysis
    d.	I did train test split and scaled the data through standardised scaling
    e.	After that I did Data modelling through mixed analysis , first through RFE and then through Manual approach to find the optimal set of data through GLM and VIF to reduce
        the number of variables less than 15. Also plotted a ROC curve to find the cut-off value
    f.	Also I did precision to find the positive rate and recall to find the positive predicted value
Conclusion :-
    After doing the analysis on confusion matrix, I found out that top 3 variables responsible for lead conversion.

3.	SQL Case Study
Problem Statement :-
    In the case study, I had to suggest an Indian film production company, RSVP movies their next project, they are planning to release a movie for the global audience in 2022.
What I did :-
    We ran queries on SQL to derive insights from the data.
Conclusion :-
    a. We came to a conclusion that Drama genre should be preferred by the company having average movie duration of 106.77 minutes.
    b. Month of March witnesses maximum release so they should also release the film during this month.
    c. They should collaborate with Marvel Movies, Dream Warrior Pictures and National Theater Live for producing films.
