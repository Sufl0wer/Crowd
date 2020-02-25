class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  before_action :load_entities

  def create
    @comment = Comment.create user: current_user,
                              company: @company,
                              content: params.dig( :comment, :content)

    CompanyChannel.broadcast_to @company, @comment
  end

  def destroy
    @comment.destroy

    redirect_back fallback_location: root_path, notice: "Comment was deleted"
  end

  protected

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def load_entities
    @company = Company.find params.dig(:company_id)
  end
end
