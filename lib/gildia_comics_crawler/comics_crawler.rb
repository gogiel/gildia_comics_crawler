module GildiaComicsCrawler
  class ComicsCrawler
    include Downloader
    def initialize base_url
      @base_url = base_url
    end

    def all_comics
      comics_list.map do |link|
        ComicCrawler.new(link).crawl
      end
    end

    def comics_list
      download(@base_url).css('.CDgallery a').map do |link|
        link[:href]
      end
    end
  end

end