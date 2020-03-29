class WebhooksController < ApplicationController
  def receive
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.string)
    else
      data = params.as_json
    end

    Webhook::Received.save(data: data, integration: params[:integration_name])

    render nothing: true
  end
end
