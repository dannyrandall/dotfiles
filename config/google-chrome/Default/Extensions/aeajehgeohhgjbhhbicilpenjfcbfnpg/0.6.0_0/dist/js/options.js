var settings;

settings = new Settings;

settings.ready(function(settings) {
  var checkbox, checkboxes, menu, select_menus, _i, _j, _len, _len1, _results;
  checkboxes = ['time_display', 'time_24hour', 'time_display_meridiem', 'time_animate_seperators', 'date_display'];
  select_menus = ['time_digit_transparency', 'time_border_transparency', 'date_format', 'date_position', 'bg_period'];
  for (_i = 0, _len = checkboxes.length; _i < _len; _i++) {
    checkbox = checkboxes[_i];
    $('[name="' + checkbox + '"]').prop('checked', settings[checkbox] === "1");
  }
  _results = [];
  for (_j = 0, _len1 = select_menus.length; _j < _len1; _j++) {
    menu = select_menus[_j];
    _results.push($("[name=\"" + menu + "\"]").val(settings[menu]));
  }
  return _results;
});

$('#settings-form').change(function() {
  var data, field, _i, _len, _ref;
  data = {};
  _ref = $("#settings-form").serializeArray();
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    field = _ref[_i];
    data[field.name] = field.value;
  }
  return chrome.storage.sync.set({
    "settings": data
  });
});

$(function() {
    $('.menu a').click(function(ev) {
        ev.preventDefault();
        var selected = 'selected';

        $('.mainview > *').removeClass(selected);
        $('.menu li').removeClass(selected);
        setTimeout(function() {
            $('.mainview > *:not(.selected)').css('display', 'none');
        }, 100);

        $(ev.currentTarget).parent().addClass(selected);
        var currentView = $($(ev.currentTarget).attr('href'));
        currentView.css('display', 'block');
        setTimeout(function() {
            currentView.addClass(selected);
        }, 0);

        setTimeout(function() {
            $('body')[0].scrollTop = 0;
        }, 200);
    });

    $('#launch_modal').click(function(ev) {
        ev.preventDefault();
        var modal = $('.overlay').clone();
        $(modal).removeAttr('style');
        $(modal).find('button, .close-button').click(function() {
            $(modal).addClass('transparent');
            setTimeout(function() {
                $(modal).remove();
            }, 1000);
        });

        $(modal).click(function() {
            $(modal).find('.page').addClass('pulse');
            $(modal).find('.page').on('webkitAnimationEnd', function() {
                $(this).removeClass('pulse');
            });
        });
        $(modal).find('.page').click(function(ev) {
            ev.stopPropagation();
        });
        $('body').append(modal);
    });

    $('.mainview > *:not(.selected)').css('display', 'none');
});

if(false) {
  $('<a href="#">Clear settings</a>').appendTo($('#settings')).click(function(){
    chrome.storage.sync.clear();
    window.location.reload();
    return false;
  });
}
;
