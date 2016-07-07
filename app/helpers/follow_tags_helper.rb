module FollowTagsHelper
  def tag_follow_link_to(tag)
    if logged_in?
      if current_user.following_tag? tag
        link_to 'フォローを解除', tag_follow_tag_path(tag), remote: true, method: :delete, class: 'btn btn-danger btn-block'
      else
        link_to 'フォローする', tag_follow_tag_path(tag), remote: true, method: :post, class: 'btn btn-success btn-block'
      end
    else
      link_to 'フォローする', login_path, class: 'btn btn-success btn-block'
    end
  end
end

