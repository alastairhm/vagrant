#!/usr/bin/env ruby
# Find your Twitter Mentions

#require "rubygems"
require "twitter" #https://github.com/sferik/twitter for config details

Twitter.mentions(:count => 10).each { |tweet|
    puts "#{tweet.user.screen_name}, #{tweet.text}"
    puts
}
