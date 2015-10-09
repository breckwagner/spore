SporeView = require './spore-view'
{CompositeDisposable} = require 'atom'

module.exports = Spore =
  sporeView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @sporeView = new SporeView(state.sporeViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @sporeView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'spore:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @sporeView.destroy()

  serialize: ->
    sporeViewState: @sporeView.serialize()

  toggle: ->
    console.log 'Spore was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
