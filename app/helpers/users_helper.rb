module UsersHelper
  def user_initials(user)
    user.name.to_s.split(/\s+/).reject(&:blank?).first(2).map { |word| word[0]&.upcase }.join.presence || "U"
  end

  def user_avatar(user, size: :md)
    classes = ["user-avatar", "user-avatar-#{size}"]

    content_tag(:div, class: classes.join(" ")) do
      if user.avatar&.attached?
        image_tag(user.avatar, alt: "#{user.name}'s profile photo", class: "user-avatar-img")
      else
        content_tag(:span, user_initials(user), class: "user-avatar-initials")
      end
    end
  end
end
