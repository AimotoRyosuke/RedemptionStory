$(function(){
  function appendRakutenItem(item, index){
    let html = `
              <li class="site__rakuten-result__list">
                <div class="site__rakuten-result__list__category">
                  <p class="site__rakuten-result__list__category__title">商品名</p>
                  <p class="site__rakuten-result__list__category__copy" id="name">クリップボードにコピー</p>
                  <a href="${item.url}" class="site__rakuten-result__list__category__content" target=”_blank”>${item.name}</a>
                </div>
                <div class="site__rakuten-result__list__category">
                  <p class="site__rakuten-result__list__category__title">商品説明</p>
                  <p class="site__rakuten-result__list__category__copy">クリップボードにコピー</p>
                  <p class="site__rakuten-result__list__category__content">${item.caption}</p>
                </div>
                <div class="site__rakuten-result__list__category">
                  <p class="site__rakuten-result__list__category__title">画像一覧</p>
                  <ul class="site__rakuten-result__list__category__images" data-id="${index}">
                  </ul>
                </div>
              </li>
              `
    $(".site__rakuten-result").append(html)
    item.images.forEach(function(image, index){
      appendImage(image, index);
    });
  }
  function appendImage(image, index){
    let id = $(".site__rakuten-result__list__category__images:last").data("id")
    let html = `
                <li class="site__rakuten-result__list__category__images__list">
                  <label for="${id}-${index}"><img src="${image}", class="site__rakuten-result__list__category__images__list__image"></label>
                  <input class="site__rakuten-result__images__list__image__checkbox" id="${id}-${index}" type="checkbox" value="${image}" name="checkbox">
                </li>
                `
    $(".site__rakuten-result__list__category__images:last").append(html)
  }
  


  $('#rakuten').on('submit', function(e){
    e.preventDefault();
    let href = $('#rakuten').attr("action");
    let rakuten_keyword = $('#rakuten-keyword').val();
    let formData = new FormData(this)
    $.ajax({
      url: href,
      type: "GET",
      data: { keyword: rakuten_keyword },
      dataType: "json",
    })
    .done(function(items){
      $(".site__rakuten-result").empty();
      $(".site__rakuten-result").append(`<p class="site__rakuten-result__title">"${items[0].keyword}"の検索結果</p>`)
      items.forEach(function(item, index){
        appendRakutenItem(item, index);
      });
      $("#rakuten")[0].reset();
      $("#rakuten-submit").removeAttr('disabled');
    })
    .fail(function(){
      alert("失敗しました。再読込をしてもう一度お試しください")
      $("#rakuten-submit").removeAttr('disabled');
    });
  });

  $(document).on("click", ".site__rakuten-result__list__category__copy", function(){
    let clipboard = $("<textarea></textarea>");
    clipboard.val($(this).next().text());
    $(this).append(clipboard);
    clipboard.select();
    document.execCommand('copy');
    clipboard.remove();
  });

  $(".btn__rakuten-search").click(function(){
    console.log($('#rakuten')[0].scrollHeight)
    $('.right').animate({ scrollTop: $('#rakuten')[0].scrollHeight})
  });

  $(".btn__rakuten-delete").click(function(){
    $(".site__rakuten-result").empty();
  });

  $(".btn__check-delete").click(function(){
    $("input:checked").prop("checked", false);
  });
});