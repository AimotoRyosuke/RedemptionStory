module UsersHelper
  def mypage?
    @user.id == current_user.id
  end
end
