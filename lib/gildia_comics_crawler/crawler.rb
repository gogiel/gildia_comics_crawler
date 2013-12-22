module GildiaComicsCrawler
  class Crawler
    def crawl
      SeriesCrawler.new.all_series do |series|
        comics = ComicsCrawler.new(series[:link]).all_comics
        yield series.merge(comics: comics)
      end
    end
  end
end