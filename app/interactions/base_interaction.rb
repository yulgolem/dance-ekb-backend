class BaseInteraction
  attr_accessor :result, :artifacts, :fail_policy

  def initialize(params = {})
    params&.each { |attr, value| public_send("#{attr}=", value) }
    self.result = nil
    self.artifacts = {}
    self.fail_policy ||= :unexpected
    super()
  end

  def self.execute(params = {})
    Rails.logger.info "#{Time.current.iso8601}: Executing interaction #{name}, #{params.to_json}"
    interaction = new(params)
    interaction.result = interaction.run
    interaction
  end

  def self.execute_async(params = {})
    # return execute(params) if Rails.env.development? # debug
    delay = params.delete :delay
    at = params.delete :at
    if delay
      Rails.logger.info "#{Time.current.iso8601}: Enqueue async execute with delay #{delay} #{name}, #{params.to_json}"
      InteractionWorker.perform_in delay, name, {fail_policy: :exception}.merge(params)
    elsif at
      Rails.logger.info "#{Time.current.iso8601}: Enqueue scheduled async execute at #{at} #{name}, #{params.to_json}"
      InteractionWorker.perform_at at, name, {fail_policy: :exception}.merge(params)
    else
      Rails.logger.info "#{Time.current.iso8601}: Enqueue async execute #{name}, #{params.to_json}"
      InteractionWorker.perform_async name, {fail_policy: :exception}.merge(params)
    end
  end

  private

  def fail!(message)
    case fail_policy.to_sym
    when :exception
      raise message
    when :silent
      Rollbar.error(message) if defined?(Rollbar)
      nil
    when :unexpected
      raise "Unexpected fail policy, error - #{message}"
    else
      raise "Unexpected fail policy #{fail_policy}, error - #{message}"
    end
  end
end
