var CalendarDate,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

CalendarDate = (function() {
  function CalendarDate(el) {
    this.el = el;
    this.hide = __bind(this.hide, this);
    this.update = __bind(this.update, this);
    this.position = __bind(this.position, this);
    moment.locale(navigator.language);
  }

  CalendarDate.prototype.format = function(format) {
    this.format = format;
  };

  CalendarDate.prototype.position = function(pos) {
    return this.el.classList.add(pos);
  };

  CalendarDate.prototype.update = function() {
    var error;
    try {
      return this.el.innerHTML = moment().format(this.format);
    } catch (_error) {
      error = _error;
    }
  };

  CalendarDate.prototype.hide = function() {
    return this.el.style.display = 'none';
  };

  return CalendarDate;

})();
