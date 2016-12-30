require(twitteR)
require(RCurl)
consumerkey <- '********' #Get the key from the website
consumersecret <- '*****'  #Get the key from the website
accesstoken <- '*****'  #Get the key from the website
accesssecter <- '******'  #Get the key from the website

#Authenticate with twitter
setup_twitter_oauth(consumerkey, consumersecret, accesstoken, accesssecter)

#Search for the tweet
#defining a variable
oneplus_tweet<-searchTwitter("Oneplus", n=25, lan="en") #Searching for 25 latest tweets
#Viewing the tweets
oneplus_tweet

