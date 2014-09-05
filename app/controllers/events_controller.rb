class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  before_filter :cors_set_access_control_headers

  def index
    @events = current_user.events.all
  end

  def create
    @event = Event.new(name: params[:name])
    @event.url = request.referer
    @event.created_on = Date.today

    if @event.save
      render text: "Saved"
    else
      render text: "Error"
    end
  end

  private

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers["Access-Control-Allow-Headers"] = 'Content-Type'
    headers['Access-Control-Max-Age'] = '1728000'
    head(:ok) if request.request_method == 'OPTIONS'
  end

  def permission_denied_error
    error(403, 'Permission Denied!')
  end

  def error(status, message = 'Something went wrong')
    response = {
      response_type: "ERROR",
      message: message
    }

    render json: response.to_json, status: status
  end
end