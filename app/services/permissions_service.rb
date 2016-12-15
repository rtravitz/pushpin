class PermissionsService
  def initialize(user, controller, action)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def allow?
    if user.admin?
      admin_permissions
    elsif user.professional?
      professional_permissions
    elsif user.requester?
      requester_permissions
    else
      guest_permissions
    end
  end

  private
    attr_reader :user, :controller, :action

    def admin_permissions
      return true if controller == "admin/dashboard" && action == "show"
      return true if controller == "admin/update_user" && action == "update_status"
    end

    def professional_permissions
    end

    def requester_permissions
    end

    def guest_permissions
      return true if controller == "home" && action == "index"
      return true if controller == "skills" && action == "show"
      return true if controller == "sessions" && action.in?(%w(new create))
    end
end
