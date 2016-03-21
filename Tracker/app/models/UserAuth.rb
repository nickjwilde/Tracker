
class UserAuth
  def initialize(first_name, last_name, email, user_id)
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
end