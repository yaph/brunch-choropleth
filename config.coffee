exports.config =
  # See http://brunch.io/#documentation for docs.
  files:
    javascripts:
      joinTo:
        'scripts/app.js': /^app/
        'scripts/vendor.js': /^(?!app)/

    stylesheets:
      defaultExtension: 'scss'
      joinTo:
        'styles/app.css'

  # Activate the brunch plugins
  plugins:
    sass:
      debug: 'comments'
