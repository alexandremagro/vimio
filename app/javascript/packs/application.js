require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')
require('bootstrap/dist/js/bootstrap')

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener('DOMContentLoaded', function () {
  const parent = document.getElementById('page-alerts')

  if (parent) {
    parent.querySelectorAll('.page-alert').forEach(function (alert, i) {
      setTimeout(
        function () { parent.removeChild(alert) },
        4000 + (50 * i)
      )
    })
  }
})
