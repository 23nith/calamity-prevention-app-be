class WebhookController < ApplicationController
  def listen
    params.permit!
    reset = false

    unless reset 
      result = []
      gcash_source_record = ""
      amount = params["data"]["attributes"]["data"]["attributes"]["amount"]
      currency = params["data"]["attributes"]["data"]["attributes"]["currency"]
      source_id = params["data"]["attributes"]["data"]["id"]
      
      if params["data"]["attributes"]["data"]["attributes"]["status"] != "paid"
        source_val = ewallet_source_record(source_id)
        
        if source_val.present? && source_val['data'].present?
          status = source_val['data']['attributes']['status']
          gcash_source_record = ewallet_payment(amount, source_id)
          payment_status = gcash_source_record['data']['attributes']['status']
          payment_type = gcash_source_record['data']['attributes']["source"]["type"]
          # payment_type = gcash_source_record['data']['attributes']['type']
        end
      end

    end

    # UPDATE OF DONATION INSTANCE ASSOCIATED WITH THE SOURCE CAPTURED

    if payment_status == "paid"
      case payment_type
      when "gcash"
        donation = Donation.find_by(payment_type: "gcash", source: source_id)
      when "grab_pay"
        donation = Donation.find_by(payment_type: "grab_pay", source: source_id)
      else
        "error"
      end
      donation.update!(is_paid: true) if donation.present?
    end

    # END

    render(status: :ok)
  end

  def create
    require 'uri'
    require 'net/http'
    require 'json'

    uri = URI.parse("https://api.paymongo.com/v1/webhooks")

    request = Net::HTTP::Post.new(uri)
    request["Accept"] = 'application/json'
    request["Content-Type"] = 'application/json'
    request["Authorization"] = "Basic #{ENV['paymongo_token']}"
    request.body = JSON.dump({
      "data" => {
        "attributes" => {
          "events" => [
            "source.chargeable", "payment.paid", "payment.failed"
          ],
          "url" => "https://calamity-response-be.herokuapp.com/listen"
        }
      }
    })

    req_options = {use_ssl: uri.scheme == "https"}

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    res = JSON.parse(response.body)

    render json: res
  end

  private
    def ewallet_payment(amount, source_id)
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
      request.body = "{\"data\":{\"attributes\":{\"amount\":#{amount},\"source\":{\"id\":\"#{source_id}\",\"type\":\"source\"},\"currency\":\"PHP\"}}}"

      response = http.request(request)
      JSON.parse(response.body)
    end

    def ewallet_source_record(source_id)

      require 'uri'
      require 'net/http'
      require 'openssl'

      url = URI("https://api.paymongo.com/v1/sources/#{source_id}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Accept"] = 'application/json'
      request["Authorization"] = "Basic #{ENV['paymongo_token']}"

      response = http.request(request)
      JSON.parse(response.body)
    end
end