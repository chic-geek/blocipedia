class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    # false
    # ask eliot where the `present?` method is coming from?
    user.present?

  end

  def new?
    create?
  end

  def update?
    # a user needs to be either the record's owner or the general
    # administrator, on top of being present and logged-in
    user.present? && (record.user == user || user.admin?)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def scope
    # default pundit scope class, this is removed for the bloccit app
    # ask eliot to explain this a little better than bloc has and
    # whether or not changing this helped?
    # Pundit.policy_scope!(user, record.class)
    record.class
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
