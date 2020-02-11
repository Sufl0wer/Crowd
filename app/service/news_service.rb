class NewsService
  NEWS_FILE_LOCATION = "./public/news.yml"

  NUMBER_OF_LAST_NEWS = 10

  def initialize
    @news_data =
        if File.size?(NEWS_FILE_LOCATION)
          YAML.load(File.read(NEWS_FILE_LOCATION))
        else
          []
        end
    byebug
  end

  def save_record_about_new_company (company)
    @news_data << {datetime: company.created_at.time, details: {object: 'company', object_id: company.id}}
    @news_data.sort_by! { |record| record[:datetime] }
    clear_to_number_of_last_news
    File.open(NEWS_FILE_LOCATION, 'w') { |file| file.write(@news_data.to_yaml) }
  end

  private

  def clear_to_number_of_last_news
    @news_data.last.delete if @news_data.size > NUMBER_OF_LAST_NEWS
  end
end
