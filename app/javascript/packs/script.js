$(document).ready(function() {
  var btnPhoto = $("#btn-photo");
  var btnAlbum = $("#btn-album")
  btnPhoto.on({
    "click": function() {
      if (!btnPhoto.hasClass("chosen")) {
        btnPhoto.addClass("chosen")
        $("#photo_tab").removeClass("d-none")
        $("#album_tab").addClass("d-none")
        btnAlbum.removeClass("chosen")
      }
    }
  })

  btnAlbum.on({
    "click": function() {
      if (!btnAlbum.hasClass("chosen")) {
        btnAlbum.addClass("chosen")
        $("#photo_tab").addClass("d-none")
        $("#album_tab").removeClass("d-none")
        btnPhoto.removeClass("chosen")
      }
    }
  })

  $(".love").on({
    "click": function() {
      var icon = $(this).children("svg");
      var fill_color = icon.attr("fill");
      if (fill_color == "rgb(60, 90, 154)"){
        $(icon).attr("fill","lightgrey");
        $(this).children("span").text(parseInt($(this).children("span").text()) - 1);
      }
      else {
        $(icon).attr("fill", "rgb(60, 90, 154)");
        $(this).children("span").text(parseInt($(this).children("span").text()) + 1);
      }
    }
  })

  $("img").on({
    "click": function() {
      var title = $(this).parent().parent().find("div[name='title-post']").html();
      var source = $(this).attr("src");
      var description = $(this).parent().parent().find("div[name='description-post']").html()
      if ($("#btn-photo").hasClass("chosen")) {
        $("#modal-photo-title").html(title);
        $("#modal-photo-body").attr("src", source)
        $("#modal-photo-description").html(description);
        $("#modal-photo").modal("toggle");
      }
      else {
        $("#modal-album-title").html(title)
        $("#modal-album-description").html(description)
        // this is for source of picture in album
        $("#modal-album").modal("toggle")
      }
    }
  })

  
  $("button[name='follow']").on({
    "click": function() {
      if ($(this).hasClass("followed")) {
        $(this).removeClass("followed")
        $(this).addClass("follow")
        $(this).html("follow")
      }
      else {
        $(this).removeClass("follow")
        $(this).addClass("followed")
        $(this).html("following")
      }
    }
  })

  $("#btn-photo").on({
    "click": function() {
      $(this).addClass("fb_background")
      $("#btn-album").removeClass("fb_background")

    }
  })

  $("#btn-album").on({
    "click": function() {
      $(this).addClass("fb_background")
      $("#btn-photo").removeClass("fb_background")
    }
  })
});
function chooseTabOff() {
  $("div[name='photos-tab']").addClass("d-none");
  $("div[name='albums-tab']").addClass("d-none");
  $("div[name='followings-tab']").addClass("d-none");
  $("div[name='followers-tab']").addClass("d-none")
}
$(".tab").on({
  "click": function() {
    var others = $(".tab").not(this);
    chooseTabOff();
    $(this).removeClass("text-secondary");
    $(this).addClass("text-color");
    var tabName = $(this).attr("name") + "-tab"
    $("div[name="+tabName+"]").removeClass("d-none")
    // $("div[name=tabName]").addClass("d-block")
    others.map(function() {
      $(this).removeClass("text-color");
      $(this).addClass("text-secondary");
    })
  }
})
