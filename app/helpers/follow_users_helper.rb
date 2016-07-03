module FollowUsersHelper
  def user_follow_link_to(other_user)
    if logged_in?
      if current_user.following? other_user
        link_to 'フォローを解除', user_follow_user_path(other_user), remote: true, method: :delete, class: 'btn btn-danger btn-block'
      else
        link_to 'フォローする', user_follow_user_path(other_user), remote: true, method: :post, class: 'btn btn-success btn-block'
      end
    else
      link_to 'フォローする', login_path, class: 'btn btn-success btn-block'
    end
  end
end

