var videojs = require('video.js').default
require('@videojs/http-streaming')

document.addEventListener('turbolinks:load', function () {
  const videos = document.querySelectorAll('.video-js')

  videos.forEach(function (video) {
    videojs(video).ready(function () {
      // Look at parent because VideoJS wrap it
      const node = video.parentElement

      // Register events only if it's not a preview
      if (node.classList.contains('video-preview')) {
        return
      }

      this.on('loadstart', function () {
        $.ajax({
          url: '/videos/' + node.dataset.id + '/view',
          method: 'POST',
          success: function (data) {
            const value = data.view_count

            // On success, update the counter on page
            document
              .getElementById('view-count')
              .textContent = value + [' view', ' views'][Number(value > 1)]
          }
        })
      })
    })
  })
})
