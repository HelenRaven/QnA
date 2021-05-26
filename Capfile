# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"
require "capistrano/rvm"
require "capistrano/bundler"
require "capistrano/rails"
# require "capistrano/passenger"
require "thinking_sphinx/capistrano"
require "whenever/capistrano"
require "capistrano3/unicorn"

require 'capistrano/sidekiq'
install_plugin Capistrano::Sidekiq # Default sidekiq tasks
# Then select your service manager
install_plugin Capistrano::Sidekiq::Systemd
# or
# install_plugin Capistrano::Sidekiq::Upstart  # tests needed
# or
# install_plugin Capistrano::Sidekiq::Monit  # tests needed

# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
