class WidgetsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:send_data]

  URL = "http://5.79.16.170"

  def send_data
    request.body.rewind
    body  = JSON.parse(request.body.read)
    token = body.delete("token")
    data  = body.delete("data") || {}
    user  = User.find_by(api_token: token)

    if user
      url = "/widgets/#{params[:widget]}"
      data["auth_token"] = ENV["TOKEN"]

      conn = Faraday.new(:url => 'http://5.79.16.170') do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end

      resp = conn.post do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
        req.body = data.to_json
      end

      head resp.status
    else
      render json: '{"error": {"message": "Invalid API token"}}', status: 403
    end
  end
end
