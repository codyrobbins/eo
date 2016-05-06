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
  <div className="page-header">
    <h1>
      {this.artwork().title} <small>By {this.artwork().artist_name}</small>
    </h1>
  </div>
  <div className="text-center">
    <img src={this.artwork().display_url} alt={'The full artwork for ‘' + this.artwork().title + '’'} />
  </div>
  <h3>Uploaded By</h3>
  <div className="container-fluid">
    <User user={this.artwork().user} />
    <div className="col-xs-12 col-sm-9 col-md-10">
      <ul className="list-group">
        <li className="list-group-item">
          <span className="glyphicon glyphicon-hourglass"></span>
          Added {this.publishedInterval()}
        </li>
        {this.currentDisplayInformationIfCurrentlyDisplayed()}
        {this.displayInformationIfDisplayed()}
      </ul>
    </div>
  </div>
  {this.recommendedArtworksIfPresent()}
  {this.favoritedUsersIfPresent()}
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
    @notEmpty(@recommendedArtworks())

  recommendedArtworks: ->
    @state.recommendedArtworks

  notEmpty: (array) ->
    array?.length > 0

  recommendedArtworksList: ->
    `<div>
  <h3>Similar Artwork</h3>
  <ArtworkList artwork={this.recommendedArtworks()} />
</div>
`

  favoritedUsersIfPresent: ->
    @favoritedUsersList() if @favoritedUsersPresent()

  favoritedUsersPresent: ->
    @notEmpty(@favoritedUsers())

  favoritedUsers: ->
    @state.favoritedUsers

  favoritedUsersList: ->
    `<div>
  <h3>Favorited By</h3>
  <div className="container-fluid">{this.favoritedUserComponents()}</div>
</div>
`

  favoritedUserComponents: ->
    @favoritedUsers().map (user) =>
      @favoritedUserComponent(user)

  favoritedUserComponent: (user) ->
    `<User user={user} />`