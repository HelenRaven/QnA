$(document).on('turbolinks:load', function(){
   $('.questions').on('click', '.edit-question-link', editQuestion)
})

function editQuestion(event){
  event.preventDefault()
  $(this).hide()

  var questionId = $(this).data('questionId')
  $('form#edit-question-' + questionId).removeClass('hidden')

  $('#file-question-' + questionId + '.hidden-link').each(function(){
    $(this).removeClass('hidden-link')
  })
}
