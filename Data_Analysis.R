## Russian Trolls ##

# setwd("~/Desktop/russian-troll-tweets")

## This script used an earlier version of the russian-troll-tweets repository that had the tweets in one large file.  This can be done by reading the files in separately and then merging the data, however I am not in the mood to figure out LFS well enough to upload my earlier copy of the csv file so I cannot provide it.

library(data.table)
library(ggplot2)

n <- nrow(Trolls)

Trolls <- fread("IRAhandle_tweets.csv")

CitiesTop50 <- c("New York City", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia", "San Antonio", "San Diego", "Dallas", "San Jose", "Austin", "Jacksonville", "San Francisco", "Columbus", "Fort Worth", "Indianaopolis", "Charlotte", "Seattle", "Denver", "Washington", "Boston", "El Paso", "Detroit", "Nashville", "Memphis", "Portland", "Oklahoma City", "Las Vegas", "Louisville", "Baltimore", "Milwaukee", "Albuquerque", "Tucson", "Fresno", "Sacramento", "Mesa", "Kansas City", "Atlanta", "Long Beach", "Omaha", "Raleigh", "Colorado Springs", "Miami", "Virginia Beach", "Oakland", "Minneapolis", "Tulsa", "Arlington", "New Orleans", "Wichita")

col <- c("blue", "blue", "blue", "red", "salmon", "salmon", "red", "blue", "red", "blue", "red", "salmon", "blue", "red", "red", "red", "salmon", "blue", "lightblue", "blue", "blue", "red", "salmon", "red", "red", "blue", "red", "lightblue", "red", "salmon", "lightblue", "blue", "salmon", "blue", "blue", "salmon", "red", "salmon", "blue", "red", "salmon", "lightblue", "salmon", "lightblue", "blue", "lightblue", "red", "red", "red", "red")

Freq <- rep(0, 50)

for (i in 1:50) {
  Freq[i] <- sum(grepl(CitiesTop50[i], Trolls$content))
}

Data <- data.frame(as.factor(CitiesTop50), Freq)

pdf("trolls.pdf")

ggplot(data = Data, mapping = aes(x = reorder(CitiesTop50, 1:50), y = Freq)) +
  geom_col(fill = col) +
  labs(title = "Mentions of US Cities in \nRussian Troll Tweets") +
  xlab("Cities") +
  ylab("Number of Mentions") +
  scale_y_continuous(expand = c(0, 0)) +
  theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(angle = 90, hjust = 1, size = 5, vjust = 0.5))

dev.off()
