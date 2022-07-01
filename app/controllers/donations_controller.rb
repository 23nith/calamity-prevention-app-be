class DonationsController < ApplicationController
  before_action :set_donation, only: %i[show update destroy]

  def index
    # Donation.where(created_at: )
    # @donations = Donation.all
    @donations = Donation.all.map{|x| {id: x.id, need_id: x.need.id, need: x.need.description, user: x.user.email, status: x.is_paid, area: x.user.area.name}}
    render json: @donations
  end

  def show
  end

  def reports
    @areas = Area.all.map{|x| {area_name: x.name, calamities: x.calamities.map{|y| {calamity_name: y.description, needs: y.needs.map{|z| {id: z.id, cost: z.cost, count: z.count, description: z.description, donations: z.donations.sum{|a| a[:amount]}}}}}}}.to_json
    render json: @areas
  end

  def donations_per_need
    @donations = Need.where(id: params[:id]).map{|x| {donations: x.donations.map{|y| {user: y.user.email, need: y.need.description, amount: y.amount, method: y.payment_type, date: x.created_at}}}}
    render json: @donations
  end

  def create
    @donation = Donation.new(donation_params)
    if @donation.save!
      render json: @donation, status: :created, location: @donation
    else
      render json: @donation.errors, status: :unprocessable_entity
    end
  end

  def source
    require 'uri'
    require 'net/http'
    require 'openssl'
    
    @donation = Donation.new(donation_params)
    if @donation.save!
      url = URI("https://api.paymongo.com/v1/sources")
  
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
  
      request = Net::HTTP::Post.new(url)
      request["Accept"] = 'application/json'
      request["Content-Type"] = 'application/json'
      request["Authorization"] = "Basic #{ENV['paymongo_token']}"
      request.body = "{\"data\":{\"attributes\":{\"amount\":10000,\"redirect\":{\"success\":\"https://23nith.github.io/calamity-response-app-fe/#/success\",\"failed\":\"https://23nith.github.io/calamity-response-app-fe/#/failed\"},\"type\":\"#{params[:type]}\",\"currency\":\"PHP\"}}}"
  
      response = http.request(request)
      body = JSON.parse(response.read_body)
      src = body["data"]["id"]
      @donation.update(source: src)
      puts response.read_body
      render json: response.read_body
    else
      render json: @donation.errors, status: :unprocessable_entity
    end

  end

  def payment
    require 'uri'
    require 'net/http'
    require 'openssl'

    url = URI("https://api.paymongo.com/v1/payments")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Accept"] = 'application/json'
    request["Content-Type"] = 'application/json'
    request["Authorization"] = "Basic #{ENV['paymongo_token']}"
    request.body = "{\"data\":{\"attributes\":{\"amount\":#{donation_params["amount"]},\"source\":{\"id\":\"#{donation_params["source_id"]}\",\"type\":\"source\"},\"currency\":\"PHP\"}}}"

    response = http.request(request)
    puts response.read_body
    render json: response.read_body
  end

  private
    def set_donation
      @donation = Donation.find(params[:id])
    end

    def donation_params
      params.require(:donation).permit(:user_id, :is_paid, :payment_type, :source, :need_id, :amount, :source_id, :type)
    end

    
end
