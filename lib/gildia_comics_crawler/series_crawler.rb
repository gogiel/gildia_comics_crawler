module GildiaComicsCrawler
  class SeriesCrawler
    include Downloader
    SERIES_BASE_URL = 'komiksy'

    def all_series
      find_pages.flat_map do |page|
        series = series_from_page(page)
        if block_given?
          series.each do |single_series|
            yield single_series
          end
        end
        series
      end
    end

    def series_from_page page
      download(page).css('.long-list a').map do |serie_link|
        {
            name: serie_link.text,
            link: serie_link[:href]
        }
      end
    end

    def find_pages
      @pages ||= begin
        download(SERIES_BASE_URL).css('.header-letters a').map do |letter|
          letter[:href]
        end
      end
    end

  end
end