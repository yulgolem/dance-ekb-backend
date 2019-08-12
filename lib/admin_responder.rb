class AdminResponder < ActionController::Responder
  DEFAULT_ACTIONS_FOR_VERBS = {
    post: :new,
    patch: :edit,
    # delete: :edit, # renders edit if there were errors while trying to destroy
    put: :edit,
  }.freeze

  def default_action
    @action ||= DEFAULT_ACTIONS_FOR_VERBS[request.request_method_symbol]
  end
end
