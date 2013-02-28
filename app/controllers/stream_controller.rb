class StreamController < ApplicationController
  include ActionController::Live

  def checkins
    response.headers['Content-Type'] = 'text/event-stream'
    sse = Reloader::SSE.new(response.stream)
    begin

      checkins = checkin_count
      loop do
        sleep 1
        new_checkins = checkin_count
        sse.write({:time => Time.now}, :event => 'ping')
        if new_checkins > checkins
          sse.write({:checkins => new_checkins}, :event => 'refresh')
          checkins = new_checkins
        end
      end

    rescue IOError
      Rails.logger.info "Client disconnected."
    ensure
      sse.close
    end
  end

  protected

    def checkin_count
      Checkin.connection.execute('SELECT COUNT() "count" FROM checkins').first["count"]
    end

end
