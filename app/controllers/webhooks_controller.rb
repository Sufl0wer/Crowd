class WebhooksController < ApplicationController
  def receive
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.string)
      DonationsController::handle_donation(data) if (data["type"] == "invoice.succeeded")
    else
      data = params.as_json
    end

    render nothing: true
  end
end
