// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ujs
//= require mustache
//= require bootstrap/dist/js/bootstrap.min.js
//= require pubnub/web/pubnub.min.js
//= require_tree .

function subscribe(publish_key, subscribe_key, channel) {
  var requestTemplate = $('#request-template').html();
  Mustache.parse(requestTemplate);

  var pubnub = PUBNUB({
    publish_key   : publish_key,
    subscribe_key : subscribe_key
  })

  pubnub.subscribe({
    channel : channel,
    message : function(message, env, ch, timer, magic_ch) {
      var row = Mustache.render(requestTemplate, message);
      $('.requests tr.headers').after(row);
    }
  })
};