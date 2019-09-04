class AdminAbility
  include CanCan::Ability

  def initialize(preview_access_token: nil, admin: nil)
    return unless preview_access_token || admin
    models = [
        Collective,
        Event,
        EventDate,
        Nomination,
        Performance,
        PerformanceFormat,
    ]

    if admin.presence && admin.roles.include?("admin")
      can :manage, :all
    elsif preview_access_token.present? && preview_access_token == Rails.application.secrets.preview_access_token
      can :read, models

    else
      models.each do |klass|
        if klass.method_defined? :published?
          can :read, klass, klass.published do |object|
            object.published?
          end
        else
          can :read, klass
        end
      end

    end
  end
end
