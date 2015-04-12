class CollaborationPolicy < ApplicationPolicy
  def destroy?
    wiki_owner = record.wiki.user
    user.present? && (user == wiki_owner || user.admin?)
  end
end
