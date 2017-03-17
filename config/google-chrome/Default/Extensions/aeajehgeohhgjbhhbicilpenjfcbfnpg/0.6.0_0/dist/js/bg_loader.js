var BgLoader;

BgLoader = (function() {
  function BgLoader() {}

  BgLoader.load = function(num_images, el, period) {
    var img, src;
    src = this.pick(num_images, period);
    img = new Image;
    img.addEventListener('load', (function(_this) {
      return function() {
        el.classList.add('loaded');
        return el.style.backgroundImage = "url('" + src + "')";
      };
    })(this));
    return img.src = src;
  };

  BgLoader.pick = function(num_images, period) {
    var picked;
    picked = Math.ceil(this.get_random(period) * num_images);
    return "images/" + picked + ".jpg";
  };

  BgLoader.get_random = function(period) {
    var divisor, seconds;
    if (period === 'tab') {
      return Math.random();
    }
    seconds = Date.now() / 1000;
    divisor = 60 * 15;
    if (period === '30min') {
      divisor = 60 * 30;
    }
    if (period === 'hourly') {
      divisor = 60 * 60;
    }
    if (period === 'daily') {
      divisor = 60 * 60 * 24;
    }
    if (period === 'weekly') {
      divisor = 60 * 60 * 24 * 7;
    }
    return this.get_seeded_random(Math.floor(seconds / divisor));
  };

  BgLoader.get_seeded_random = function(seed) {
    var x;
    x = Math.sin(seed++) * 10000;
    return x - Math.floor(x);
  };

  return BgLoader;

})();
