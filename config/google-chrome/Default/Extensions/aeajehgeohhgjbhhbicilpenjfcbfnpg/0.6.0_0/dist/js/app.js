var clock, date_obj, settings;

settings = new Settings();

clock = new Clock(document.querySelectorAll('.time')[0], document.querySelectorAll('.time .inner')[0], document.querySelectorAll('.seperator')[0], document.querySelectorAll('.hours')[0], document.querySelectorAll('.minutes')[0], document.querySelectorAll('.meridiem')[0]);

date_obj = new CalendarDate(document.querySelectorAll('.date')[0]);

settings.ready(function(settings) {
  BgLoader.load(67, document.querySelectorAll('.bg')[0], settings.bg_period);
  if (settings.date_display !== '0') {
    date_obj.position(settings.date_position);
    date_obj.format(settings.date_format);
  }
  clock.time_format((settings.time_12hour === '1' ? '12hr' : '24hr'), settings.time_display_meridiem === '1');
  clock.animate_seperators(settings.time_animate_seperators === '1');
  clock.display(settings.time_display === '1');
  clock.time_opacity(settings.time_digit_transparency);
  clock.border_opacity(settings.time_border_transparency);
  return clock.start(function() {
    return date_obj.update();
  });
});

UpgradeDetector.detect();


// Standard Google Universal Analytics code
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga'); // Note: https protocol here

ga('create', 'UA-4950473-4', 'auto');
ga('set', 'checkProtocolTask', function(){});
ga('send', 'pageview', '/embark.html');
;
