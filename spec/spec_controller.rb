class SpecController < Merb::Controller
  def clear
    session.clear  
    render session[:key].to_s
  end

  def change
    session[:key] = 'changed'
    render session[:key].to_s
  end
  
  def get
    render session[:key].to_s
  end

  def set
    session[:key] = 'value'
    render session[:key].to_s
  end
end
