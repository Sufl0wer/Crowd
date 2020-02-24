class NewsRecordsController < ApplicationController
  before_action :set_reward, only: [:edit, :update, :destroy]

  def create
    @news_record = NewsRecord.create content: params.dig(:news_record, :content),
                                     heading: params.dig(:news_record, :heading),
                                     company: Company.find(params.dig(:company_id))

    redirect_back fallback_location: root_path
  end

  def destroy
    @news_record.destroy

    redirect_back fallback_location: root_path
  end

  private

  def set_reward
    @news_record = NewsRecord.find(params[:id])
  end
end
