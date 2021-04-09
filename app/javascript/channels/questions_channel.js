import consumer from "./consumer"

$(document).on('turbolinks:load', function(){
  var path = $(location).attr('pathname').split('/')

  if(path[1] == 'questions' && path.length == 2){
    consumer.subscriptions.create('QuestionsChannel',{
      received(data){
        var result = this.createTemplate(data.question)
        $('.questions').append(result)
      },

      createTemplate(question){
        return `
        <div class = "question-#${question.id}">
          <a  title = ${question.title} href = 'questions/${question.id}'> ${question.title}</a>
        </div>
        `
      }
    })
  }
})
