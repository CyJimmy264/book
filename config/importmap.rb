# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/models", under: "models"

pin "openpgp", to: "https://ga.jspm.io/npm:openpgp@5.2.1/dist/openpgp.min.mjs"
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.4.0/js/all.js"
