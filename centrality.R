set.seed(1)
library(ergm)
library(intergraph)
data("faux.dixon.high")
dixon<-asIgraph(faux.dixon.high)

summary(dixon)
graph.density(dixon)
plot(dixon)
plot(dixon, vertex.label=NA, edge.arrow.size=0.25, vertex.size=5, edge.width=.5)

table(V(dixon)$grade)
table(V(dixon)$race)
table(V(dixon)$sex)

degree_vector<-degree(dixon)
head(degree_vector)
summary(degree_vector)

in_degree_vector <- degree(dixon, mode="in") # added argument we're now looking at in-degrees
summary(in_degree_vector)

# can use base R hist() fuction to quickly see distribution visually:
hist(in_degree_vector, breaks = 20)


out_degree_vector <- degree(dixon, mode="out") # now we're looking at outward degree centrality
summary(out_degree_vector)

hist(out_degree_vector, breaks = 20)
#  So what did this form of centrality really tell us? Long right skew, but about same in/out

eig<-evcent(dixon)$vector
summary(eig)
hist(eig, breaks = 20)

pr<-page.rank(dixon)$vector
summary(pr)
hist(pr, breaks=20)


