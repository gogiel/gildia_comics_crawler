# GildiaComicsCrawler

komiks.gildia.pl crawler. It can crawl comic database (http://www.komiks.gildia.pl/komiksy)

## Installation

Add this line to your application's Gemfile:

    gem 'gildia_comics_crawler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gildia_comics_crawler

## Usage

    require 'gildia_comics_crawler'

    GildiaComicsCrawler::Crawler.new.crawl do |series|
        ...
    end