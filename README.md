# wildfires
A dusted off version of SocialFlood to tell the story of how the 2017 California wildfires unfolded on Twitter.

Current themes:
+ This version works with native/original Twitter Tweet JSON format.
+ When previous version was written, native video was not a thing. It is now, so gotta modernize to handle Twitter native video.

Coding themes:
+ Moving JSON format from AS to Native enriched.
+ Moving from single-table schema to multi-table schema.
  + Code that moves data from database to JSON store needed SQL updates (EventBinner).
  
