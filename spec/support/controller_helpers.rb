module ControllerHelpers
  # Based on http://willschenk.com/setting-up-testing/ and
  # http://kentaroimai.com/articles/1-controller-test-helpers-for-warden
  # for request.env['warden'] initialization
  def login_with(user = double('user'), scope = :user)
    manager = Warden::Manager.new(nil, &Rails.application.config.middleware.detect{|m| m.name == 'Warden::Manager'}.block)
    request.env['warden'] = Warden::Proxy.new(request.env, manager)
    current_user = "current_#{scope}".to_sym

    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => scope})
      allow(controller).to receive(current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(current_user).and_return(user)
    end
  end

  def logged_out
    manager = Warden::Manager.new(nil, &Rails.application.config.middleware.detect{|m| m.name == 'Warden::Manager'}.block)
    request.env['warden'] = Warden::Proxy.new(request.env, manager)
    current_user = nil
    allow(request.env['warden']).to receive(:authenticate!).and_return(nil)
  end
end
