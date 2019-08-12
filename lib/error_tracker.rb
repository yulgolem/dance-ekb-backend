# payload.is_a Hash
class ErrorTracker
  def self.new(message:, payload: nil, silent: false, exception: nil)
    if defined?(Rollbar)
      if exception.present?
        Rollbar.error(exception)
      else
        Rollbar.error(message, payload)
      end
    elsif exception.present?
      fail exception
    else
      full_message = [
        "ErrorTracker:\n#{message}",
        *payload&.map { |item| "#{item.first} = #{item.last}" },
      ].join("\n")
      silent ? puts(full_message) : raise(full_message)
    end
  end
end
