require 'rails/generators'
require 'rails/generators/migration'

class PunchingBagGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.join(File.dirname(__FILE__), 'templates')

  def self.next_migration_number(dirname)
    sleep 1
    if timestamped_migrations?
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_migration_file
    migration_template 'create_punches_table.rb', 'db/migrate/create_punches_table.rb'
  end

  def self.timestamped_migrations?
    if Rails::VERSION::MAJOR >= 7
      ActiveRecord.timestamped_migrations
    else
      ActiveRecord::Base.timestamped_migrations
    end
  end
end
