# Be sure to restart your server when you modify this file.

# Version of your vue-sample-assets, change this if you want to expire all your vue-sample-assets.
Rails.application.config.assets.version = '1.0'

# Add additional vue-sample-assets to the asset load path.
# Rails.application.config.vue-sample-assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional vue-sample-assets.
# application.js, application.css, and all non-JS/CSS in the app/vue-sample-assets
# folder are already added.
# Rails.application.config.vue-sample-assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w(admin.js admin.css default.css vue-sample-app.css vue-material.min.css vue-sample-app.js)
