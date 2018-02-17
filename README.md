# wildfires
A dusted off version of SocialFlood to tell the story of how the 2017 California wildfires unfolded on Twitter.

## Current themes:
+ When previous version was written, native video was not a thing. It is now, so gotta modernize to handle Twitter native video.
+ Displaying **classes** of Tweets.
  + Geo-tagged Tweets with Native Media are the crown jewels.
    + Easy to find. 
    + Assumption: Native media is now most common media type since Twitter enabled videos and multiple photos.
  + Geo-tagged with linked media are too.
  + Tweets from 'official' sources. Not all official sources are Verified.
  + Native and linked media with country/regional/local Profile Geo of interest.
  + VIT Tweets. Curated collection that 'adds' to story.
  
## Demo themes:  
+ EventViewer is based on a currated collection of Tweets.
  + Starts with curated rules by search API for based collection.
  + Collection is then curated.
+ EventDeck is driven by Replay and a set of curated rules.

## Coding themes:
+ Moving JSON format from AS to Native enriched.
+ Moving from single-table schema to multi-table schema.
  + Code that moves data from database to JSON store needed SQL updates (EventBinner).
+ Previous version was partly written to be a one-off. 
+ So many pieces:
  + currated rules --> API client --> DB --> EventBinner --> EventViewer
  + curated rules --> Replay stream --> EventDeck(rules)
  

