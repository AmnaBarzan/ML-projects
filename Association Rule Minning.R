title: "Identifying frequently purchased groceries with association rules"
output: html_notebook
---

#Step 1 - collecting data
library(arules)

#Step 2 - exploring and preparing the data
data(Groceries)
Groceries
head(Groceries)
names(Groceries)

summary(Groceries)

inspect(Groceries[1:5])

itemFrequency(Groceries[,1:3])

#Visualizing item support - item frequency plots
itemFrequencyPlot(Groceries, support= 0.1)
itemFrequencyPlot(Groceries, topN = 20)

#Visualizing the transaction data - plotting the sparse matrix
image(Groceries[1:5])

#not useful for large transaction databases, you can view for randomly sampled set of transactions. 100rows & 169 columns.
image(sample(Groceries,100))

apriori(Groceries) 
#o rules couz 0.1 support. the item must have appeared in atleast 0.1*9,385=938.5 transactions. Since, only eight items appeared this frequently in our data, it's no wonder we didn't find any rules.

groceryrules <- apriori(Groceries,                             
                        parameter = list(support = 0.006),    
                        confidence = 0.25,                     
                        minlen = 2)   
groceryrules
summary(groceryrules)
inspect(groceryrules[1:3])
inspect(sort(groceryrules, by = "lift") [1:5])

#Visualize
library(arulesViz)
plot(groceryrules)
#################plot(rules@quality)
library(arules)
plotly_arules(groceryrules)


ruleExplorer(groceryrules) 

#Analyze
berryrules <- subset(groceryrules,
                     items %in% "berries")    
inspect(berryrules)

fruits <- subset(groceryrules,
                 items %pin% "fruit")
inspect(fruits)

complete_matching <- subset(groceryrules,
                            items %ain% c("berries","yogurt"))
inspect(complete_matching)



