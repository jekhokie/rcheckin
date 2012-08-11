module HomeHelper
  def state_button_link(name)
    if user_signed_in?
      return :controller => :conditions, :action => :update, :user_id => current_user.id, :condition => { :state => (name == 'IN' ? true : false) }
    else
      return '#'
    end
  end

  def state_button_class(name)
    button_class  = "btn btn-large"

    if user_signed_in?
      if name == "IN"
        button_class += " active btn-success" if user_signed_in? &&  current_user.condition.state
      elsif name == "OUT"
        button_class += " active btn-danger"  if user_signed_in? && !current_user.condition.state
      end
    else
      button_class += " btn-inverse disabled"
    end

    button_class
  end
end
