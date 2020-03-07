# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"
<<<<<<< HEAD
=======
#
################################################################################
#### Customizations ############################################################
################################################################################
#
#
###################################
#### Disable Tree-View #########################################################
###################################
#
# This only toggles tree view, so it toggles on opening every two windows. I just disabled tree view package.
# VALUE = VALUE # VALUE is the value that denotes that the tree-view mode is on. 0 or 1, maybe?
# OTHERVALUE = OTHERVALUE # OTHERVALUE is the value that toggles thre tree-view mode OFF
# atom.packages.onDidActivateInitialPackages ->
#   workspaceView = atom.views.getView(atom.workspace);
#   # if workspaceView == VALUE
#   # atom.views.set(OTHERVALUE) # I'm not sure if the right function is .set()
#   atom.commands.dispatch(workspaceView, 'tree-view:toggle');
>>>>>>> 8560e0b32bd6083347a17254f4a5ba3132cc3bf5
