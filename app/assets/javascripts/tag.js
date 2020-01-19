$(function(){
  let i = $(".tag-box").length;
  $("#tag").keypress(function(e){
    if(e.which == 13 && $("#tag").val() == 0){
      e.preventDefault();
    } else if(e.which == 13){
      console.log("きている")
      e.preventDefault();
      let value = $("#tag").val();
      $.ajax({
        type: "GET",
        url: "/tags",
        data: { tag: value},
        dataType: "json"
      })
      .done(function(tag){
        let tag_update = tag.id ?  `<input type="hidden" value="${tag.id}" name="post[tags_attributes][${i}][id]" id="post_tags_attributes_${i}_id"></input><input type="hidden" value="${tag.id}" name="tag_ids[]" id="post_tags_attributes_${i}_id"></input>` : ("");
        let html = `<li class="tag-box">
                      <input name="post[tags_attributes][${i}][name]" value="${value}" type="text" id="post_tags_attributes_${i}_tag" class="form__category__tag__hidden"> 
                      <label for="post_tags_attributes_${i}_tag" class="form__category__tag__show">${value}</label>
                      <p class="form__category__tag__delete">×</p>
                      ${tag_update}
                    </li>`;
        $(".form__category__tag").append(html);
        $("#tag").val("");
        i += 1;
      })
      .fail(function(){
        console.log("失敗")
      });
    }
  });

  $(document).on('click', '.form__category__tag__delete', function(){
    $(this).parent().remove();
  });

  $(document).on("click", ".form__category__tag__destroy", function(){
    $(this).parent().attr("class", "tag-box--hidden")
  });
});