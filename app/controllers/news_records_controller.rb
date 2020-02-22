class NewsRecordsController < ApplicationController
  def create
    @news_record = NewsRecord.create content: params.dig(:news_record, :content),
                                     heading: params.dig(:news_record, :heading),
                                     company: Company.find(params.dig(:company_id))

    redirect_back fallback_location: root_path
  end
end
