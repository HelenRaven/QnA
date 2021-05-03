$(document).on('turbolinks:load', function(){
  $('.subscribe').on('click', function(){
      $('.subscribe' ).addClass('d-none')
      $('.unsubscribe' ).removeClass('d-none')
  })
  $('.unsubscribe').on('click', function(){
      $('.unsubscribe' ).addClass('d-none')
      $('.subscribe' ).removeClass('d-none')
  })
})
