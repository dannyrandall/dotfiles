var UpgradeDetector;

UpgradeDetector = (function() {
  function UpgradeDetector() {}

  UpgradeDetector.get_extension_version = function(cb) {
    var url, xhr;
    url = chrome.extension.getURL('/manifest.json');
    xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function(e) {
      var manifest;
      if (xhr.readyState === 4 && xhr.status === 200 && xhr.responseText !== '') {
        manifest = JSON.parse(xhr.responseText);
        return typeof cb === "function" ? cb("" + manifest.version) : void 0;
      }
    };
    xhr.open('GET', url);
    return xhr.send();
  };

  UpgradeDetector.get_last_version = function(cb) {
    return chrome.storage.local.get('embark_version', (function(_this) {
      return function(obj) {
        return typeof cb === "function" ? cb("" + obj.embark_version) : void 0;
      };
    })(this));
  };

  UpgradeDetector.set_last_version = function(version) {
    return chrome.storage.local.set({
      'embark_version': version
    });
  };

  UpgradeDetector.detect = function(install, upgrade) {
    return UpgradeDetector.get_extension_version(function(version) {
      return UpgradeDetector.get_last_version(function(last) {
        if (!last) {
          if (typeof install === "function") {
            install();
          }
        } else if (last !== version) {
          if (typeof upgrade === "function") {
            upgrade();
          }
        }
        return UpgradeDetector.set_last_version(version);
      });
    });
  };

  return UpgradeDetector;

})();
