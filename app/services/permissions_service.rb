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
      return true if controller == "admin/update_user" && action.in?(%w(update_status destroy_user))
      return true if controller == "users" && action.in?(%w(edit update))
      return true if controller == "confirmations" && action.in?(%w(new update))
      return true if controller == "sessions" && action == "destroy"
    end

    def professional_permissions
      return true if controller == "professional/dashboard" && action == "show"
      return true if controller == "users" && action.in?(%w(edit update))
      return true if controller == "confirmations" && action.in?(%w(new update))
      return true if controller == "sessions" && action == "destroy"
    end

    def requester_permissions
      return true if controller == "requester/dashboard" && action == "show"
      return true if controller == "users" && action.in?(%w(edit update))
      return true if controller == "confirmations" && action.in?(%w(new update))
      return true if controller == "sessions" && action == "destroy"
    end

    def guest_permissions
      return true if controller == "home" && action == "index"
      return true if controller == "skills" && action == "show"
      return true if controller == "professionals" && action == "index"
      return true if controller == "sessions" && action.in?(%w(new create))
      return true if controller == "users" && action.in?(%w(new create))
      return true if controller == "skills" && action.in?(%w(index show))
    end
end
