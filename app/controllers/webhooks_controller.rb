class WebhooksController < ApplicationController
  def receive
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.string)
      DonationsHandler.handle_donation(data) if (data["type"] == "invoice.succeeded")
    else
      data = params.as_json
    end

    render :json => {:status => 200}
  end
end
