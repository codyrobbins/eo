class @ArtworkDetails extends React.Component
  constructor: (props) ->
    super(props)
    @setInitialState()

  setInitialState: ->
    @state = {recommendedArtworks: [], favoritedUsers: []}

  componentDidMount: ->
    @getRecommendedArtworks()
    @getFavoritedUsers()

  getRecommendedArtworks: ->
    @ajax('recommended', @didLoadRecommendedArtworks)

  didLoadRecommendedArtworks: (artworks) =>
    @setState(recommendedArtworks: artworks)

  ajax: (path, callback) ->
    jQuery.getJSON("https://jsonp.afeld.me/?url=http://open-api.electricobjects.com/v4/artworks/#{@id()}/#{path}", callback)

  id: ->
    @artwork().id

  artwork: ->
    @props.artwork

  getFavoritedUsers: ->
    @ajax('users/favorited', @didLoadFavoritedUsers)

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
    @notEmpty(@state.recommendedArtworks)

  notEmpty: (array) ->
    array?.length > 0

  recommendedArtworksList: ->
    `<div>
  <h3>Similar Artwork</h3>
  <ArtworkList artwork={this.state.recommendedArtworks} />
</div>
`

  favoritedUsersIfPresent: ->
    @favoritedUsersList() if @favoritedUsersPresent()

  favoritedUsersPresent: ->
    @notEmpty(@state.favoritedUsers)

  favoritedUsersList: ->
    `<div>
  <h3>Favorited By</h3>
  <div className="container-fluid">{this.favoritedUsers()}</div>
</div>
`

  favoritedUsers: ->
    @state.favoritedUsers.map (user) ->
      `<User user={user} />`