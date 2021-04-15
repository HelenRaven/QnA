import consumer from "./consumer"

$(document).on('turbolinks:load', function(){


  if($('.answers') ){
    var path = $(location).attr('pathname').split('/')
    consumer.subscriptions.create({channel: 'AnswersChannel', question: path[2]},{
      received(data){

        if (gon.current_user_id != data.answer.user_id){
          var result = this.createTemplate(data)
          $('.answers').append(result)
        }
      },

      createTemplate(data){
        var result =  `
        <div class = "answer-#${data.answer.id}">
          <p> ${data.answer.body}</p>
          <p> Rating: 0 </p>
        </div>
        `
        $.each(data.links, function(index, value) {
          result += `<a href = ${value.url}> ${value.name} </a>`
        })

        return result
      }
    })
  }
})
