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


  $("a[name='like']").on({
      "click": function() {
        var count = $(this).next();

        if ($(this).children().hasClass("text-color")) {
          $(this).children().removeClass("text-color");
          $(this).children().addClass("text-grey");
          count.text(parseInt(count.text())-1);
        }
        else {
          $(this).children().removeClass("text-grey");
          $(this).children().addClass("text-color");
          count.text(parseInt(count.text())+1);
        }
      }
    })
  //


  $(".photo-modal").on({
    "click": function() {
      // var title = $(this).parent().find("div[name='title-post']");
      var source = $(this).find('img').attr("src");
      // var description = $(this).parent().find("div[name='description-post']")
      var title = $(this).closest(".shadow").find(".title-photo").text()
      var description = $(this).closest(".shadow").find(".description-photo").text()
      // if ($("#btn-photo").hasClass("chosen")) {
        $("#modal-photo-title").html(title);
        $("#modal-photo-body").attr("src", source)
        $("#modal-photo-description").html(description);
        $("#modal-photo").modal("toggle");
      // }
      // else {
      //   $("#modal-album-title").html(title)
      //   $("#modal-album-description").html(description)
      //   // this is for source of picture in album
      //   $("#modal-album").modal("toggle")
      // }
      console.log(title)
      console.log(description);
    }
  })

  $(".album-modal").on({
    "click": function() {
      // var title = $(this).parent().find("div[name='title-post']");
      var source = $(this).find('img').attr("src");
      // var description = $(this).parent().find("div[name='description-post']")
      var title = $(this).closest(".shadow").find(".title-album").text()
      var description = $(this).closest(".shadow").find(".description-album").text()
      // if ($("#btn-photo").hasClass("chosen")) {
        $("#modal-album-title").html(title);
        $("#modal-album-body").attr("src", source)
        $("#modal-album-description").html(description);
        $("#modal-album").modal("toggle");
      console.log(title);
      console.log(source);
      console.log(description);
    }
  })



  $("[name='follow']").on({
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


  $('#new_user').validate({
		rules: {
      'user[email]':"required",
			'user[password]': {
				required: true,
				minlength: 8
			},
		},
		messages:  {
        'user[email]':"Please enter your email!",
		    'user[password]':{
		        required:"Please enter your password!",
		        minlength:"Your password must be at least 8 characters long!"
		    },
		}
	});


  $('#sign_up_form').validate({
		rules: {
			'user[first_name]': "required",
			'user[last_name]': "required",
      'user[email]':"required",
			'user[password]': {
				required: true,
				minlength: 8
			},
			'user[password_confirmation]': {
				equalTo: "#user_password_confirmation",
				required: true
			}
		},
		messages:  {
		    'user[first_name]':"Please enter your first name!",
		    'user[last_name]':"Please enter your last name!",
        'user[email]':"Please enter your email!",
		    'user[password]':{
		        required:"Please enter your password!",
		        minlength:"Your password must be at least 8 characters long!"
		    },
		    'user[password_confirmation]':{
		        equalTo:"Password is not the same!",
		        required:"Please enter your password!"
		    },
		}
	});


  $('#edit_user').validate({
    rules: {
      'user[first_name]': "required",
			'user[last_name]': "required",
      'user[email]':"required",
      'user[current_password]': {
        required: true,
      }
    },
    messages:  {
      'user[first_name]':"Please enter your first name!",
      'user[last_name]':"Please enter your last name!",
      'user[email]':"Please enter your email!",
      'user[current_password]':"Please enter your current password!"
    },
    errorPlacement: function(error, element)
        {
                error.insertAfter( element );
         }
  });


  $('#confirmation_form').validate({
    rules: {
      'user[email]':"required"

    },
    messages:  {
        'user[email]':"Please enter your email!",
    }
  });

  $('#forgot_password_form').validate({
		rules: {
      'user[email]':"required"
		},
		messages:  {
        'user[email]':"Please enter your email!"
		}
	});


  $('#new_album,#edit_album,#edit_album_admin').validate({
    rules: {
      'photo[title]': "required",
      'photo[description]':"required"
    },
    messages:  {
      'photo[title]': "Please enter title!",
      'photo[description]':"Please enter description!"
    }
  });


  $('#new_photo,#edit_photo,#edit_photo_admin').validate({
    rules: {
      'photo[title]': "required",
      'photo[description]':"required",
      'photo[image]':{
          required:true,
          accept: "image/*"
      }
    },
    messages:  {
      'photo[title]': "Please enter title!",
      'photo[description]':"Please enter description!",
      'photo[image]':{
        required:"Please upload photo!",
        accept: "Must be an image"
      }
    }
  });


  $('#edit_user_admin').validate({
    rules: {
      'user[first_name]': "required",
      'user[last_name]': "required",
      'user[email]':"required",
    },
    messages:  {
      'user[first_name]':"Please enter your first name!",
      'user[last_name]':"Please enter your last name!",
      'user[email]':"Please enter your email!",
    },
    errorPlacement: function(error, element)
        {
                error.insertAfter( element );
         }
  });

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
