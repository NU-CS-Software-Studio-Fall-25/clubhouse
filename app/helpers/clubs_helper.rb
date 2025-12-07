module ClubsHelper
  def club_initials(club)
    club.name.to_s.split(/\s+/).reject(&:blank?).first(2).map { |word| word[0]&.upcase }.join.presence || "C"
  end

  def club_avatar(club, size: :md)
    classes = ["club-avatar", "club-avatar-#{size}"]

    content_tag(:div, class: classes.join(" ")) do
      if club.profile_photo.attached?
        image_tag(club.profile_photo, alt: "#{club.name} profile photo", class: "club-avatar-img")
      else
        content_tag(:span, club_initials(club), class: "club-avatar-initials")
      end
    end
  end
end
