require 'nokogiri'
require 'open-uri'

module GildiaComicsCrawler
  module Downloader
    BASE_URI = 'http://www.komiks.gildia.pl/'

    class Base
      def initialize uri
        uri = URI::join(BASE_URI, uri) unless uri.start_with?('http://')
        @uri = uri
      end

      attr_accessor :uri

      def download
        Nokogiri::HTML(open(@uri))
      end
    end

    def download uri
      downloader = Base.new(uri)
      @downloader_uri = downloader.uri.to_s
      downloader.download
    end
  end
end