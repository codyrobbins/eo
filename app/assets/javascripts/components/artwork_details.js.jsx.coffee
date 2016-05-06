class @ArtworkDetails extends React.Component
  constructor: (props) ->
    super(props)
    @setInitialState()

  setInitialState: ->
    @state = @initialState

  initialState: {
    recommendedArtworks: [],
    favoritedUsers: []
  }

  componentDidMount: ->
    @getRecommendedArtworks()
    @getFavoritedUsers()

  getRecommendedArtworks: ->
    @api('recommended', @didLoadRecommendedArtworks)

  api: (path, callback) ->
    API.load(@apiPath(path), callback)

  apiPath: (path) ->
    "#{@id()}/#{path}"

  id: ->
    @artwork().id

  artwork: ->
    @props.artwork

  didLoadRecommendedArtworks: (artworks) =>
    @setState(recommendedArtworks: artworks)

  getFavoritedUsers: ->
    @api('users/favorited', @didLoadFavoritedUsers)

  didLoadFavoritedUsers: (users) =>
    @setState(favoritedUsers: users)

  render: ->
    `<div className="artwork-details">
  <button type="button" className="close" onClick={this.props.closeHandler}>×</button>
  <ArtworkHeader artwork={this.artwork()} />

  <div className="container-fluid details">
    <div className="row">
      <div className="col-xs-12 col-sm-10">
        <img src={this.artwork().display_url} alt={'The full artwork for ‘' + this.artwork().title + '’'} className="full-artwork" />
      </div>
      <div className="col-xs-12 col-sm-2">
        <h3 className="uploaded-by">Uploaded By</h3>
        <User user={this.artwork().user} />
        {this.favoritedUsersIfPresent()}
      </div>
    </div>
  </div>
  {this.recommendedArtworksIfPresent()}
</div>
`

  publishedInterval: ->
    @timeAgoInWords(this.artwork().published_at)

  timeAgoInWords: (time) ->
    jQuery.timeago(time)

  currentDisplayInformationIfCurrentlyDisplayed: ->
    @currentDisplayInformation() if @currentlyDisplayed()

  currentlyDisplayed: ->
    @artwork().users_currently_displaying_count > 0

  currentDisplayInformation: ->
    `<li className="list-group-item">
  <span className="glyphicon.glyphicon-facetime-video"></span>
  Currently displayed by {this.artwork().users_currently_displaying_count} person
</li>
`

  displayInformationIfDisplayed: ->
    @displayInformation() if @displayed()

  displayed: ->
    @artwork().total_time_displayed > 0

  displayInformation: ->
    `<li className="list-group-item">
  <span className="glyphicon.glyphicon-open-eye"></span>
  Displayed for {this.hoursDisplayed()} hours by {this.artwork().users_displayed_count} person
</li>
`

  hoursDisplayed: ->
    Math.round(this.artwork().total_time_displayed / 60)

  recommendedArtworksIfPresent: ->
    @recommendedArtworksList() if @recommendedArtworksPresent()

  recommendedArtworksPresent: ->
    Utility.isNotEmpty(@recommendedArtworks())

  recommendedArtworks: ->
    @state.recommendedArtworks

  recommendedArtworksList: ->
    `<div>
  <h2 className="recommended-artworks">Browse Similar Artwork</h2>
  <ArtworkList artwork={this.recommendedArtworks()} />
</div>
`

  favoritedUsersIfPresent: ->
    @favoritedUsersList() if @favoritedUsersPresent()

  favoritedUsersPresent: ->
    Utility.isNotEmpty(@favoritedUsers())

  favoritedUsers: ->
    @state.favoritedUsers

  favoritedUsersList: ->
    `<div>
  <h3>Favorited By</h3>
  <LoadingIndicator content={this.favoritedUsers()} />
  {this.favoritedUserComponents()}
</div>
`

  favoritedUserComponents: ->
    @favoritedUsers().map (user) =>
      @favoritedUserComponent(user)

  favoritedUserComponent: (user) ->
    `<User user={user} key={user.id} />`