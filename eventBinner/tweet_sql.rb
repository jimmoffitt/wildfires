class TweetSql

  def get_tweets_count(params)

    #Create geo-tagged tweets.
    sSQL = "SELECT COUNT(*)
          FROM tweets
          WHERE `posted_at` > '#{params[:start_date]}'
            AND `posted_at` <= '#{params[:end_date]}';"
		
		return sSQL
  end

  #-----------------------------------------------------------------------------------------
  def get_geo_tagged_tweets_with_native_media(params)

	  #Create geo-tagged tweets.
	  sSQL = "SELECT t.`posted_at`, t.`tweet_id`, n.`expanded_url`, t.`lat`, t.`long`, t.`lat_box`, t.`long_box`
				FROM tweets t, native_media n
				WHERE t.`tweet_id` = n.`tweet_id`
				AND t.`long` IS NOT NULL
				AND n.`expanded_url` IS NOT NULL
				AND `posted_at` > '#{params[:start_date]}'
        AND `posted_at` <= '#{params[:end_date]}'
        ORDER BY t.`posted_at` ASC;"
  end

  def get_count_geo_tagged_tweets_with_native_links(params)

	  #Create geo-tagged tweets.
	  sSQL = "SELECT COUNT(*)
				FROM tweets t, native_media n
				WHERE t.`tweet_id` = n.`tweet_id`
				AND t.`long` IS NOT NULL
				AND n.`expanded_url` IS NOT NULL
				AND `posted_at` > '#{params[:start_date]}'
        AND `posted_at` <= '#{params[:end_date]}'
        ORDER BY t.`posted_at` ASC;"
  end


  #-----------------------------------------------------------------------------------------
  def get_geo_tagged_tweets_with_links(params)

	  #Create geo-tagged tweets.
	  sSQL = "SELECT t.`posted_at`, l.`unwound_url`, t.`lat`, t.`long`, t.`lat_box`, t.`long_box`
				FROM tweets t, links l
				WHERE t.`tweet_id` = l.`tweet_id`
				AND t.`long` IS NOT NULL
				AND l.`unwound_url` IS NOT NULL
				AND `posted_at` > '#{params[:start_date]}'
        AND `posted_at` <= '#{params[:end_date]}'
        ORDER BY t.`posted_at` ASC"
  end

  def get_count_geo_tagged_tweets_with_links(params)

	  #Create geo-tagged tweets.
	  sSQL = "SELECT COUNT(*)
				FROM tweets t, links l
				WHERE t.`tweet_id` = l.`tweet_id`
				AND t.`long` IS NOT NULL
				AND l.`unwound_url` IS NOT NULL
				AND `posted_at` > '#{params[:start_date]}'
        AND `posted_at` <= '#{params[:end_date]}'
        ORDER BY t.`posted_at` ASC"
		
		
  end

  #-----------------------------------------------------------------------------------------

  #-----------------------------------------------------------------------------------------
  def get_geo_tagged_tweets_without_links(params)

	  sSQL = "SELECT `posted_at`, `lat`, `long`, `lat_box`, `long_box`
				 FROM tweets
	        WHERE `tweet_id` NOT IN
	          (SELECT `tweet_id`
	              FROM links)
	          AND `long` IS NOT NULL
            AND `posted_at` > '#{params[:start_date]}'
            AND `posted_at` <= '#{params[:end_date]}'
          ORDER BY `posted_at` ASC;"
  end

  def get_count_geo_tagged_tweets_without_links(params)

	  sSQL = "SELECT COUNT(*)
	        FROM tweets
	        WHERE `tweet_id` NOT IN
	          (SELECT `tweet_id`
	              FROM links)
	          AND `long` IS NOT NULL
            AND `posted_at` > '#{params[:start_date]}'
            AND `posted_at` <= '#{params[:end_date]}'
          ORDER BY `posted_at` ASC;"
  end
  
  def get_tweets_with_hashtag(params, hashtag)

     if hashtag.include?('|') then
      tags = hashtag.split('|')

      hashtag_list = tags.map {|str| "'#{str}'"}.join(',')
      hashtag_match = " IN (#{hashtag_list}) "

    elsif hashtag[0,1] == '*' then
      hashtag_match = " LIKE '%#{hashtag[1,hashtag.length]}' "
    else
      hashtag_match = " = '#{hashtag}' "
    end

    sSQL = "SELECT t.`posted_at`
            FROM tweets t, hashtags h
            WHERE h.hashtag " + hashtag_match +
             "AND t.tweet_id = h.tweet_id
              AND t.`posted_at` > '#{params[:start_date]}'
              AND t.`posted_at` <= '#{params[:end_date]}'
            ORDER BY t.`posted_at` ASC;"
  end

  def get_non_geo_vit_tweets(params)
    #Get non-geo-tagged VIT tweetss.
    sSQL = "SELECT `posted_at`, `tweet_id`
          FROM tweets
          WHERE `long` IS NULL
            AND `vit` = TRUE
            AND `posted_at` > '#{params[:start_date]}'
            AND `posted_at` <= '#{params[:end_date]}'
           ORDER BY `posted_at` ASC;"

  end
  
  #-----------------------------------------------------------------------------------------
  def get_geo_tagged_tweets(params)
  
    #Get all geo-tagged tweets.
    sSQL = "SELECT `posted_at`, `tweet_id`, `lat`, `long`, `lat_box`, `long_box`
          FROM tweets
          WHERE `long` IS NOT NULL
            AND `posted_at` > '#{params[:start_date]}'
            AND `posted_at` <= '#{params[:end_date]}'
          ORDER BY `posted_at` ASC;"
  end

  def get_count_geo_tagged_tweets(params)

    #Get all geo-tagged tweets.
    sSQL = "SELECT COUNT(*)
          FROM tweets
          WHERE `long` IS NOT NULL
            AND `posted_at` > '#{params[:start_date]}'
            AND `posted_at` <= '#{params[:end_date]}'
          ORDER BY `posted_at` ASC;"
  end




  
  #-----------------------------------------------------------------------------------------

  def get_tweets_with_profile_geo_only_by_region(params)
    #Create geo-tagged tweets.
    sSQL = "SELECT t.`posted_at`, t.`tweet_id`, u.`user_id`, t.`message`, u.`lat`, u.`long`
          FROM tweets t, users u
          WHERE t.user_id = u.user_id
            AND u.`region` = '#{params[:region]}'
            AND a.`long` IS NULL
            AND a.`posted_at` > '#{params[:start_date]}'
            AND a.`posted_at` <= '#{params[:end_date]}'
          ORDER BY `posted_at` ASC;"
    
  end


  def get_tweets_with_profile_geo_only_by_bounding_box(params)
    #Create geo-tagged tweets.
    sSQL = "SELECT t.`posted_at`, t.`tweet_id`, u.`lat`, u.`long``
          FROM tweets t, users u
          WHERE t.user_id = u.user_id
            AND u.`long` > #{params[:profile_west]}
            AND u.`long` < #{params[:profile_east]}
            AND u.`lat` > #{params[:profile_south]}
            AND u.`lat` < #{params[:profile_north]}
            AND t.`long` IS NULL
            AND t.`posted_at` > '#{params[:start_date]}'
            AND t.`posted_at` <= '#{params[:end_date]}'
          ORDER BY `t.posted_at` ASC;"
  end

  def get_tweets_with_media_profile_geo_only_by_bounding_box(params)
    #Create geo-tagged tweets.
    sSQL = "SELECT t.`posted_at`, t.`tweet_id`, n.`expanded_url`, u.`lat`, u.`long`
          FROM tweets t, users u, native_media n
          WHERE t.user_id = u.user_id
            AND t.tweet_id = n.tweet_id
            AND u.`long` > #{params[:profile_west]}
            AND u.`long` < #{params[:profile_east]}
            AND u.`lat` > #{params[:profile_south]}
            AND u.`lat` < #{params[:profile_north]}
            AND t.`long` IS NULL
            AND t.`posted_at` > '#{params[:start_date]}'
            AND t.`posted_at` <= '#{params[:end_date]}'
          ORDER BY t.`posted_at` ASC;"
  end

  def get_instagram_tweets_with_profile_geo_only(params)
    #WHERE (`media` IS NOT NULL OR `urls` LIKE '%instagram%')
    #Create geo-tagged tweets with media time-series.
    sSQL = "SELECT t.`posted_at`, t.`tweet_id`, l.`unwound_url`, u.`user_id`, t.`message`, u.`lat`, u.`long`
          FROM tweets t, users u, links l
          WHERE (l.unwound_url LIKE '%instagram%')
            AND t.user_id = u.user_id
            AND t.tweet_id = l.tweet_id
            AND u.`long` IS NOT NULL
            AND t.`long` IS NULL
            AND t.`posted_at` > '#{params[:start_date]}'
            AND t.`posted_at` <= '#{params[:end_date]}'
          ORDER BY `t.posted_at` ASC;"
  end

  def get_geo_tagged_instagram_tweets(params)
    sSQL = "SELECT t.`posted_at`, t.`tweet_id`, l.`unwound_url`, t.`user_id`, t.`message`, t.`lat`, t.`long`, t.`lat_box`, t.`long_box`
        FROM tweets t, links l
            WHERE (l.`unwound_url` LIKE '%instagram%')
          AND t.`tweet_id` = l.`tweet_id`
 	        AND t.`long` IS NOT NULL
 	        AND t.`posted_at` > '#{params[:start_date]}'
            AND t.`posted_at` <= '#{params[:end_date]}'
        ORDER BY t.`posted_at` ASC;"
  end

  def get_followers_count_ts(params, handle)
    #Custom SQL
    sSQL = "SELECT u.posted_at, u.followers_count
                  FROM tweets t, users u
                  WHERE u.handle LIKE \"%#{handle}%\"
                        AND t.user_id = u.user_id
                        AND t.posted_at > '#{params[:start_date]}'
                        AND t.posted_at <= '#{params[:end_date]}';
      "
  end


  #---------------------------------------------------------------------------------------------
  #Generating 15-minute counts from tweets table.
  #These were used to compile time-series data for R plots.
  #Written in support of https://blog.gnip.com/tweeting-rain-part-4-tweets-2013-colorado-flood/
  
  def get_tweet_count_timeseries(params)
    
    seconds = params[:interval] * 60
    
    sSQL = "SELECT FROM_UNIXTIME(
                CEILING(UNIX_TIMESTAMP(`posted_at`)/#{seconds})*#{seconds}
                    ) AS timeslice
                , COUNT(*) AS tweets
        FROM tweets
        WHERE
            posted_at > '#{params[:start_date]}'
            AND posted_at <= '#{params[:end_date]}'
        GROUP
            BY timeslice
        "
  end

  def get_geo_tagged_tweet_counts(params)

    seconds = params[:interval] * 60
    
    sSQL = "SELECT FROM_UNIXTIME(
                CEILING(UNIX_TIMESTAMP(`posted_at`)/#{seconds})*#{seconds}
                    ) AS timeslice
                , COUNT(*) AS mycount
        FROM tweets
        WHERE
            posted_at > '#{params[:start_date]}'
            AND posted_at <= '#{params[:end_date]}'
            AND `long` IS NOT NULL
        GROUP
            BY timeslice
        "
  end

  def get_has_media_tweet_counts(params)

    seconds = params[:interval] * 60
    
    sSQL = "SELECT FROM_UNIXTIME(
                CEILING(UNIX_TIMESTAMP(t.`posted_at`)/#{seconds})*#{seconds}
                    ) AS timeslice
                , COUNT(*) AS mycount
        FROM tweets t, links l
        WHERE
            t.posted_at > '#{params[:start_date]}'
            AND t.posted_at <= '#{params[:end_date]}'
            AND t.tweet_id = l.tweet_id
            AND (l.`unwound_url` LIKE '%instagram%')
        GROUP
            BY timeslice
        "
  end

  def get_geo_tagged_has_media_tweet_counts(params)

    seconds = params[:interval] * 60
    
    sSQL = "SELECT FROM_UNIXTIME(
                CEILING(UNIX_TIMESTAMP(t.`posted_at`)/#{seconds})*#{seconds}
                    ) AS timeslice
                , COUNT(*) AS mycount
        FROM tweets t, links l
        WHERE
            t.`posted_at` > '#{params[:start_date]}'
            AND `t.posted_at`` <= '#{params[:end_date]}'
            AND t.`long` IS NOT NULL
            AND (l.`unwound_url` LIKE '%instagram%')
        GROUP
            BY timeslice
        "
  end

  def get_followers_count(params, handle)

    seconds = params[:interval] * 60
    
    sSQL = "SELECT FROM_UNIXTIME(
                   CEILING(UNIX_TIMESTAMP(t.`posted_at`)/#{seconds})*#{seconds}
                    ) AS timeslice
                    , u.`followers_count` AS mycount
                FROM tweets t, users u
                WHERE
	                u.`handle` LIKE \"%#{handle}%\"
                    AND t.`user_id` = u.`user_id`
                    AND t.`posted_at` > '#{params[:start_date]}'
                    AND t.`posted_at` <= '#{params[:end_date]}'
                GROUP
                    BY timeslice;
        "
  end

  def get_tag_count(params, tag)

    seconds = params[:interval] * 60

    sSQL = "SELECT FROM_UNIXTIME(
                   CEILING(UNIX_TIMESTAMP(t.`posted_at`)/#{seconds})*#{seconds}
                    ) AS timeslice
                    , COUNT(*) AS mycount
                FROM tweets t, hashtags h
                WHERE
	                t.tweet_id = h.tweet_id
                    AND t.posted_at > '#{params[:start_date]}'
                    AND t.posted_at <= '#{params[:end_date]}'
	                AND (h.hashtag LIKE \"%#{tag}%\")
                GROUP
                    BY timeslice;
                "
  end

end
