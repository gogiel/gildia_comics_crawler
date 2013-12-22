module GildiaComicsCrawler
  class ComicCrawler
    include Downloader

    def initialize link
      @link = link
    end

    def crawl
      @noko = download(@link)
      @data = {gildia_link: @downloader_uri}
      @data[:gildia_sklep_link] = @noko.css('#product a.p').first[:href] rescue nil
      @data[:cover] = @noko.css('.main-article-image').first[:src].gsub(/200.jpg$/, '600.jpg') rescue nil
      elements = @noko.css('.widetext').children
      @data[:title] = elements.css('h1').children.first.text

      @data.merge! first_block_elements(elements)
      @data.merge! second_block_elements(elements)

      @data
    end

    private

    FIRST_BLOCK_SECTIONS = {
        "Scenariusz:" => :scenario,
        "Rysunek:" => :drawing,
        "Tłumaczenie:" => :translation
    }

    def first_block_elements elements
      found_elements = []
      elements.each do |el|
        break if el.name == 'div' && !el[:class]
        found_elements << el if el.name == 'text' || el.name == 'a'
      end
      extracted_data = found_elements.map(&:text).map(&:strip).reject { |t| t.empty? || t == ',' }
      data = {}
      current_section = nil
      extracted_data.each do |text|
        if (new_section=FIRST_BLOCK_SECTIONS[text])
          current_section = new_section
        else
          data[current_section] ||= []
          data[current_section] << text
        end
      end

      data
    end

    SECOND_BLOCK_SECTIONS = {
      "Tytuł oryginalny" => :origin_title,
      "Wydawca oryginalny" => :origin_publisher,
      "Rok wydania oryginału:" => :origin_publish_year,
      "Liczba stron" => :pages_count,
      "Oprawa" => :binding,
      "Papier" => :paper,
      "Druk" => :color,
      "ISBN-13" => :isbn,
      "Wydanie" => :edition,
      "Cena z okładki" => :original_price
    }

    def second_block_elements elements
      data = {}
      extracted_data = elements.filter('div:not([class])')[1].children.map(&:text).map(&:strip).reject(&:empty?)
      if extracted_data[0] == 'Wydawnictwo:'
        data[:publisher] = extracted_data[1]
        extracted_data.shift(2)
      end
      if extracted_data[0] =~ /^\d+\/\d+$/
        month, year = extracted_data.shift.split('/')
        data[:publish_date_month] = month
        data[:publish_date_year] = year
      end

      extracted_data.each do |line|
        attr, val = line.split(':', 2)
        if(attr_sym=SECOND_BLOCK_SECTIONS[attr])
          data[attr_sym] = val.strip
        end
      end
      data
    end
  end
end