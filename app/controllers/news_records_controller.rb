class NewsRecordsController < ApplicationController
  def create
    @news_record = NewsRecord.create content: params.dig(:news_record, :content),
                                     company: Company.find(params.dig(:company_id))

    redirect_back fallback_location: root_path
  end
end
