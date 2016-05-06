module ArtworksHelper
  # Pagination.
  public

    def previous_page?
      page > 1
    end

    def artworks_previous_page_path
      artworks_path(-1)
    end

    def artworks_next_page_path
      artworks_path(+1)
    end

  protected

    def artworks_path(increment)
      super(page: page + increment)
    end

  # People.
  public

    def people_count(count)
      "#{number_with_delimiter(count)} #{people(count)}"
    end

  protected

    def people(count)
      'person'.pluralize(count)
    end
end
