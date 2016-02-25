# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(freewall.js)
Rails.application.config.assets.precompile += %w(jstz.min.js)
Rails.application.config.assets.precompile += %w(rails-timezone.min.js)
Rails.application.config.assets.precompile += %w(jquery.minicolors.js)
Rails.application.config.assets.precompile += %w(jquery.ba-outside-events.min.js)
Rails.application.config.assets.precompile += %w(isotope.pkgd.min.js)

Rails.application.config.assets.precompile += %w(jquery.minicolors.css)

Rails.application.config.assets.precompile += %w( editable/loading.gif )
Rails.application.config.assets.precompile += %w( editable/clear.png )

Rails.application.config.assets.precompile += %w(comments.js)
Rails.application.config.assets.precompile += %w(publication_requests.js)
Rails.application.config.assets.precompile += %w(password_resets.js)
Rails.application.config.assets.precompile += %w(request_attachments.js)
Rails.application.config.assets.precompile += %w(sessions.js)
Rails.application.config.assets.precompile += %w(templates.js)
Rails.application.config.assets.precompile += %w(users.js)
Rails.application.config.assets.precompile += %w(statuses.js)
Rails.application.config.assets.precompile += %w(welcome.js)

Rails.application.config.assets.precompile += %w( comments.css )
Rails.application.config.assets.precompile += %w( publication_requests.css )
Rails.application.config.assets.precompile += %w( password_resets.css )
Rails.application.config.assets.precompile += %w( request_attachments.css )
Rails.application.config.assets.precompile += %w( sessions.css )
Rails.application.config.assets.precompile += %w( templates.css )
Rails.application.config.assets.precompile += %w( users.css )
Rails.application.config.assets.precompile += %w( statuses.css )
Rails.application.config.assets.precompile += %w( welcome.css )
