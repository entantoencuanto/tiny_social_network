Warden::Strategies.add(:password) do
  def valid?
    ['/users/sessions'].include?(request.path) and params['user']
  end

  def authenticate!
    if u = User.find_by(user_name: params['user']['user_name'])
      u.authenticate(params['user']['password']) ? success!(u) : fail!
    else
      fail!
    end
  end
end
