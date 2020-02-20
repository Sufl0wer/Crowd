class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]

  # GET /companie
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find params.dig(:id)
    @rewards = @company.rewards
    @comments = @company.comments
    @comment = Comment.new
    @paid_reward = PaidReward.new
    @donation = Donation.new
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find params.dig(:id)
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.create name: company_params.dig(:name),
                              category: company_params.dig(:category),
                              goal: company_params.dig(:goal),
                              expiration_date: company_params.dig(:expiration_date),
                              description: company_params.dig(:description),
                              user_id: current_user.id

    @company.save
    redirect_back fallback_location: root_path
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :category, :goal,
                                      :expiration_date, :description, user_id: current_user.id)
    end

  def check_owner
    if Company.find(params[:id]).user != current_user
      redirect_back fallback_location: root_path, alert: "You cannot do this on company that not belongs to you!"
    end
  end
end
