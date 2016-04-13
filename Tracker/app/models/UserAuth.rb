class UserAuth
  def initialize(first_name="empty", last_name="empty", email="emtpy", user_id="empty")
    @first_name = first_name
    @last_name = last_name
    @email = email
    @user_id = user_id
  end

  def get_first_name
    @first_name
  end

  def set_first_name(first_name)
    @first_name = first_name
  end

  def get_last_name
    @last_name
  end

  def set_last_name(last_name)
    @last_name = last_name
  end

  def get_email
    @email
  end

  def set_email(email)
    @email = email
  end
  def get_user_id
    @user_id
  end
  def set_user_id(user_id)
    @user_id = user_id
  end
end
