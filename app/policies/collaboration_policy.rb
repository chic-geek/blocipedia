class CollaborationPolicy < ApplicationPolicy
  def destroy?
    wiki_owner = record.wiki.user
    puts wiki_owner.inspect
    puts user.inspect
    puts record.inspect
    user.present? && (user == wiki_owner || user.admin?)
  end
end
