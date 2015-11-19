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

#stream output of tweets containing topics[key]
tweets = Queue.new
tweetStreamThread = Thread.new {
  TweetStream::Client.new.track(topics.keys.flatten.join(", ")) do |status|
  tweets.enq(status.text)
end}

#check topics occurences in each tweet
occurThread = Thread.new {
  while true do
    if !tweets.empty?
      tweet = tweets.deq
      topics.each_key {|k| topics[k] += 1 if tweet.downcase.include? k.to_s[2..-3]}
      puts topics
    end
  end
}

tweetStreamThread.join
occurThread.join