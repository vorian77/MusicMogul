class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :manage, User, id: user.id
      can :manage, Entry, user_id: user.id
      can :read, :all
    else
      can :read, :all
    end
  end
end
