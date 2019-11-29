document.addEventListener('turbolinks:load', function () {
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
