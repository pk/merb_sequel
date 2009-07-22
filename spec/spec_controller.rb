class SpecController < Merb::Controller
  def set
    session[:key] = 'value'
    render session[:key].to_s
  end
  
  def get
    render session[:key].to_s
  end
end
