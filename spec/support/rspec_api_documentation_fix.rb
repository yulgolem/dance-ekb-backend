module RspecApiDocumentation::DSL::Endpoint
  # TODO create pull request
  def set_param(hash, param)
    key = param[:name]
    var_name = param[:var] || key
    return hash if !respond_to?(var_name) || in_path?(key)

    if param[:scope]
      hash[param[:scope].to_s] ||= {}
      hash[param[:scope].to_s][key] = send(var_name)
    else
      hash[key] = send(var_name)
    end

    hash
  end
end
