class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  before_filter :cors_set_access_control_headers

  def index
    gon.events = current_user.events
      .select('created_on as date, count(*) as count')
      .where('created_on >= ?', 30.days.ago.to_date)
      .group(:created_on)

    @pages = current_user.events
      .select('url as url, count(*) as count')
      .where('created_on >= ?', 30.days.ago.to_date)
      .group(:url)
      .order('count(*) DESC')      
  end

  def create
    full_url = request.referer
    user_url = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\//i.match(full_url)

    @user = User.find_by_url(user_url)

    if @user
      @event = Event.new(name: params[:name])
      @event.url = full_url
      @event.created_on = Date.today
      @event.user = @user

      if @event.save
        render text: "Saved"
      else
        render text: "Error"
      end
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