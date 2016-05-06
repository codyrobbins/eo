module ArtworksHelper
  # Pagination.
  public

    def artworks_page_path(increment)
      artworks_path(page + increment)
    end

    def artworks_path(page)
      super(page: page)
    end

    def number_of_pagination_buttons
      7
    end

    def pagination_buttons
      first_pagination_button..last_pagination_button
    end

  protected

    def first_pagination_button
      [page - ((number_of_pagination_buttons - 1) / 2), 1].max
    end

    def last_pagination_button
      first_pagination_button + number_of_pagination_buttons - 1
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
