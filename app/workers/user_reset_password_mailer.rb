class UserResetPasswordMailer
  @queue = :reset_pw_emailer

  def self.perform(user_id)
    user = User.find(user_id)
    Mailer.password_reset(user).deliver
  end
end