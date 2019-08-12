# create_table :admins, force: :cascade do |t|
#   t.string :first_name
#   t.string :last_name
#   t.string :email, default: "", null: false
#   t.string :encrypted_password, default: "", null: false
#   t.datetime :remember_created_at
#   t.integer :sign_in_count, default: 0, null: false
#   t.datetime :current_sign_in_at
#   t.datetime :last_sign_in_at
#   t.inet :current_sign_in_ip
#   t.inet :last_sign_in_ip
#   t.string :roles, default: [], array: true
#   t.datetime :created_at, null: false
#   t.datetime :updated_at, null: false
#   t.index [:email], name: :index_admins_on_email, unique: true
# end

class Admin < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true
  validate :validate_role_values

  def full_name
    [first_name, last_name].join(" ").squish
  end

  ADMIN_ROLES = {
    admin: 1,
    formal_assessment_expert: 2,
    meaningful_assessment_expert: 3,
  }.freeze

  ADMIN_ROLES.keys.map(&:to_s).each do |role|
    scope role, -> { where("'#{role}' = ANY (roles)") }
    define_method(:"#{role}?") { roles&.include? role }
    define_method(:"only_#{role}?") { roles == [role] }
  end

  private

  def validate_role_values
    roles.reject!(&:blank?)

    invalid_values = roles.reject { |x| x.to_sym.in? ADMIN_ROLES.keys }
    if invalid_values.present?
      errors.add(
        :roles, :invalid_values,
        message: I18n.t(
          "activerecord.errors.invalid_values",
          values: invalid_values.join(", ")
        )
      )
    end

    if (roles & %w[formal_assessment_expert meaningful_assessment_expert]).count == 2
      errors.add(:roles, :exclusive_expert_values)
    end

    if (roles & %w[admin formal_assessment_expert]).count == 2 ||
        (roles & %w[admin meaningful_assessment_expert]).count == 2
      errors.add(:roles, :exclusive_admin_and_expert_values)
    end
  end
end
