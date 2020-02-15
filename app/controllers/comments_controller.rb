class CommentsController < ApplicationController
  before_action :load_entities

  def create
    @comment = Comment.create user: current_user,
                              company: @company,
                              content: params.dig( :comment, :content)
    CompanyChannel.broadcast_to @company, @comment
  end

  protected

  def load_entities
    @company = Company.find params.dig(:company_id)
  end
end
