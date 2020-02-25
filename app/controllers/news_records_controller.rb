class NewsRecordsController < ApplicationController
  before_action :set_reward, only: [:edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]

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

  def check_owner
    if Company.find(params[:company_id]).user != current_user && current_user.role != 'admin'
      redirect_back fallback_location: root_path, alert: "You cannot do this on company that not belongs to you!"
    end
  end
end
