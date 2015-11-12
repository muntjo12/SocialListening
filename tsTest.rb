require 'tweetstream'

#initiate tweet stream connection
TweetStream.configure do |config|
  config.consumer_key       = 'FwagvzNoy7CfnkfZJkdBQ4RLL'
  config.consumer_secret    = 'LzySWk4kBsiZBKt6uzPgtF0kDL9tCAKTbZTIWATjmtPDMeIuC5'
  config.oauth_token        = '4135857079-SkvJUl8V6exuydQAxAsCWXvOmNNajsS6Q2WTMyt'
  config.oauth_token_secret = 'HJAohEy8NkJTnyBQ4lvewNunjArwHSd0VFF8H3PHkfHCs'
  config.auth_method        = :oauth
end

#retrive tweets containing __ words
TweetStream::Client.new.track('hope', 'love', 'kindness') do |status|
  puts "#{status.text}"
end