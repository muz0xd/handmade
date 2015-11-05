# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'handmade'
set :repo_url, 'git@github.com:muz0xd/handmade.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/site/handmade'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Symlink shared config files'
  task :symlink_config_files do
    on roles(:all) do
      execute "ln -s #{deploy_to}/shared/config/database.yml #{deploy_to}/current/config/database.yml"
    end
  end

  desc 'Server stop'
  task :server_stop do
    on roles(:all) do
      execute "sudo kill -9 $(cat #{deploy_to}/current/tmp/pids/server.pid)"
      execute "sudo rm -r #{deploy_to}/current/tmp"
      execute "cp -r #{deploy_to}/current/public/assets/image_attachments #{deploy_to}/shared/buffer/"
    end
  end

  desc 'Install gems and migrate'
  task :bundle do
    on roles(:all) do
      execute "cd #{deploy_to}/current && bundle install"
      #execute "cd #{deploy_to}/current && RAILS_ENV=production sudo rake db:migrate"
    end
  end

  desc 'Copy previous image attachments and compile assets'
  task :assets do
    on roles(:all) do
      execute "cd #{deploy_to}/current && sudo rake assets:precompile"
      execute "sudo chown site:users #{deploy_to}/current/public/assets/"
      execute "cp -r #{deploy_to}/shared/buffer/image_attachments/ #{deploy_to}/current/public/assets/"
    end
  end

  desc 'Server start'
  task :server_start do
    on roles(:all) do
      as :site do
        app_env = ["SECRET_KEY_BASE=$(cat #{deploy_to}/shared/secret_key)", "RAILS_SERVE_STATIC_FILES='TRUE'"].join(' ')
        execute "cd #{deploy_to}/current && sudo #{app_env} rails server thin -e production -b 5.63.153.15 -p 80 -d"
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

before "deploy", "deploy:server_stop"

after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:bundle"
after "deploy", "deploy:assets"
after "deploy", "deploy:cleanup"
after "deploy", "deploy:server_start"
