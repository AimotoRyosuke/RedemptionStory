$(function(){
  let i = $(".form__category__image").find(".form__category__image__box__show").length + 1;
  $(document).on("change", ".form__category__image__box", function(e){
    let t = this;
    if($(t).find(".form__category__image__box__change").length == 0){
      $(".form__category__image__box__input").attr("class", "form__category__image__box__change");
      let image = new FileReader();
      image.onload = function(e){
        $(t).prepend(`<img src=${e.target.result} class="form__category__image__box__show">`);
      }
      image.readAsDataURL(e.target.files[0]);
      $(t).children(".form__category__image__box__change").text("変更");
      $(t).append(`<p class="form__category__image__box__delete">削除</p>`)
      if($(".form__category__image").find(".form__category__image__box__show").length < 4){
        let next = `
                    <li class="form__category__image__box">
                      <input name="post[images_attributes][${i}][image]" class="form__category__image__box__hidden" type="file" id="post_images_attributes_${i}_image" accept="image/*">
                      <label class="form__category__image__box__input" for="post_images_attributes_${i}_image">クリックして<br>画像を投稿する<br>（最大５枚）</label>
                    </li>
                    `
        $(".form__category__image").append(next);
      }
      i += 1;
    } else {
      let image = new FileReader();
      image.onload = function(e){
        $(t).children(".form__category__image__box__show").attr("src", e.target.result)
      }
      image.readAsDataURL(e.target.files[0]);
    }
  });
  
  $(document).on("click", ".form__category__image__box__delete", function(){
    $(this).parent().remove();
    if($(".form__category__image").find(".form__category__image__box__show").length == 4){
      let next = `
                  <li class="form__category__image__box">
                    <input name="post[images_attributes][${i}][image]" class="form__category__image__box__hidden" type="file" id="post_images_attributes_${i}_image">
                    <label class="form__category__image__box__input" for="post_images_attributes_${i}_image">クリックして<br>画像を投稿する<br>（最大５枚）</label>
                  </li>
                  `
    $(".form__category__image").append(next);
    }
  });
});