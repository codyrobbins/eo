class @User extends React.Component
  render: ->
    `<div className="col-xs-12 col-sm-3 col-md-2 text-center">
  <Image images={this.user().avatar_images} alt={this.user().username + '’s avatar'} />
  <h3>{this.user().username}</h3>
  <p>
    <span className="glyphicon glyphicon-user"></span>
    Followers: {this.user().followers_count}
  </p>
  <p>
    <span className="glyphicon glyphicon-star"></span>
    Following: {this.user().following_count}
  </p>
  <p>
    <span className="glyphicon glyphicon-list"></span>
    Playlists: {this.user().playlists_count}
  </p>
</div>
`

  user: ->
    @props.user