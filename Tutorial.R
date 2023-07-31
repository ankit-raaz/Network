# This is from igraph tutorial by Kaylee Davis

library(igraph)
# install.packages("igraphdata")
library(igraphdata)
set.seed(8675309)
# Manually entering Network Data/ viewing networks -----------------------------

# Edge-Lists
# Entering Edge-List data manually (works fine for now).
g1<-graph(edges=c(1,2,
                  1,3,
                  2,4,
                  3,1,
                  3,5,
                  5,1,
                  4,3))
summary(g1)
plot(g1)

g2 <- graph(edges=c("Anand","Beth",
                    "Anand","Chris",
                    "Beth","Dieter",
                    "Chris","Sun",
                    "Chris","Ali",
                    "Beth","Ali",
                    "Ali","Sun",
                    "Sun","Beth",
                    "Fatima","Chris",
                    "Fatima","Sun"),
            directed=FALSE)
plot(g2)
summary(g2)

get.adjacency(g2)
get.adjacency(g1)

E(g1)
V(g1)
E(g2)
V(g2)$name

V(g2)$gender <- c("M","F","M","M","F","M","F") # Here, we're assigning the gender for each vertex.
V(g2)$gender
g2

g2 <- set.vertex.attribute(g2, "age", value = c(20,26,19,34,22,30,21))
V(g2)$age


# Or we'll assign some arbitrary weights to the edges (notice the E(g2) now.)
E(g2)$count <- rep(1:2,5)
E(g2)$count

summary(g2)

data("karate")
plot(karate)
vcount(karate)
ecount(karate)
summary(karate)

?degree()
mean(degree(karate))

graph.density(karate)
#denisty is  (Actual Connections/Potential Connections)
farthest_vertices(karate)

plot(karate,
     edge.width = E(karate)$weight,
     vertex.size = degree(karate)*1.5,
     edge.arrow.size = 0.4,
     vertex.label.cex = 0.7)

## Bipartide Networks: ---------------------------------------------------------
# This is where you have the relationship between nodes be that they are connected
#   to another party. (I worked with Jim, and so did you, so we're connected)


# Load data:
mem <- matrix(data = c(1,1,1,1,0,
                       0,1,1,0,0,
                       0,0,0,1,1),
              nrow = 3,
              byrow = TRUE)

# This is assigning the names first to the 3 rows, and then to the 5 columns
dimnames(mem) <- list(c("Group1","Group2","Group3"),
                      c("Y1","Y2","Y3","Y4","Y5"))
mem
bg<-graph.incidence(mem)
bg
plot(bg)

pr<-bipartite.projection(bg)

plot(pr$proj1, edge.width = E(pr$proj1)$weight)
plot(pr$proj2, edge.width = E(pr$proj2)$weight)

# Can get adjancency matrix for these if we need:
get.adjacency(pr$proj1, sparse = FALSE, attr = "weight")
get.adjacency(pr$proj2, sparse = FALSE, attr = "weight")

