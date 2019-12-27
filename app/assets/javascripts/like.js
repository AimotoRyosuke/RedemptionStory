$(function(){
  function appendLike(likes){
    like = `
          <form class="show__content__left__like like" action="/posts/3/likes/${likes.user_id}" accept-charset="UTF-8" data-remote="true" method="delete">
            <input name="utf8" type="hidden" value="✓">
            <input type="hidden" name="authenticity_token" value="XBlI/nAe5vR8Q+zAnMogXuu3MDxpLeQ1JiMIG65m1JiVBaVTMgzqLSBoHgbxq2jgWp7IOHV37H46URMDjyFplg==">
            <input type="submit" name="commit" value="submit" class="show__content__left__like__hidden" id="like" data-disable-with="submit">
            <label for="like"><i class="fas fa-heart show__content__left__like__icon"></i>
            </label><p class="show__content__left__like__nubmer">${likes.length}</p>
          </form>
            `
    $('.show__content__left').append(like)
  }

  function appendUnlike(likes){
    unlike = `
          <form class="show__content__left__like unlike" action="/posts/3/likes" accept-charset="UTF-8" method="post">
            <input name="utf8" type="hidden" value="✓">
            <input type="hidden" name="authenticity_token" value="XBlI/nAe5vR8Q+zAnMogXuu3MDxpLeQ1JiMIG65m1JiVBaVTMgzqLSBoHgbxq2jgWp7IOHV37H46URMDjyFplg==">
            <input type="submit" name="commit" value="submit" class="show__content__left__like__hidden" id="unlike" data-disable-with="submit">
            <label for="unlike"><i class="far fa-heart show__content__left__like__icon"></i>
            </label><p class="show__content__left__like__nubmer">${likes.length}</p>
          </form>
            `
    $('.show__content__left').append(unlike)
  }

  $(document).on("submit", ".unlike", function(e){
    e.preventDefault();
    let href = $('.unlike').attr("action");
    $.ajax({
      url: href,
      type: "POST",
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done(function(likes){
      $(".unlike").remove()
      appendLike(likes)

    })
    .fail(function(){
      alert("失敗しました。再読込をしてもう一度お試しください")
    });
  })
  $(document).on("submit", ".like", function(e){
    e.preventDefault();
    let href = $('.like').attr("action");
    $.ajax({
      url: href,
      type: "DELETE",
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done(function(likes){
      $(".like").remove()
      appendUnlike(likes)
    })
    .fail(function(){
      alert("失敗しました。再読込をしてもう一度お試しください")
    });
  })
})