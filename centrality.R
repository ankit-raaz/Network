set.seed(1)
library(ergm)
library(intergraph)
library(igraph)
data("faux.dixon.high")
detach(package:ergm)
detach(package:network)
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

close_vector<- closeness(dixon)

summary(close_vector)
hist(close_vector, breaks = 20)

hist(close_vector[close_vector>0.00005], breaks=20)

## If we don't specify in/out degree - it defaults to "out" degree.
close_vector_in <- closeness(dixon, mode = "in")
close_vector_out <- closeness(dixon, mode = "out")
hist(close_vector, breaks=20)
hist(close_vector_in, breaks=20)
hist(close_vector_out, breaks=20)

betweenness_vector <- betweenness(dixon)
summary(betweenness_vector)
hist(betweenness_vector, breaks=20)

## Comparing Centrality Measures:
cents <- data.frame(degree_vector, in_degree_vector, out_degree_vector,
                    betweenness_vector, close_vector, eig, pr)
plot(cents)  # So what the heck does this tell us?
#  well we can see graphically and using the correlation (cor()) function: that almost all graphs
#    are trending positive. That is, there is no shockingly different graph that raises our eyebrow
cor(cents)


#Visualize Centrality:
  
dlayout <- layout.fruchterman.reingold(dixon)
library(scales)  # for the rescale() function -- helps scale all centrality measures

  ## Plotting in-degree, with vertices showing grade
  plot(dixon,
       vertex.color = V(dixon)$grade,
       vertex.size = rescale(in_degree_vector, c(2,9)),
       edge.arrow.size = 0.25,
       edge.width = 0.5,
       vertex.label = NA,
       layout = dlayout)
  ## A legend to help make sense of the colouring;
  legend("topright",
         legend = 7:12,
         pch = 19,
         col = categorical_pal(8)[c(7,8,1,2,3,4)])
  #  So what does this tell us?
  #    1. popular kids in every grade (clusering via color)
  #    2.  9th grade seem to be very tightly packed, 11th grade very spread out.
  
  
