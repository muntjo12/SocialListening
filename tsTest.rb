require 'tweetstream'

#initiate tweet stream connection
TweetStream.configure do |config|
  config.consumer_key       = 'FwagvzNoy7CfnkfZJkdBQ4RLL'
  config.consumer_secret    = 'LzySWk4kBsiZBKt6uzPgtF0kDL9tCAKTbZTIWATjmtPDMeIuC5'
  config.oauth_token        = '4135857079-SkvJUl8V6exuydQAxAsCWXvOmNNajsS6Q2WTMyt'
  config.oauth_token_secret = 'HJAohEy8NkJTnyBQ4lvewNunjArwHSd0VFF8H3PHkfHCs'
  config.auth_method        = :oauth
end

#gets topic list from words.txt and initiates them as Hash[keys]
topics = Hash.new
File.open("words.txt") do |fp|
  fp.each do |line|
    key = line.chomp.split("\n")
    topics[key] = 0
  end
end

tsThread = Thread.new {
  TweetStream::Client.new.track(topics.keys.flatten.join(", ")) do |status|
  puts "HOPE: #{status.text}"
  puts ""
end}.join