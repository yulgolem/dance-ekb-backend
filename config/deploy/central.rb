set :domain, "<some_domain>"
set :forward_agent,       true
set :rails_env,           "production"
set :branch,              "master"
set :slack_stage,         "production"
set :whenever_roles, %i[db central public]

desc "Deploys the current version to the server."
task deploy: :environment do
  deploy do
    queue! 'echo -e "host: \033[1;35m`hostname`\033[0m"'
    invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    queue %(
      #{echo_cmd %(yarn install)}
    )
    # invoke :'rails:db_create'
    invoke :'rails:db_migrate'
    # queue %{
    #   echo "-----> Seeding database"
    #   #{echo_cmd %[#{rake} db:seed]}
    # }
    invoke :'rails:assets_precompile_with_symlink'
    invoke :'whenever:update'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :restart
      invoke :'sidekiq:restart'
    end
  end
end

desc "Deploys the current version to the server for the first time."
task first_deploy: :environment do
  deploy do
    queue! 'echo -e "host: \033[1;35m`hostname`\033[0m"'
    invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    queue %(
      #{echo_cmd %(yarn install)}
    )
    # queue %{
    #   echo "-----> Dropping database"
    #   #{echo_cmd %[#{rake} db:drop]}
    # }
    invoke :'rails:db_create'
    # queue %{
    #   echo "-----> Force migrating database"
    #   #{echo_cmd %[#{rake} db:migrate]}
    # }
    invoke :'rails:db_migrate'
    # invoke :'rails:db_seed'
    invoke :'rails:assets_precompile_with_symlink'
    invoke :'whenever:update'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :start
    end
  end
end
