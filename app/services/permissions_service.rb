class PermissionsService
  def initialize(user, controller, action)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def allow?
    permission = guest_permissions
    return permission if permission
    if user.requester?
      permission = requester_permissions
      return permission if permission
    end
    if user.professional?
      permission = professional_permissions
      return permission if permission
    end
    if user.admin?
      permission = admin_permissions
      return permission if permission
    end
  end

  private
    attr_reader :user, :controller, :action

    def admin_permissions
      return true if controller == "admin/dashboard" && action == "show"
      return true if controller == "admin/update_user" && action.in?(%w(update_status destroy_user))
      return true if controller == "users" && action.in?(%w(edit update show))
      return true if controller == "confirmations" && action.in?(%w(new update))
      return true if controller == "sessions" && action == "destroy"
    end

    def professional_permissions
      return true if controller == "professional/dashboard" && action == "show"
      return true if controller == "users" && action.in?(%w(edit update show))
      return true if controller == "confirmations" && action.in?(%w(new update))
      return true if controller == "sessions" && action == "destroy"
      return true if controller == "professional/projects" && action.in?(%w(index show))
      return true if controller == "professional/proposals" && action.in?(%w(new create show destroy))
      return true if controller == "requesters" && action == "show"
      return true if controller == "messages" && action.in?(%w(create destroy edit update))
      return true if controller == "professional/ratings" && action.in?(%w(create))
      return true if controller == "professional/skills" && action.in?(%w(new create destroy))
      return true if controller == "confirmations" && action.in?(%w(new update))

    end

    def requester_permissions
      return true if controller == "requester/dashboard" && action == "show"
      return true if controller == "requester/projects" && action.in?(%w(new create show edit show))
      return true if controller == "users" && action.in?(%w(edit update show))
      return true if controller == "confirmations" && action.in?(%w(new update))
      return true if controller == "sessions" && action == "destroy"
      return true if controller == "requester/ratings" && action == "create"
      return true if controller == "requester/proposals" && action.in?(%w(show edit update))
      return true if controller == "messages" && action.in?(%w(create destroy edit update))
      return true if controller == "confirmations" && action.in?(%w(new update))
    end

    def guest_permissions
      return true if controller == "home" && action == "index"
      return true if controller == "professionals" && action.in?(%w(index show))
      return true if controller == "sessions" && action.in?(%w(new create))
      return true if controller == "users" && action.in?(%w(new create))
      return true if controller == "skills" && action.in?(%w(index show))
      return true if controller == "api/v1/messages" && action.in?(%w(index create))
    end
end
