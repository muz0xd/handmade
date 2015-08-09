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

  desc 'Server restart'
  task :server_restart do
    on roles(:all) do
      execute "sudo kill -9 $(cat tmp/pids/server.pid)"
      execute "sudo -E rails server thin -e production -b 5.63.153.15 -p 80 -d"
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

after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:server_restart"
after "deploy", "deploy:cleanup"