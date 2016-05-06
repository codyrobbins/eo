class @LoadingIndicator extends React.Component
  render: ->
    `<div>{this.indicator()}</div>`

  indicator: ->
    `<div className="loading-indicator">
  <p>Loading…</p>
  <img src="/assets/loading.gif" alt="Loading" />
</div>
` if @loading()

  loading: ->
    Utility.isEmpty(@props.content)