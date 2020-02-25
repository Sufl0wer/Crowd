class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy, :add_image]


  def index
    @companies = Company.all.sort_by(&:name)
  end

  def show
    @company = Company.find params.dig(:id)
    @rewards = @company.rewards
    @comments = @company.comments
    @news_records = @company.news_records
    @user_donations = @company.donations.find_by(user: current_user)

    @comment = Comment.new
    @paid_reward = PaidReward.new
    @donation = Donation.new
    @news_record = NewsRecord.new
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find params.dig(:id)
  end

  def create
    @company = Company.create name: company_params.dig(:name),
                              goal: company_params.dig(:goal),
                              tag_list: company_params.dig(:tag_list),
                              expiration_date: company_params.dig(:expiration_date),
                              description: company_params.dig(:description),
                              user_id: current_user.id

    if @company.save
      redirect_to companies_path
    else
      render new_company_path
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
    end
  end

  def company_gallery
    @company = Company.find(params.dig(:company_id))
    @images = @company.images.all
  end

  def add_image
    @company = Company.find(params[:company_id])
    @company.images.attach(params.dig(:company, :images))
    @company.save

    redirect_back fallback_location: root_path
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :goal, :tag_list,
                                      :expiration_date, :description, user_id: current_user.id)
    end

  def check_owner
    if Company.find(params[:id]).user != current_user && current_user.role != 'admin'
      redirect_back fallback_location: root_path, alert: "You cannot do this on company that not belongs to you!"
    end
  end
end
