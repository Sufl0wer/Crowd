class DonationsController < ApplicationController

  def index
    @invoices = create_invoices
  end

  private

  def create_invoices
    @company = Company.find(params.dig(:company_id))
    @company.products.map { |product| @company.create_invoice(product, current_user) }
  end
end
