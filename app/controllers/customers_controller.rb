class CustomersController < ApplicationController
  before_action :set_customer, only: [:show]

  PERPAGE = 30

  # GET /customers
  def index
    page = (params['page'] || 1).to_i
    @customers = Customer.page(page).per(PERPAGE)
    json_response(
      @customers,
      pagination(@customers, PERPAGE)
    )
  end

  # GET /customers/1
  def show
    json_response(@customer)
  end

  # POST /customers
  def create
    @customer = Customer.create!(customer_params)
    json_response(@customer, {}, :created)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def customer_params
      params.permit(:name)
    end
end