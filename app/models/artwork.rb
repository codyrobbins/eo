class Artwork < Model
  # Attributes.
  attr_accessor(:id,
                :param,
                :title,
                :description,
                :artist_name,
                :is_original,
                :is_premium,
                :display_url,
                :created_at,
                :updated_at,
                :published_at,
                :total_time_displayed,
                :users_currently_displaying_count,
                :users_displayed_count,
                :resolution,
                :user,
                :filetype,
                :static_previews,
                :animated_previews,
                :video_previews)

  # Retrieval.
  public

    def self.find(id)
      all(1).first

      # TODO: Replace with API call.
#      super(artwork_json(id))
    end

    def self.all(page)
      build(artworks_json(page))
    end

  protected

    def self.artworks_json(page)
      get("?offset=#{(page - 1) * 50}")
    end

    def self.get(path)
      Net::HTTP.get(URI("http://open-api.electricobjects.com/v4/artworks#{path}"))
    end

  # Information.
  public

    def displayed?
      total_time_displayed > 0
    end

    def currently_displayed?
      users_currently_displaying_count > 0
    end

    def popular?
      total_time_displayed > 10.hours
    end

    def user
      User.new(@user)
    end

  # Thumbnail.
  public

    def thumbnail_url
      image_url(thumbnails)
    end

  protected

    def thumbnails
      animated_previews + static_previews
    end

    def animated_previews
      Array.wrap(@animated_previews)
    end

    def static_previews
      Array.wrap(@static_previews)
    end

  # Favorited by.
  public

    def favorited_by_anyone?
      favorited_by.present?
    end

    def favorited_by
      @favorited_by ||= get_favorited_by
    end

  protected

    def get_favorited_by
      User.build(favorited_by_json)
    end

    def favorited_by_json
      get('users/favorited')
    end

    def get(path)
      Artwork.get("/#{id}/#{path}")
    end

  # Recommendations.
  public

    def recommendations?
      recommendations.present?
    end

    def recommendations
      @recommendations ||= get_recommendations
    end

  protected

    def get_recommendations
      Artwork.build(recommendations_json)
    end

    def recommendations_json
      get(:recommended)
    end
end