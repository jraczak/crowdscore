(function(){$(document).ready(function(){return $(".toggle.delete").click(function(){return $(".confirm").toggleClass("visible")}),$(".keep").click(function(){return $(".confirm").removeClass("visible")}),$(".details:not(.edit) .toggle").click(function(){return $(this).parent().siblings(".edit-card").addClass("visible"),$(this).parents(".list-card").addClass("edit")}),$(".button.cancel").click(function(){return $(this).parents(".edit-card").removeClass("visible"),$(this).parents(".new-card").removeClass("visible"),$(this).parents(".list-card").removeClass("edit")}),$(".new .create").click(function(){return $(this).parent().find(".new-card").addClass("visible"),$(this).parents(".list-card").addClass("new")})})}).call(this);