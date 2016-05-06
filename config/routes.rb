Rails.application.routes.draw do
  with_options(format: false) do |r|
    r.with_options(defaults: {page: 1}) do |r|
      # Root.
      r.root('artworks#index')

      # Artwork index.
      r.get('artworks/page/:page',
            to:          'artworks#index',
            as:          :artworks,
            constraints: {page: /\d+/})
    end

    # Artwork show.
    r.resources(:artworks,
                only: :show)

    # React.
    r.get('react' => 'react#index')
  end
end
