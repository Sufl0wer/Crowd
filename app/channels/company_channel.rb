class CompanyChannel < ApplicationCable::Channel
  def subscribed
    company = Company.find params[:company_id]
    stream_for company
  end
end
