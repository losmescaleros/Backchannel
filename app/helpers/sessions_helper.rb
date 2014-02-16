module SessionsHelper
  # Helper method for signing in a user
  def sign_in(user)
    # Get a new token for a user
    remember_token = User.new_remember_token
    # Put the unencrypted token in the browser cookie. Permanent cookie type
    # will set expiry to last after browser close
    cookies.permanent[:remember_token] = remember_token
    # Persist the encrypted token in the db
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    # Current user is this user
    self.current_user = user
  end

  # Store the current user for later references
  def current_user=(user)
    @current_user = user
  end

  # Get the current user based on the remember_token in cookies
  def current_user
    encrypted_remember_token = User.encrypt(cookies[:remember_token])
    # '||=' means set the current_user but ONLY if it is UNDEFINED
    # if current_user is already defined, we don't query the db and return whatever it is
    @current_user ||= User.find_by_remember_token(encrypted_remember_token)
  end

  def current_user?(user)
    @current_user == user
  end

  # Returns true if the user is signed in, false otherwise
  def signed_in?
    !current_user.nil?
  end

  # Remove the current remember_token and set the current user to nil
  def sign_out
    new_remember_token = User.new_remember_token
    current_user.update_attribute(:remember_token, User.encrypt(new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end
