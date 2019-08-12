class InteractionWorker
  include Sidekiq::Worker

  sidekiq_options retry: 10

  def perform(class_name, params)
    interaction_class = class_name.constantize
    raise "Unexpected interaction class #{class_name}" unless interaction_class <= BaseInteraction
    sleep 2 if Rails.env.production? || Rails.env.staging?
    interaction_class.execute(params)
  end
end
