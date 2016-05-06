class User < Model
  # Attributes.
  attr_accessor(:id,
                :username,
                :full_name,
                :created_at,
                :bio,
                :private,
                :hidden,
                :following_count,
                :followers_count,
                :playlists_count,
                :avatar_images)

  # Information.
  public

    def full_name?
      full_name.present?
    end

    def bio?
      bio.present?
    end

  # Avatar.
  public

    def avatar_url
      image_url(avatar_images)
    end
end