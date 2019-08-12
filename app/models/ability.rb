class Ability
  include CanCan::Ability

  def initialize
    models = [
      Article,
    ]

    if admin
      can :manage, :all
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
