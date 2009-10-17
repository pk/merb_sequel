# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pk-merb_sequel}
  s.version = "1.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Wayne E. Seguin, Lance Carlson, Lori Holden, Pavel Kunc"]
  s.date = %q{2009-10-17}
  s.description = %q{Merb plugin that provides support for Sequel and Sequel::Model}
  s.email = %q{wayneeseguin@gmail.com, lancecarlson@gmail.com, email@loriholden.com, pavel.kunc@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE", "TODO"]
  s.files = ["CHANGELOG", "LICENSE", "README.rdoc", "Rakefile", "TODO", "Generators", "lib/generators", "lib/generators/migration.rb", "lib/generators/model.rb", "lib/generators/resource_controller.rb", "lib/generators/session_migration.rb", "lib/generators/templates", "lib/generators/templates/migration", "lib/generators/templates/migration/schema", "lib/generators/templates/migration/schema/migrations", "lib/generators/templates/migration/schema/migrations/%file_name%.rb", "lib/generators/templates/model", "lib/generators/templates/model/app", "lib/generators/templates/model/app/models", "lib/generators/templates/model/app/models/%file_name%.rb", "lib/generators/templates/resource_controller", "lib/generators/templates/resource_controller/app", "lib/generators/templates/resource_controller/app/controllers", "lib/generators/templates/resource_controller/app/controllers/%file_name%.rb", "lib/generators/templates/resource_controller/app/views", "lib/generators/templates/resource_controller/app/views/%file_name%", "lib/generators/templates/resource_controller/app/views/%file_name%/edit.html.erb", "lib/generators/templates/resource_controller/app/views/%file_name%/index.html.erb", "lib/generators/templates/resource_controller/app/views/%file_name%/new.html.erb", "lib/generators/templates/resource_controller/app/views/%file_name%/show.html.erb", "lib/generators/templates/session_migration", "lib/generators/templates/session_migration/schema", "lib/generators/templates/session_migration/schema/migrations", "lib/generators/templates/session_migration/schema/migrations/%version%_sessions.rb", "lib/merb", "lib/merb/orms", "lib/merb/orms/sequel", "lib/merb/orms/sequel/connection.rb", "lib/merb/orms/sequel/database.yml.sample", "lib/merb/orms/sequel/model.rb", "lib/merb/session", "lib/merb/session/sequel_session.rb", "lib/merb_sequel", "lib/merb_sequel/merbtasks.rb", "lib/merb_sequel/rspec", "lib/merb_sequel/rspec/sequel.rb", "lib/merb_sequel.rb"]
  s.homepage = %q{http://github.com/pk/merb_sequel}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pk-merb_sequel}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Merb plugin that provides support for Sequel and Sequel::Model}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<merb-core>, [">= 0.9.9"])
      s.add_runtime_dependency(%q<sequel>, [">= 1.4.0"])
    else
      s.add_dependency(%q<merb-core>, [">= 0.9.9"])
      s.add_dependency(%q<sequel>, [">= 1.4.0"])
    end
  else
    s.add_dependency(%q<merb-core>, [">= 0.9.9"])
    s.add_dependency(%q<sequel>, [">= 1.4.0"])
  end
end
