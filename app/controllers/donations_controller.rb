class DonationsController < ApplicationController
  before_action :set_donation, only: %i[show update destroy]

  def index
    @donations = Donation.all
    render json: @donations
  end

  def show
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
      request.body = "{\"data\":{\"attributes\":{\"amount\":10000,\"redirect\":{\"success\":\"http://localhost:3001/calamity-response-app-fe#/success\",\"failed\":\"http://localhost:3001/calamity-response-app-fe#/failed\"},\"type\":\"#{params[:type]}\",\"currency\":\"PHP\"}}}"
  
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
