class DonationsController < ApplicationController

  def index
    @invoice_link = invoice_link
  end

  private

  def invoice_link
    @company = Company.find(params.dig(:company_id))
    @product = @company.products.find_by(price: params.dig(:price))
    @company.create_invoice(@product, current_user)
  end
end
