module Concerns::HasUUID
  extend ActiveSupport::Concern

  included do
    # db level constraint should be enough, but no AR error will appear if conflict occur
    # validates :uuid, presence: true, uniqueness: true
    before_validation :generate_uuid, on: :create
  end

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
