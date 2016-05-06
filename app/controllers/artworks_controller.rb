class ArtworksController < ApplicationController
  # Index.
  helper_method(:page)

  public

    def index
      @artworks = artworks
    end

  protected

    def artworks
      Artwork.all(page)
    end

    def page
      page_param.to_i
    end

    def page_param
      params[:page]
    end

  # Show.
  helper_method(:id,
                :artwork)

  protected

    def id
      params[:id]
    end

    def artwork
      @artwork ||= get_artwork
    end

    def get_artwork
      Artwork.find(id)
    end
end
