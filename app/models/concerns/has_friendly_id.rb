module Concerns::HasFriendlyId
  extend ActiveSupport::Concern

  SLUG_FORMAT = /\A[0-9a-z\-_]+\z/

  included do
    extend FriendlyId
    friendly_id :slug_candidates, use: :slugged

    validates :slug, presence: true, uniqueness: true, format: {
      with: Concerns::HasFriendlyId::SLUG_FORMAT,
      message: :slug_format,
    }

    # must be here to properly override
    def should_generate_new_friendly_id?
      slug.blank?
    end
  end

  def main_slug_candidate
    [:title]
  end

  def slug_candidates
    [
      main_slug_candidate,
      [:id, *main_slug_candidate],
    ]
  end

  def slug=(value)
    return unless value.present?
    write_attribute(:slug, value)
  end
end
