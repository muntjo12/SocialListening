require 'tweetstream'

#initiate tweet stream connection
TweetStream.configure do |config|
  config.consumer_key       = 'FwagvzNoy7CfnkfZJkdBQ4RLL'
  config.consumer_secret    = 'LzySWk4kBsiZBKt6uzPgtF0kDL9tCAKTbZTIWATjmtPDMeIuC5'
  config.oauth_token        = '4135857079-SkvJUl8V6exuydQAxAsCWXvOmNNajsS6Q2WTMyt'
  config.oauth_token_secret = 'HJAohEy8NkJTnyBQ4lvewNunjArwHSd0VFF8H3PHkfHCs'
  config.auth_method        = :oauth
end

#hash, queue, file variables
topics = Hash.new
tweets = Queue.new
topicsfile = "words.txt"

#def to fill a hash with topics from a file
def get_topics(hash, txtfile)
File.open(txtfile) do |fp|
  fp.each do |line|
    key = line.chomp.split("\n")
    hash[key] = 0
  end end 
end

#tweetstream thread for recieving tweets containing words from topics
tweetStreamThread = Thread.new {
  TweetStream::Client.new.track(topics.keys.flatten.join(", ")) do |status|
  tweets.enq(status.text)
end}

#check occurences of topics in a given tweet
def occur(hash, queue)
if !queue.empty?
  value = queue.deq
  hash.each_key {|k| hash[k] += 1 if value.downcase.include? k.to_s[2..-3]}
end end

#check topics occurences in each tweet
occurThread = Thread.new {
  while true do
    occur(topics, tweets)
    puts topics
  end}
  
get_topics(topics, topicsfile)
tweetStreamThread.join
occurThread.join